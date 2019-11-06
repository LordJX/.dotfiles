#!/bin/sh
set -e

# connect to wifi
sudo ip link set wlp2s0 up
sudo su -c 'wpa_supplicant -B -i wlp2s0 -c <(wpa_passphrase UNICORN joy@0825)'
sudo dhclient wlp2s0

# disable bluetooth sap plugin
sudo sed -i '/ExecStart=/s/$/ --noplugin=sap/' /lib/systemd/system/bluetooth.service

# install firmwares
sudo apt-get install firmware-misc-nonfree
sudo apt-get install intel-microcode

# blacklist nouveau module
echo '# do not load nouveau module' | sudo tee -a /etc/modprobe.d/blacklist-nouveau.conf
echo 'blacklist nouveau' | sudo tee -a /etc/modprobe.d/blacklist-nouveau.conf

sudo sed -i '/GRUB_CMDLINE_LINUX_DEFAULT=/s/"quiet"/"quiet pci=nommconf nouveau.modeset=0"/' /etc/default/grub
sudo update-grub2
