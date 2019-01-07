#!/bin/sh
set -e

export DOTFILE_HOME="$HOME/.dotfiles"

# ------ install fonts -----------------------------------------
cp -R $DOTFILE_HOME/fonts/SourceCodePro $HOME/Library/Fonts/
echo "Nerd Fonts Installed!\n"

# ------ git configuration -------------------------------------
ln -s $DOTFILE_HOME/git/gitconfig $HOME/.gitconfig
echo "Git Configuration Done!\n"

# ------ oh-my-zsh environment ---------------------------------
mkdir $HOME/.oh-my-zsh/custom/lib
ln -s $DOTFILE_HOME/omzsh/history.zsh $HOME/.oh-my-zsh/custom/lib/history.zsh
ln -s $DOTFILE_HOME/omzsh/profile.zsh $HOME/.oh-my-zsh/custom/profile.zsh
echo "oh-my-zsh Configuration Done!\n"

# ------ iterm2 configuration ----------------------------------
tic $DOTFILE_HOME/iterm2/xterm-256color-italic.terminfo
tic $DOTFILE_HOME/iterm2/tmux.terminfo
echo "Xterm-256-intalic Configuration Done!\n"

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

# ------ manual configuration steps required -------------------
echo "Below are some manual configuration steps required:\n"

echo "1) Choose the theme and font for iterm2 you like.\n"

echo "2) Run vim PlugInstall command to install plugs.\n"

