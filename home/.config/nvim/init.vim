let g:python_host_prog = $HOME . '/.virtualenvs/nvim-python2/bin/python'
let g:python3_host_prog = $HOME . '/.virtualenvs/nvim-python3/bin/python'

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  " Let dein manage dein
  " Required:
  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')

  call dein#load_toml('~/.dein_neo.toml')

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

colorscheme desert
set termguicolors
set mouse=a
set clipboard=unnamed
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
set list
set listchars=tab:>-,eol:$
set undodir=~/tmp/vim/undo
set undofile
set spelllang+=cjk
set spell
set fileencodings=ucs-bom,utf-8,default,iso-2022-jp,euc-jp,cp932,latin1

" remap
inoremap <silent> jj <ESC>

" json
let g:vim_json_syntax_conceal = 0

augroup auto-cursorline
  autocmd!
  autocmd CursorMoved,CursorMovedI,WinLeave * setlocal nocursorline nocursorcolumn
  autocmd CursorHold,CursorHoldI * setlocal cursorline cursorcolumn
augroup END

augroup reset-cursor
  autocmd!
  au VimLeave * set guicursor=a:ver100-blinkon1000-blinkoff500
augroup END

augroup syntax-range
  autocmd!
  autocmd BufNewFile,BufRead .dein*.toml call s:syntax_range_dein()

  function! s:syntax_range_dein() abort
    let start = '^\s*hook_\%('.
    \             'add\|source\|post_source\|post_update'.
    \             '\)\s*=\s*%s'

    call SyntaxRange#Include(printf(start, "'''"), "'''", 'vim', '')
    call SyntaxRange#Include(printf(start, '"""'), '"""', 'vim', '')
  endfunction
augroup END
