" Load vundle
set nocompatible
filetype off
set rtp+=~/scripts/.vim/bundle/vundle/
call vundle#rc()

" Load vundle bundles
Bundle 'gmarik/vundle'

" To add more
" git submodule add git@github.com:airblade/vim-gitgutter.git .vim/bundle/vim-gitgutter
" Then add Bundle call above
" After adding to above, in vim run :BundleInstall!

" This adds a nice +/- signs column on left
Bundle 'airblade/vim-gitgutter'
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0

" keyboard commands:
" ]c => next hunk
" [c => prev hunk


" Adds the cool branch / commit aware coloured status line on the bottom
Bundle 'bling/vim-airline'
set laststatus=2

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'


" This sets 256 colours support needed for airline
set t_Co=256

" This makes the git +/- columnonthe left black background
highlight clear SignColumn

" This is for block code commenting / uncommenting, select text then press Ctrl + // to toggle
Bundle 'tomtom/tcomment_vim'
" TODO One minor issue with above is that I want it to retain the selection afterwards, this fixes that:



" Ctrl + p - support like Sublime / atom (not actually great on big projects like moodle)
Bundle 'kien/ctrlp.vim'

" Ctrl + r - search for most recently used files
nmap <C-r> :CtrlPMRUF<CR>

" Ctrl + b - search open buffers
nmap <C-b> :CtrlPBuffer<CR>

" Ctrl + m - search for modified / unstaged files
Bundle 'jasoncodes/ctrlp-modified.vim'
nmap <C-m> :CtrlPModified<CR>

" NerdTree
Bundle 'scrooloose/nerdtree'
" Auto open if no files
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Close vim when only nerdtree is left"
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

"map <C-n> :NERDTreeToggle<CR>


" press tab to indent and shift tab to unindent a block of text
vmap <Tab> >gv
vmap <S-Tab> <gv

" Show trailing whitespace eg at the end of this line is a crap which should be red  
Bundle 'bronson/vim-trailing-whitespace'

" This makes text wrap at spaces instead of mid-word, nicer for long wrapped text or markdown
set linebreak

" When really long lines wrapp so much they go off the screen they aren't shown with a @ instead" This fixes that and shows them:
set display+=lastline

" When lines are broken, as well as not showing a new line number also show an ellipsis to make it really clear that this is a wrapped line and not a new line
set showbreak=...\ 

" This does nicer wrapping when line is indented, but looks to not be compiled in :(
" set breakindent


" All things folding and outlining, currently REALLY slow, need something better
" Also need to find a way to fold JavaDoc style comments into the fold below it, otherwise is pretty useless
" set foldmethod=syntax  " slow
" set foldmethod=indent  " slow
" set foldlevelstart=1
" set foldcolumn=3
"
" let          perl_fold=1      " Perl
" let          ruby_fold=1      " Ruby
" let    javaScript_fold=1      " JavaScript
" let        php_folding=1      " PHP
" let     vimsyn_folding='af'   " Vim script
" let   r_syntax_folding=1      " R
" let xml_syntax_folding=1      " XML
" let    sh_fold_enabled=1      " sh

" Less support for places which don't have it by defaults
Bundle 'groenewege/vim-less'
" Make all css files less files
au BufNewFile,BufRead *.css set filetype=less

" make mysql config files use .ini syntax
au bufreadpost *.conf,*.cnf,*.tksrc set filetype=dosini

" make psql config files use .sql syntax
au bufreadpost *.psqlrc set filetype=sql

" This is for sublime multi cursor fun
Bundle 'terryma/vim-multiple-cursors'

"let g:multi_cursor_use_default_mapping=0
" Default mapping
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

" cheat sheet:
" Press C+n to add more lines



" Moodle ctags:
" ctags -R --languages=php --exclude="CVS" --php-kinds=f --regex-PHP='/abstract class ([^ ]*)/\1/c/' --regex-PHP='/interface ([^ ]*)/\1/c/' --regex-PHP='/(public |static |abstract |protected |private )+function ([^ (]*)/\2/f/'



" This is for IDE like popup auto complete
" crap need newer ubuntu first :(
" Bundle 'Valloric/YouCompleteMe'

" End of bundle stuff
filetype on

syntax on

" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"1000,:20,%,n~/.viminfo


" Don't convert tabs to space when in a Makefile
:autocmd FileType make set noexpandtab


" Show line numbers
set number

" Click to move cursor and select text with the mouse
set mouse=a

set showmatch

set history=9999

set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab


" Show searches as you type them. Can make things slower :(
set incsearch

function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

