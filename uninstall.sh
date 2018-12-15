#!/bin/sh
set -e

export DOTFILE_HOME="$HOME/.dotfiles"

# ------ install fonts -----------------------------------------
rm -rf $HOME/Library/Fonts/SourceCodePro

# ------ git configuration -------------------------------------
rm $HOME/.gitconfig

# ------ iterm2 configuration ----------------------------------
rm -rf $HOME/.terminfo

# ------ oh-my-zsh environment ---------------------------------
rm -rf $HOME/.oh-my-zsh/custom/lib
rm $HOME/.oh-my-zsh/custom/profile.zsh

# ------ tmux configuration  -----------------------------------
rm $HOME/.tmux.conf
rm -rf $HOME/.tmux

# ------ vim environment ----------------------------------------
rm -rf $HOME/.vim
