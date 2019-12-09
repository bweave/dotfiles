" ======================
" Base config
" ======================

set encoding=utf-8
set termencoding=utf-8
set ttyfast
set confirm
set hidden                       " hide buffers when abandoned instead of unload
set synmaxcol=1000               " Don't syntax highlight long lines
set exrc                         " enable project-specific .vimrc files
set secure                       " disable unsafe commands in project-specific .vimrc files
set clipboard=unnamed            " Clipboard
filetype plugin indent on
syntax enable
set autoread
set updatetime=250
set timeoutlen=250 ttimeoutlen=0 " Avoid delays

" do not create backup, swap file, cuz we use git for version management
set nobackup
set nowritebackup
set noswapfile

" some stuff to get the mouse going in term
set mouse=a
if !has('nvim')
  set ttymouse=xterm2
endif
