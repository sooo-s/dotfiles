unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

set encoding=utf-8
scriptencoding utf-8

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('~/.vim/dein')
  call dein#begin('~/.vim/dein')

  " Let dein manage dein
  " Required:
  call dein#add('~/.vim/dein/repos/github.com/Shougo/dein.vim')

  call dein#load_toml('~/.dein.toml')

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

" vim settings
syntax on
set background=dark
colorscheme hybrid

set list
set listchars=tab:>-,eol:$

set history=10000

set expandtab
set tabstop=2
set shiftwidth=2
set autoindent
set smartindent
set ambiwidth=double

set ignorecase
set smartcase
set hlsearch
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>
set cursorline

set undodir=~/tmp/vim/undo
set undofile

set clipboard=unnamed

" remap
inoremap <silent> jj <ESC>

set spelllang+=cjk
set spell

" マウス操作の有効化
if has('mouse')
    set mouse=a
    if has('mouse_sgr')
        set ttymouse=sgr
    elseif v:version > 703 || v:version is 703 && has('patch632')
        set ttymouse=sgr
    else
        set ttymouse=xterm2
    endif
endif

let g:vim_json_syntax_conceal = 0
