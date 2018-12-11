" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/custom')



" ----- Make Sure You Use Single Quotes 

" solarized theme, https://github.com/altercation/solarized
Plug 'altercation/vim-colors-solarized'

" gruvbox theme, https://github.com/morhetz/gruvbox
Plug 'morhetz/gruvbox'

" lightline, https://github.com/itchyny/lightline.vim
Plug 'itchyny/lightline.vim'

" fugitive, https://github.com/tpope/vim-fugitive.git
Plug 'tpope/vim-fugitive'

" nerdtree, https://github.com/scrooloose/nerdtree
Plug 'scrooloose/nerdtree'

" surround, https://github.com/tpope/vim-surround
Plug 'tpope/vim-surround'



" Initialize plugin system
call plug#end()
