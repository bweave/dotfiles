" ======================
" Look and Feel
" ======================

set t_Co=256                    " Use 256 colors in vim
set background=dark
set nowrap                      " no line wrapping
set showmatch                   " Show matching brackets
set autoindent
set smartindent
set noshowmode                  " don't show current mode down on the bottom
set showcmd                     " show incomplete cmds down the bottom
set wildmenu
set wildmode=longest:full,full
set wildcharm=<TAB>             " Autocmpletion hotkey
set visualbell t_vb=
set backspace=indent,eol,start  "allow backspacing over everything in insert mode
set laststatus=2                " display the status line always
set showtabline=2
set relativenumber number
set splitbelow
set splitright
set list
set fillchars+=vert:│
set lazyredraw
if (has("termguicolors"))
  set termguicolors
endif

" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

" Customize fzf colors to match your color scheme
let g:fzf_colors = {
      \ 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Pmenu'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'],
      \ }

" Customize some theme settings
" Gruvbox Theme
let g:gruvbox_invert_selection=0
" Ayu Theme
let ayucolor="light"
" SpaceVim Theme
let g:space_vim_dark_background = 234
hi LineNr     ctermbg=234 guibg=#1c1c1c
hi SignColumn ctermbg=NONE guibg=NONE
hi Comment ctermfg=59 guifg=#5C6370
hi multiple_cursors_cursor term=reverse cterm=reverse gui=reverse
hi link multiple_cursors_visual Visual
" Seoul256 color scheme
let g:seoul256_background = 234

colo one                        " Onedark theme

" Status Line
so ~/.vim/config/status_line.vim
