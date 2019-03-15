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
if has('persistent_undo')
  set undodir=~/.vim/temp/undo
  set undofile
endif

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

" enable italicised comments in vim
"autocmd ColorScheme * highlight Comment cterm=italic

" enable syntax highlighting
syntax enable

" set vim color scheme
try
  colorscheme gruvbox
endtry

" set vim background theme
set background=dark

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
map <leader>q :e ~/buffer<cr>

" quickly open a markdown buffer for scribble
map <leader>x :e ~/buffer.md<cr>

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

" useful mappings for managing tabs
map <silent> <leader>tt :tabnew<cr>
map <silent> <leader>to :tabonly<cr>
map <silent> <leader>tc :tabclose<cr>
map <silent> <leader>tm :tabmove<cr>
map <silent> <leader>tn :tabnext<cr>

" let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <silent> <leader>tl :exe "tabn ".g:lasttab<CR>
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

" toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

" ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32") || has("win64")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif



" -----------------------------------------------------
" Status line
" -----------------------------------------------------

" Always show the status line
set laststatus=2

" -- INSERT -- is unnecessary anymore
set noshowmode

" Enable and setup lightline
let g:lightline = {
    \ 'colorscheme': 'gruvbox',
    \ 'active': {
    \     'left':  [ [ 'mode', 'paste' ],
    \                [ 'fugitive', 'filename' ] ],
    \     'right': [ [ 'position' ],
    \                [ 'filetype', 'fileencoding' ] ]
    \ },
    \ 'inactive': {
    \     'left':  [ [ 'filename' ] ],
    \     'right': [ [ 'position' ] ]
    \ },
    \ 'component_function': {
    \     'filename':     'LightlineFilename',
    \     'filetype':     'LightlineFiletype',
    \     'fileencoding': 'LightlineFileEncodingFormat',
    \     'mode':         'LightlineMode',
    \     'lineinfo':     'LightlineLineinfo',
    \     'position':     'LightlinePosition',
    \     'modified':     'LightlineModified',
    \ },
    \ 'separator':    { 'left': "\ue0b8", 'right': "\ue0be" },
    \ 'subseparator': { 'left': "\ue0b9", 'right': "\ue0bf" },
    \ 'tab': {
    \     'active':   [ 'tabnum', 'filename', 'modified', 'readonly' ],
    \     'inactive': [ 'tabnum', 'filename', 'modified', 'readonly' ]
    \ },
    \ 'tab_component_function': {
    \     'filename': 'TablineFilename',
    \     'modified': 'TablineModified',
    \     'readonly': 'TablineReadonly',
    \ },
    \ 'tabline_separator':    { 'left': "",  'right': "" },
    \ 'tabline_subseparator': { 'left': "|", 'right': "|" }
\ }

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

function! LightlineModified()
  return &ft =~ 'help' ? '' : &modified ? "\uf8ea" : ''
endfunction

function! LightlineReadonly()
  return &ft !~? 'help' && &readonly ? "\ue0a2" : ''
endfunction

function! LightlineMode()
  return lightline#mode()
endfunction

function! LightlineFilename()
  if winwidth(0) > 100
    let fname = expand('%:F')
  else
    let fname = expand('%:t')
  endif
  return winwidth(0) < 60 ? '' :
        \ ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlinePosition()
  return LightlinePercent() . ' ' . LightlineLineinfo()
endfunction

function! LightlinePercent()
  return printf("%3d%% \uf0c9", 100 * line('.') / line('$'))
endfunction

function! LightlineLineinfo()
  return printf("%3d/%-3d \ue0a1 %2d", line('.'), line('$'), col('.'))
endfunction

function! LightlineFiletype()
  return winwidth(0) > 80 ? (&filetype !=# '' ? &filetype : 'N/A') : ''
endfunction

function! LightlineFileEncodingFormat()
  return winwidth(0) > 80 ? (&fenc !=# '' ? &fenc : &enc) . '[' . &fileformat . ']' : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 80 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineFileformat()
  return winwidth(0) > 80 ? &fileformat : ''
endfunction

function! TablineModified(n)
  let winnr = tabpagewinnr(a:n)
  return gettabwinvar(a:n, winnr, '&modified') ? "\uf8ea" : gettabwinvar(a:n, winnr, '&modifiable') ? '' : "\uf8ed"
endfunction

function! TablineReadonly(n)
  let winnr = tabpagewinnr(a:n)
  return gettabwinvar(a:n, winnr, '&readonly') ? "\ue0a2" : ''
endfunction

function! TablineFilename(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  let tname = expand('#'.buflist[winnr - 1].':t')
  return tname !=# '' ? tname : '[No Name]'
endfunction

" update lightline theme on fly
augroup LightLineColorscheme
  autocmd!
  autocmd ColorScheme * call s:lightline_update()
augroup END

function! s:lightline_update()
  if !exists('g:loaded_lightline')
    return
  endif
  try
    if g:colors_name =~# 'solarized\|gruvbox'
      let g:lightline.colorscheme = substitute(substitute(g:colors_name, '-', '_', 'g'), '256.*', '', '')
      if g:lightline.colorscheme ==# 'solarized'
        runtime autoload/lightline/colorscheme/solarized.vim
      endif
      if g:lightline.colorscheme ==# 'gruvbox'
        runtime autoload/lightline/colorscheme/gruvbox.vim
      endif
      call lightline#init()
      call lightline#colorscheme()
      call lightline#update()
    endif
  catch
  endtry
endfunction
