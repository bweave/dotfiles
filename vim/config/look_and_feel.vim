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

" OneDark Color Palette
" +---------------------------------------------+
" |  Color Name  |         RGB        |   Hex   |
" |--------------+--------------------+---------|
" | Black        | rgb(40, 44, 52)    | #282c34 |
" |--------------+--------------------+---------|
" | White        | rgb(171, 178, 191) | #abb2bf |
" |--------------+--------------------+---------|
" | Light Red    | rgb(224, 108, 117) | #e06c75 |
" |--------------+--------------------+---------|
" | Dark Red     | rgb(190, 80, 70)   | #be5046 |
" |--------------+--------------------+---------|
" | Green        | rgb(152, 195, 121) | #98c379 |
" |--------------+--------------------+---------|
" | Light Yellow | rgb(229, 192, 123) | #e5c07b |
" |--------------+--------------------+---------|
" | Dark Yellow  | rgb(209, 154, 102) | #d19a66 |
" |--------------+--------------------+---------|
" | Blue         | rgb(97, 175, 239)  | #61afef |
" |--------------+--------------------+---------|
" | Magenta      | rgb(198, 120, 221) | #c678dd |
" |--------------+--------------------+---------|
" | Cyan         | rgb(86, 182, 194)  | #56b6c2 |
" |--------------+--------------------+---------|
" | Gutter Grey  | rgb(76, 82, 99)    | #4b5263 |
" |--------------+--------------------+---------|
" | Comment Grey | rgb(92, 99, 112)   | #5c6370 |
" +---------------------------------------------+

" Vim terminal colors
let s:test_colors = [
      \'#282c34', '#abb2bf',
      \'#abb2bf', '#98c379',
      \'#61afef', '#e5c07b',
      \'#56b6c2', '#abb2bf',
      \'#c678dd', '#d19a66',
      \'#4b5263', '#5c6370',
      \'#282c34', '#282c34',
      \'#282c34', '#282c34',
      \]
let g:terminal_ansi_colors = s:test_colors

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
