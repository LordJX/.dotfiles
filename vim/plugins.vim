" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/custom')



" Make sure you use single quotes

" solarized theme, https://github.com/altercation/vim-colors-solarized
Plug 'altercation/vim-colors-solarized'

" gruvbox theme, https://github.com/morhetz/gruvbox.git
" Plug 'morhetz/gruvbox'

" lightline, https://github.com/itchyny/lightline.vim
Plug 'itchyny/lightline.vim'

" fugitive, https://github.com/tpope/vim-fugitive.git
Plug 'tpope/vim-fugitive'



" Initialize plugin system
call plug#end()
