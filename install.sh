#!/bin/sh
set -e

# ------ install fonts -----------------------------------------
cp -R $HOME/Documents/dotfiles/fonts/SourceCodePro~/Library/Fonts/
echo "Fonts Installed!"
echo ""

# ------ git configuration -------------------------------------
mkdir ~/.dotfiles
ln -s ~/Documents/dotfiles/git/gitconfig ~/.dotfiles/gitconfig
ln -s ~/Documents/dotfiles/git/gitignore ~/.dotfiles/gitignore
ln -s .dotfiles/gitconfig ~/.gitconfig
echo "Git Configuration Done!"
echo ""

# ------ iterm2 configuration ----------------------------------
tic ~/Documents/dotfiles/iterm2/xterm-256color-italic.terminfo
echo "Xterm-256-intalic Configuration Done!"
echo ""

# ------ oh-my-zsh environment ---------------------------------
ln -s ~/Documents/dotfiles/omzsh/profile.zsh ~/.oh-my-zsh/custom/profile.zsh
ln -s ~/Documents/dotfiles/omzsh/pyvenvwrapper.zsh ~/.oh-my-zsh/custom/pyvenvwrapper.zsh
echo "oh-my-zsh Configuration Done!"
echo ""

# ------ tmux configuration  -----------------------------------
ln -s ~/Documents/dotfiles/tmux/tmux.conf ~/.dotfiles/tmux.conf
ln -s ~/Documents/dotfiles/tmux/tmux.conf.local ~/.dotfiles/tmux.conf.local
ln -s .dotfiles/tmux.conf ~/.tmux.conf
echo "Tmux Configuration Done!"
echo ""

# ------ vim environment ----------------------------------------
# setup the vim directory tree
mkdir -p ~/.vim/{autoload,vimrcs,custom,temp/undo}

# link vim configuration files
ln -s ~/Documents/dotfiles/vim/basic.vim ~/.vim/vimrcs/basic.vim
ln -s ~/Documents/dotfiles/vim/plugins.vim ~/.vim/vimrcs/plugins.vim
ln -s ~/Documents/dotfiles/vim/custom.vim ~/.vim/vimrcs/custom.vim

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
echo "Vim configuration Done! 
echo "Everythong setup successfully, Enjoy :-)"

# ------ manual configuration steps required -------------------
echo "Below are some manual configuration required:"
echo ""
echo "1) Choose the theme and font for iterm2 you like."
echo ""
echo "2) Run vim PlugInstall command to install plugs."
echo ""
