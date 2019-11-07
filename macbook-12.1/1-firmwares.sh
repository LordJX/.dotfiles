#!/bin/sh
set -e

# connect to wifi
sudo ip link set wlp3s0 up
sudo su -c 'wpa_supplicant -B -i wlp3s0 -c <(wpa_passphrase UNICORN joy@0825)'
sudo dhclient wlp3s0

# disable bluetooth sap plugin 
sudo sed -i '/ExecStart=/s/$/ --noplugin=sap/' /lib/systemd/system/bluetooth.service

# install firmwares
sudo apt-get install firmware-misc-nonfree
sudo apt-get install intel-microcode

sudo sed -i '/GRUB_CMDLINE_LINUX_DEFAULT=/s/"quiet"/"quiet rootflags=data=writeback libata.force=noncq acpi_osi=Darwin"/' /etc/default/grub
sudo update-grub2