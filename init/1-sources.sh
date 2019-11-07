#!/bin/sh
set -e

if [ "${1}" = "dell" ]; then
  wificard="wlp2s0"
elif [ "${1}" = "macbook" ]; then
  wificard="wlp3s0"
else
  echo "Wrong usage.  Please input dell/macbook as argument. "
  exit -1
fi

# connect to wifi
sudo ip link set ${wificard} up
sudo su -c "wpa_supplicant -B -i ${wificard} -c <(wpa_passphrase UNICORN joy@0825)"
sudo dhclient ${wificard}

# update sources.list and upgrade system
sudo mv /etc/apt/sources.list /etc/apt/sources.list.save

## stable release (buster)
#echo 'deb http://mirrors.163.com/debian/ buster main non-free contrib' | sudo tee -a /etc/apt/sources.list
#echo 'deb http://mirrors.163.com/debian/ buster-updates main non-free contrib' | sudo tee -a /etc/apt/sources.list
#echo 'deb http://mirrors.163.com/debian/ buster-backports main non-free contrib' | sudo tee -a /etc/apt/sources.list
#echo 'deb-src http://mirrors.163.com/debian/ buster main non-free contrib' | sudo tee -a /etc/apt/sources.list
#echo 'deb-src http://mirrors.163.com/debian/ buster-updates main non-free contrib' | sudo tee -a /etc/apt/sources.list
#echo 'deb-src http://mirrors.163.com/debian/ buster-backports main non-free contrib' | sudo tee -a /etc/apt/sources.list
#echo 'deb http://mirrors.163.com/debian-security/ buster/updates main non-free contrib' | sudo tee -a /etc/apt/sources.list
#echo 'deb-src http://mirrors.163.com/debian-security/ buster/updates main non-free contrib' | sudo tee -a /etc/apt/sources.list

# testing release (bullseye)
echo 'deb http://mirrors.163.com/debian/ bullseye main non-free contrib' | sudo tee -a /etc/apt/sources.list
echo 'deb-src http://mirrors.163.com/debian/ bullseye main non-free contrib' | sudo tee -a /etc/apt/sources.list

sudo apt-get update
sudo apt-get upgrade
sudo apt-get dist-upgrade
sudo apt-get autoremove

sudo reboot