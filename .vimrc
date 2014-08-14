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

" Ctrl + p - support like Sublime / atom (not actually great on big projects like moodle)
Bundle 'kien/ctrlp.vim'

" Ctrl + r - search for most recently used files
nmap <C-r> :CtrlPMRUF<CR>

" Ctrl + b - search open buffers
nmap <C-b> :CtrlPBuffer<CR>

" Ctrl + m - search for modified / unstaged files
Bundle 'jasoncodes/ctrlp-modified.vim'
nmap <C-m> :CtrlPModified<CR>

" Nerd
Bundle 'scrooloose/nerdtree'
" Auto open if no files
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

map <C-n> :NERDTreeToggle<CR>


" Show trailing whitespace eg at the end of this line is a crap which should be red  
Bundle 'bronson/vim-trailing-whitespace'



" All things folding and outlining, currently REALLY slow, need something better
" Also need to find a way to fold JavaDoc style comments into the fold below it, otherwise is pretty useless
" set foldmethod=syntax  " slow
" set foldmethod=indent  " slow
" set foldlevelstart=1
" set foldcolumn=1
"
" let          perl_fold=1      " Perl
" let          ruby_fold=1      " Ruby
" let    javaScript_fold=1      " JavaScript
" let        php_folding=1      " PHP
" let     vimsyn_folding='af'   " Vim script
" let   r_syntax_folding=1      " R
" let xml_syntax_folding=1      " XML
" let    sh_fold_enabled=1      " sh


" End of bundle stuff
filetype on

syntax on

" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo



set number

set mouse=a

set showmatch

set history=9999

set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab


set clipboard=unnamed

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

