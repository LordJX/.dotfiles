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

# disable bluetooth sap plugin
sudo sed -i '/ExecStart=/s/$/ --noplugin=sap/' /lib/systemd/system/bluetooth.service

# install firmwares
sudo apt-get install firmware-misc-nonfree
sudo apt-get install intel-microcode

if [ "${1}" = "dell" ]; then
  echo '# do not load nouveau module' | sudo tee -a /etc/modprobe.d/blacklist-nouveau.conf
  echo 'blacklist nouveau' | sudo tee -a /etc/modprobe.d/blacklist-nouveau.co  
  
  sudo sed -i '/GRUB_CMDLINE_LINUX_DEFAULT=/s/"quiet"/"quiet pci=nommconf nouveau.modeset=0"/' /etc/default/grub
else
  sudo sed -i '/GRUB_CMDLINE_LINUX_DEFAULT=/s/"quiet"/"quiet rootflags=data=writeback libata.force=noncq acpi_osi=Darwin"/' /etc/default/grub
fi

sudo update-grub2
