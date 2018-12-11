" ----- Nerdtree Configuration ---------------------------------

let g:NERDTreeWinPos = "left"
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" to remove the ^G before filename
let g:NERDTreeNodeDelimiter = "\u00a0"

" open NERDTree with Ctrl+n 
map <F3> :NERDTreeToggle<CR>

" open a NERDTree automatically when no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" open NERDTree automatically when opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

" find the right file
nnoremap <silent> <Leader>v :NERDTreeFind<CR>

" automatically close NerdTree when you open a file
let NERDTreeQuitOnOpen = 1

" automatically delete the file you just deleted with NerdTree
let NERDTreeAutoDeleteBuffer = 1

