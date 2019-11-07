" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/custom')



" ----- Make Sure You Use Single Quotes

" gruvbox theme, https://github.com/morhetz/gruvbox
"Plug 'morhetz/gruvbox'

" vim tmux navigator, https://github.com/christoomey/vim-tmux-navigator
"Plug 'christoomey/vim-tmux-navigator'



" Initialize plugin system
call plug#end()
