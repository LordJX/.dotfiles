#!/bin/sh
set -e

# setup the vim directory tree
mkdir -p ~/.vim/{autoload,vimrcs,custom,temp/undo}

# link vim configuration files
ln -s ~/Workspace/dotfiles/vim/basic.vim ~/.vim/vimrcs/basic.vim
ln -s ~/Workspace/dotfiles/vim/plugins.vim ~/.vim/vimrcs/plugins.vim
ln -s ~/Workspace/dotfiles/vim/custom.vim ~/.vim/vimrcs/custom.vim

# install vim-plug plugins mangement
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# create .vimrc file
echo "
source ~/.vim/vimrcs/plugins.vim
source ~/.vim/vimrcs/basic.vim
source ~/.vim/vimrcs/custom.vim
" > ~/.vim/vimrc

echo ""
echo "Installed the vim configuration successfully! Enjoy :-)"

