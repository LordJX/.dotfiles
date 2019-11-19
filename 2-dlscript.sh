#!/bin/sh
set -e

if [ "${1}" = "dell" ]; then
  wificard="wlp2s0"
elif [ "${1}" = "macbook" ]; then
  wificard="wlp3s0"
else
  echo "Wrong input, please input 'dell/macbook'. "
  exit -1
fi

# connect to wifi
sudo ip link set ${wificard} up
sudo su -c "wpa_supplicant -B -i ${wificard} -c <(wpa_passphrase UNICORN joy@0825)"
sudo dhclient ${wificard}

# install git
sudo apt-get install --no-install-recommends git ca-certificates

# download install package
git clone https://github.com/lordjx/dotfiles $HOME/.dotfiles

sudo reboot