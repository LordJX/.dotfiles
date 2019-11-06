#!/bin/sh
set -e

# connect to wifi
sudo ip link set wlp3s0 up
sudo su -c 'wpa_supplicant -B -i wlp3s0 -c <(wpa_passphrase UNICORN joy@0825)'
sudo dhclient wlp3s0

# update sources.list and upgrade system
sudo mv /etc/apt/sources.list /etc/apt/sources.list.save

# buster release
#echo 'deb http://mirrors.163.com/debian/ buster main non-free contrib' | sudo tee -a /etc/apt/sources.list
#echo 'deb http://mirrors.163.com/debian/ buster-updates main non-free contrib' | sudo tee -a /etc/apt/sources.list
#echo 'deb http://mirrors.163.com/debian/ buster-backports main non-free contrib' | sudo tee -a /etc/apt/sources.list
#echo 'deb-src http://mirrors.163.com/debian/ buster main non-free contrib' | sudo tee -a /etc/apt/sources.list
#echo 'deb-src http://mirrors.163.com/debian/ buster-updates main non-free contrib' | sudo tee -a /etc/apt/sources.list
#echo 'deb-src http://mirrors.163.com/debian/ buster-backports main non-free contrib' | sudo tee -a /etc/apt/sources.list
#echo 'deb http://mirrors.163.com/debian-security/ buster/updates main non-free contrib' | sudo tee -a /etc/apt/sources.list
#echo 'deb-src http://mirrors.163.com/debian-security/ buster/updates main non-free contrib' | sudo tee -a /etc/apt/sources.list

# bullseye release
echo 'deb http://mirrors.163.com/debian/ bullseye main non-free contrib' | sudo tee -a /etc/apt/sources.list
echo 'deb-src http://mirrors.163.com/debian/ bullseye main non-free contrib' | sudo tee -a /etc/apt/sources.list

sudo apt-get autoremove
sudo apt-get update 
sudo apt-get upgrade 
sudo apt-get dist-upgrade 