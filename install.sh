#!/bin/sh
set -e

SYSTEM_VENDOR=$(sudo dmidecode -s system-manufacture)
DOTFILE_HOME="$HOME/.dotfiles"

# essential package pruge and installation
sudo apt-get -y autoremove
sudo apt-get -y purge gedit vim-common firefox evince
sudo rm -rf /etc/firefox /usr/lib/firefox /usr/lib/firefox-addons

sudo mv /etc/apt/sources.list /etc/apt/sources.list.orig
sudo cp $DOTFILE_HOME/apt/sources.list /etc/apt/sources.list
sudo apt-get -y update
sudo apt-get -y upgrade

sudo apt-get -y install vim curl git zsh network-manager-openconnect-gnome

# git configuration
ln -s $DOTFILE_HOME/git/gitconfig $HOME/.gitconfig

# vim environment configuration
mkdir -p $HOME/.vim/autoload
mkdir -p $HOME/.vim/custom
mkdir -p $HOME/.vim/temp/undo
ln -s $DOTFILE_HOME/vim $HOME/.vim/vimrcs
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
cat > $HOME/.vim/vimrc << _EOF
source ~/.vim/vimrcs/plugins.vim
source ~/.vim/vimrcs/basic.vim
source ~/.vim/vimrcs/custom.vim
_EOF

# install google-chrome
wget -O $HOME/Downloads/google-chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i $HOME/Downloads/google-chrome.deb
rm $HOME/Downloads/google-chrome.deb

# mpv installation
sudo add-apt-repository ppa:mc3man/mpv-tests -y
sudo apt-get update
sudo apt-get -y install mpv

# wps installation
wget -O $HOME/Downloads/wps-office.deb http://kdl.cc.ksosoft.com/wps-community/download/8865/wps-office_11.1.0.8865_amd64.deb
sudo dpkg -i $HOME/Downloads/wps-office.deb
rm $HOME/Downloads/wps-office.deb
sudo cp $DOTFILE_HOME/wps/* /usr/share/fonts/wps-office
sudo fc-cache -vfs

# system setting for mac only
if [ $SYSTEM_VENDOR = "Apple Inc." ]; then
  # install xkbset pakcage for key mapping
  sudo apt-get install xkbset

  # screen resolution setting
  RES="2000 1250" && \
  RATE="60" && \
  DISP=$(xrandr | grep -e " connected [^(]" | sed -e "s/\([A-Z0-9]\+\) connected.*/\1/") && \
  MODELINE=$(cvt $(echo $RES $RATE) | grep -e "Modeline [^(]" | sed -r 's/.*Modeline (.*)/\1/') && \
  MODERES=$(echo $MODELINE | grep -o -P '(?<=").*(?=")') && \
  echo "#!/bin/sh" >> $HOME/.xprofile
  echo "xrandr --newmode $MODELINE" >> $HOME/.xprofile
  echo "xrandr --addmode $DISP $MODERES" $HOME/.xprofile

  # keyboard setting: swap cmd and alt keys
  echo options hid_apple swap_opt_cmd=1 | sudo tee -a /etc/modprobe.d/hid_apple.conf
  # keyboard setting: enable f1, f2, ... keys
  echo options hid_apple fnmode=2 | sudo tee -a /etc/modprobe.d/hid_apple.conf
  sudo update-initramfs -u -k all

  # power management tunning
  sudo cp $DOTFILE_HOME/pm/lid_wakeup_disable /lib/systemd/system-sleep/lid_wakeup_disable
  sudo cp $DOTFILE_HOME/pm/network_hack_hibernation /lib/systemd/system-sleep/network_hack_hibernation

  # disable Wayland and use Xorg as GUI manager
  sudo sed -i '/WaylandEnable=false/s/^#//g' /etc/gdm3/custom.conf
fi

echo "----- ubuntu installation post configuration work done! -----"

# install oh my zsh
# sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# ln -s $HOME/Workspace/dotfiles/omzsh/profile.zsh $HOME/.oh-my-zsh/custom/profile.zsh
# ln -s $HOME/Workspace/dotfiles/omzsh/134key.zsh $HOME/.oh-my-zsh/custom/134key.zsh

