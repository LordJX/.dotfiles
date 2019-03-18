" sets how many lines of history vim has to remember
set history=500

" enable filetype plugins
filetype plugin on
filetype indent on

" set to auto read when a file is changed from the outside
set autoread

" set ',' as the <leader> key
let mapleader = ","

" set utf8 as standard encoding
set encoding=utf8

" use unix as the standard file type
set ffs=unix,dos,mac

" turn backup off, since most stuff is in git
set nobackup
set nowb
set noswapfile

" locate the viminfo file to vim temp directory
set viminfo+=n~/.vim/temp/viminfo

" enable undo even file closed
"if has('persistent_undo')
"  set undodir=~/.vim/temp/undo
"  set undofile
"endif

" set head/foot scroll margin to 7 lines
set scrolloff=7

" height of the command bar
set cmdheight=2

" Add a bit extra margin to the left
"set foldcolumn=1

" turn on the wild menu
set wildmenu

" always show current position
set ruler

" configure backspace so it acts as it should act
set backspace=eol,start,indent

" wrap left and right
set whichwrap+=<,>,h,l

" ignore case when searching
set ignorecase

" when searching try to be smart about cases
set smartcase

" highlight search results
set hlsearch

" makes search act like search in modern browsers
set incsearch

" show matching brackets when text indicator is over them
set showmatch

" how many tenths of a second to blink when matching brackets
set mat=2

" show absolute/relative line number
set number relativenumber
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" enable syntax highlighting
syntax enable

" set vim background theme
set background=dark

" set color scheme
try
  colorscheme gruvbox
endtry

" use spaces instead of tabs
set expandtab

" be smart when using tabs ;)
set smarttab

" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2

" linebreak on 500 characters
set linebreak
set textwidth=500

" set indent behavia
set autoindent  "Auto indent
set smartindent "Smart indent
set wrap        "Wrap lines

" no annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=

" set timeoutlen to 500
set timeoutlen=500

" don't redraw while executing macros (good performance config)
set lazyredraw

" for regular expressions turn magic on
set magic

" disable highlight when <leader><cr> is pressed
noremap <silent> <leader><cr> :noh<cr>

" fast saving
nmap <leader>w :w!<cr>

" :W sudo saves the file
command W w !sudo tee % > /dev/null

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" open file explorer when <leader>e is pressed
noremap <silent> <leader>f :E<cr>

" disable arrow key, use hjkl instead
map <Left>  <Nop>
map <Right> <Nop>
map <Up>    <Nop>
map <Down>  <Nop>

" enable jk to exit insert mode
imap jk <Esc>

" map F2 to ToggleBackground() function
map <F2> :call ToggleBackground()<CR>

" quickly open a buffer for scribble
map <leader>n :e ~/.vim/temp/buffer<cr>

" quickly open a markdown buffer for scribble
map <leader>nm :e ~/.vim/temp/buffer.md<cr>

" a buffer becomes hidden when it is abandoned
set hidden

" smart way to move between windows
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" open new split panes to right and bottom
set splitbelow
set splitright


" ------------------------------------------------------------
" Advanced
" ------------------------------------------------------------

" visual mode pressing * or # searches for the current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" remove trailling whitespace on save
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()


" ------------------------------------------------------------
" Function
" ------------------------------------------------------------

" toggle background and update lightline color scheme
function! ToggleBackground()
  let &background = ( &background == "dark"? "light" : "dark" )
  if exists("g:colors_name")
    exe "colorscheme " . g:colors_name
  endif
endfunction

