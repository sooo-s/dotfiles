let g:python_host_prog = $HOME . '/.virtualenvs/nvim-python2/bin/python'
let g:python3_host_prog = $HOME . '/.virtualenvs/nvim-python3/bin/python'

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

" remap
inoremap <silent> jj <ESC>

augroup auto-cursorline
  autocmd!
  autocmd CursorMoved,CursorMovedI,WinLeave * setlocal nocursorline nocursorcolumn
  autocmd CursorHold,CursorHoldI * setlocal cursorline cursorcolumn
augroup END

augroup reset-cursor
  autocmd!
  au VimLeave * set guicursor=a:ver100-blinkon1000-blinkoff500
augroup END
