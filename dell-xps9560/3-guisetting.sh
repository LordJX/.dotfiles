#!/bin/sh
set -e

DOTFILE_HOME="$HOME/.dotfiles"

# git configuration
ln -s $DOTFILE_HOME/common/git $HOME/.git
ln -s $HOME/.git/gitconfig $HOME/.gitconfig

# vim environment configuration
mkdir -p $HOME/.vim/autoload
mkdir -p $HOME/.vim/custom
mkdir -p $HOME/.vim/temp/undo
ln -s $DOTFILE_HOME/common/vim $HOME/.vim/vimrcs
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
cat > $HOME/.vim/vimrc << _EOF
source ~/.vim/vimrcs/plugins.vim
source ~/.vim/vimrcs/basic.vim
source ~/.vim/vimrcs/custom.vim
_EOF

# install oh my zsh
# sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# ln -s $HOME/.dotfiles/common/omzsh/profile.zsh $HOME/.oh-my-zsh/custom/profile.zsh

