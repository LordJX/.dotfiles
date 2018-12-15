" ----- Nerdtree Configuration ---------------------------------

let g:NERDTreeWinPos = "left"
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" to remove the ^G before filename
let g:NERDTreeNodeDelimiter = "\u00a0"

" open NERDTree with <leader>f
noremap <silent> <leader>f :NERDTreeToggle<CR>

" open a NERDTree automatically when no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" open NERDTree automatically when opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

" automatically close NerdTree when you open a file
let NERDTreeQuitOnOpen = 1

" automatically delete the file you just deleted with NerdTree
let NERDTreeAutoDeleteBuffer = 1


" ----- Vimux Configuration ------------------------------------

let g:VimuxHeight = "20"
let g:VimuxOrientation = "v"

" Prompt for a command to run
map <leader>vp :VimuxPromptCommand<CR>

" Run last command executed by VimuxRunCommand
map <leader>vl :VimuxRunLastCommand<CR>

" Inspect runner pane
map <leader>vi :VimuxInspectRunner<CR>

" Zoom the tmux runner pane
map <leader>vz :VimuxZoomRunner<CR>

" Close vim tmux runner opened by VimuxRunCommand
map <leader>vq :VimuxCloseRunner<CR>

" Interrupt any command running in the runner pane
map <Leader>vx :VimuxInterruptRunner<CR>
