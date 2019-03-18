#!/bin/sh
set -e

export DOTFILE_HOME="$HOME/.dotfiles"

# ------ git configuration -------------------------------------
rm $HOME/.gitconfig

# ------ oh-my-zsh environment ---------------------------------
rm $HOME/.oh-my-zsh/custom/profile.zsh

# ------ tmux configuration  -----------------------------------
rm $HOME/.tmux.conf
rm -rf $HOME/.tmux

# ------ vim environment ----------------------------------------
rm -rf $HOME/.vim
