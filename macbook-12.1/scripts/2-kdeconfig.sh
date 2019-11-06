#!/bin/sh
set -e

# connect to wifi
sudo ip link set wlp3s0 up
sudo su -c 'wpa_supplicant -B -i wlp3s0 -c <(wpa_passphrase UNICORN joy@0825)'
sudo dhclient wlp3s0

## set locale
echo 'zh_CN.UTF-8 UTF-8' | sudo tee -a /etc/locale.gen
sudo locale-gen
echo LANG=en_US.UTF-8 | sudo tee -a /etc/locale.conf
export LANG=en_US.UTF-8

# create swap file
sudo fallocate -l 8G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
echo '#load /swapfile' | sudo tee -a /etc/fstab
echo '/swapfile		none		swap		sw		0	0' | sudo tee -a /etc/fstab

# trim ssd to imporve performance
sudo systemctl start fstrim.timer
sudo systemctl enable fstrim.timer

# install Xwin system
sudo apt-get install --no-install-recommends \
	xserver-xorg xinit libgl1-mesa-dri

# install plasma desktop
sudo apt-get install --no-install-recommends \
	dolphin kimageformat-plugins kdialog kio-extras konsole \
	\
	plasma-desktop bluedevil fonts-hack fonts-noto fonts-noto-cjk \
	breeze-gtk-theme kde-config-gtk-style kde-config-gtk-style-preview kde-config-screenlocker \
	kde-config-sddm kde-style-oxygen-qt5 kgamma5 khelpcenter man-db khotkeys kinfocenter \
	kio kio-extras kmenuedit kscreen ksshaskpass ksysguard kwin-x11 \
	libpam-kwallet5 plasma-pa powerdevil systemsettings user-manager \
	\
	plasma-workspace kde-cli-tools plasma-widgets-addons libpam-kwallet5 powerdevil \
	\
	udisks2 dosfstools e2fsprogs exfat-fuse exfat-utils libblockdev-crypto2 ntfs-3g policykit-1 \
	\
	upower policykit-1 \
	\
	kwin-x11 sddm haveged libpam-systemd desktop-base kdeconnect

# fonts configration depended on fonts-noto package
sudo cp ../fonts/* /usr/share/fontconfig/conf.avail/

# install essential packages
sudo apt-get install --no-install-recommends \
    network-manager network-manager-openconnect plasma-nm \
    pulseaudio plasma-pa \
    bluez pulseaudio-module-bluetooth bluedevil \
    fcitx fcitx-googlepinyin im-config kde-config-fcitx fcitx-frontend-qt5 fcitx-ui-classic

sudo apt-get purge vim-common vim-tiny

sudo apt-get install --no-install-recommends \
    zsh git curl ca-certificates \
    chromium chromium-sandbox \
    mpv

sudo apt-get autoremove
