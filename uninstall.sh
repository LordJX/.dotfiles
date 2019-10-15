#!/bin/sh
set -e

# recover apt sources.list
sudo rm /etc/apt/sources.list
sudo mv /etc/apt/sources.list.orig /etc/apt/sources.list
sudo apt-get update

# git configuration remove
rm $HOME/.gitconfig

# vim configuration remove
rm -rf $HOME/.vim

# screen resolution setting remove
rm $HOME/.xprofile
