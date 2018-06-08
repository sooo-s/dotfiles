let g:python_host_prog = $HOME . '/.virtualenvs/nvim-python2/bin/python'
let g:python3_host_prog = $HOME . '/.virtualenvs/nvim-python3/bin/python'

colorscheme desert
set termguicolors
set mouse=a
set clipboard=unnamed

au VimLeave * set guicursor=a:ver100-blinkon1000-blinkoff500
