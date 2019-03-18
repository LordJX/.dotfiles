#!/bin/sh
set -e

export DOTFILE_HOME="$HOME/.dotfiles"

# ------ git configuration -------------------------------------
ln -s $DOTFILE_HOME/git/gitconfig $HOME/.gitconfig
echo "Git Configuration Done!\n"

# ------ oh-my-zsh environment ---------------------------------
ln -s $DOTFILE_HOME/omzsh/profile.zsh $HOME/.oh-my-zsh/custom/profile.zsh
echo "oh-my-zsh Configuration Done!\n"

# ------ tmux configuration  -----------------------------------
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln -s $DOTFILE_HOME/tmux/tmux.conf $HOME/.tmux.conf
echo "Tmux Configuration Done!\n"

# ------ vim environment ----------------------------------------
mkdir -p $HOME/.vim/{autoload,vimrcs,custom,temp/undo}

ln -s $DOTFILE_HOME/vim/basic.vim $HOME/.vim/vimrcs/basic.vim
ln -s $DOTFILE_HOME/vim/plugins.vim $HOME/.vim/vimrcs/plugins.vim
ln -s $DOTFILE_HOME/vim/custom.vim $HOME/.vim/vimrcs/custom.vim

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "
source ~/.vim/vimrcs/plugins.vim
source ~/.vim/vimrcs/basic.vim
source ~/.vim/vimrcs/custom.vim
" > ~/.vim/vimrc

echo "Vim Configuration Done!\n"
echo "Dotfiles Configuration Installed Successfully!\n "


