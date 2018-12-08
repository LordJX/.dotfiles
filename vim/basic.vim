"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sections:
"    -> 00. General
"    -> 01. User interface
"    -> 02. Colors and Fonts
"    -> 03. Files and backups
"    -> 04. Text, tab and indent related
"    -> 05. Visual mode related
"    -> 06. Moving around, tabs and buffers
"    -> 07. Status line
"    -> 08. Editing mappings
"    -> 09. Misc
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => 00. General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" :W sudo saves the file
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => 01. User interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Avoid garbled characters in Chinese language windows OS
let $LANG='en' 
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Turn on the Wild menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32") || has("win64")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch
map <C-n> :nohl<cr>

" Makes search act like search in modern browsers
set incsearch 

" Don't redraw while executing macros (good performance config)
set lazyredraw 

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch 

" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Show absolute/relative line number
set number relativenumber
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Add a bit extra margin to the left
"set foldcolumn=1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => 02. Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable 

set background=dark

" Set vim color scheme 
try
    colorscheme solarized
    "colorscheme pencil
catch
endtry

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Enable italicised comments in vim
highlight Comment cterm=italic


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => 03. Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

"if has('persistent_undo')
"    set undodir=~/.vim/temp/undo
"    set undofile
"endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => 04. Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines


""""""""""""""""""""""""""""""
" => 05. Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => 06. Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <c-space> ?

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
map <leader>ba :bufdo bd<cr>

map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
map <leader>t<leader> :tabnext 

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


""""""""""""""""""""""""""""""
" => 07. Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" -- INSERT -- is unnecessary anymore
set noshowmode

" Enable and setup lightline
let g:lightline = {
    \ 'colorscheme': 'solarized',
    \ 'active': {
    \   'left':  [ [ 'mode', 'paste' ],
    \        [ 'fugitive', 'readonly', 'filename', 'modified', 'spell' ] ],
    \   'right': [ [ 'lineinfo' ], 
    \              ['percent'], 
    \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
    \ },
    \ 'inactive': {
    \   'left':  [ [ 'filename' ] ],
    \   'right': [ [ 'lineinfo' ],
    \              [ 'percent' ] ] 
    \ },
    \ 'component': {
    \   'lineinfo': '%l:%-2v',
    \   'spell': '%{ &spell ? &spelllang : "" }',
    \   'modified': '%{ &filetype=="help" ? "" : &modified ? "\uf8ea" : &modifiable ? "" : "\uf8ed" }',
    \ },
    \ 'component_visible_condition': {
    \   'readonly': '(&filetype != "help" && &readonly)',
    \   'modified': '(&filetype != "help" && (&modified || !&modifiable))',
    \ },
    \ 'component_function': {
    \   'readonly': 'LightlineReadonly',
    \   'fugitive': 'LightlineFugitive',
    \   'fileformat': 'LightlineFileformat',
    \   'filetype': 'LightlineFiletype',
    \	'fileencoding': 'LightlineFileencoding'
    \ },
    \ 'separator': { 'left': "\ue0b8", 'right': "\ue0be" },
	\ 'subseparator': { 'left': "\ue0b9", 'right': "\ue0bf" },
    \ 'tabline': {
    \   'left':  [ [ 'tabs' ] ],
    \   'right': [ [ 'close' ] ] 
    \ },
    \ 'tab': {
    \   'active':   [ 'tabnum', 'filename', 'modified' ],
    \   'inactive': [ 'tabnum', 'filename', 'modified' ] 
    \ },
    \ 'tab_component': {},
    \ 'tab_component_function': {
    \   'modified': 'LightlineTabModified'
    \ },
    \ 'tabline_separator': { 'left': "", 'right': "" },
	\ 'tabline_subseparator': { 'left': "|", 'right': "|" }
\ }

function! LightlineReadonly()
    return &readonly ? '' : ''
endfunction

function! LightlineFugitive() abort
    if &filetype ==# 'help'
        return ''
    endif
    if has_key(b:, 'lightline_fugitive') && reltimestr(reltime(b:lightline_fugitive_)) =~# '^\s*0\.[0-5]'
        return b:lightline_fugitive
    endif
    try
        if exists('*fugitive#head')
            let head = fugitive#head()
        else
            return ''
        endif
        let b:lightline_fugitive = head !=# '' ? "\ue0a0 ".head : ''
        let b:lightline_fugitive_ = reltime()
        return b:lightline_fugitive
    catch
    endtry
    return ''
endfunction

function! LightlineFileformat()
  return winwidth(0) > 80 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'N/A') : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineTabModified(n) abort
    let winnr = tabpagewinnr(a:n)
    return gettabwinvar(a:n, winnr, '&modified') ? "\uf8ea" : gettabwinvar(a:n, winnr, '&modifiable') ? '' : "\uf8ed"
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => 08. Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
"map 0 ^

" Disable arrow key, use hjkl instead
map <Left>  <Nop>
map <Right> <Nop>
map <Up>    <Nop>
map <Down>  <Nop>

" Enable jk to exit insert mode
imap jk <Esc>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => 09. Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Quickly open a buffer for scribble
map <leader>q :e ~/buffer<cr>

" Quickly open a markdown buffer for scribble
map <leader>x :e ~/buffer.md<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>
