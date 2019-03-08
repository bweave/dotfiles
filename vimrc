set nocompatible

so ~/.vim/plugins.vim

set hidden                   " hide buffers when abandoned instead of unload
set synmaxcol=1000           " Don't syntax highlight long lines

set background=dark

" Use the old regex engine because perf
set re=1

" Clipboard
set clipboard=unnamed

let mapleader = "\<Space>"
let g:mapleader = "\<Space>"

filetype plugin indent on
syntax enable
set autoread
set timeoutlen=500 ttimeoutlen=0 " Avoid delays

" do not create backup, swap file, use git for version management
set nobackup
set nowritebackup
set noswapfile

" Set character encoding to use in vim
set encoding=utf-8
set termencoding=utf-8

" Add '-' as recognized word symbol. e.g dw delete all 'foo-bar' instead just 'foo'
set iskeyword+=-

" Show matching brackets
set showmatch
set matchpairs+=<:> " Make < and > to match

" Use 256 colors in vim
set t_Co=256
colo gruvbox

" ---------------------------------------------------------------------------
" UI
" ---------------------------------------------------------------------------

set title        " make your xterm inherit the title from Vim
set autoindent
set smartindent
set showmode     " show current mode down the bottom
set showcmd      " show incomplete cmds down the bottom
set wildmenu
set wildmode=list:longest
set wildcharm=<TAB> " Autocmpletion hotkey
set visualbell t_vb=
" set cursorline   " highlight current line
set ttyfast
set backspace=indent,eol,start  "allow backspacing over everything in insert mode
set laststatus=2 " display the status line always
set nonumber
set relativenumber number " show relative numbers
set splitbelow
set splitright
set list
set lazyredraw
set ttyfast

" some stuff to get the mouse going in term
set mouse=a
if !has('nvim')
  set ttymouse=xterm2
endif

" ---------------------------------------------------------------------------
" Text Formatting
" ---------------------------------------------------------------------------

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" set nowrap
" set textwidth=120
" set formatoptions=n

" ---------------------------------------------------------------------------
" Mappings
" ---------------------------------------------------------------------------

" eslint-disable-line
imap <leader>ee /*eslint-disable-line*/

" Delete buffer
nmap <leader>w :bd<CR>

" Tabs
nmap <silent><leader>tt :tabnew<CR>
nmap <leader>tw :tabclose<CR>

nmap <Leader>1 1gt<CR>
nmap <Leader>2 2gt<CR>
nmap <Leader>3 3gt<CR>
nmap <Leader>4 4gt<CR>
nmap <Leader>5 5gt<CR>
nmap <Leader>6 6gt<CR>
nmap <Leader>7 7gt<CR>
nmap <Leader>8 8gt<CR>
nmap <Leader>9 9gt<CR>


" Replace
nmap <leader>s :%s//<left>
vmap <leader>s :s//<left>

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>ep :e ~/.vim/plugins.vim<CR>
nmap <silent> <leader>rv :so $MYVIMRC<CR>

" bind K to grep word under cursor
nnoremap <silent> K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
vnoremap <silent> K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" The Silver Searcher
if executable('ag')
  let $FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'

  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " \a to Silver Searcher
  nnoremap <leader>a :Ag!<space>
endif

" Map Ctrl-p to FZF
nnoremap <silent> <C-p> :Files<cr>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Align blocks of text and keep them selected
vmap < <gv
vmap > >gv

" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

" Toggle hlsearch with <leader>hs
nmap <leader>hs :set hlsearch! hlsearch?<CR>

" Format json strings
com! FormatJSON %!python -m json.tool

nmap <silent> <leader>g :Magit<CR>

" ---------------------------------------------------------------------------
" StandardRB/Eslint/Prettier
" ---------------------------------------------------------------------------

let g:ale_ruby_rubocop_executable = 'bundle exec rubocop'
let g:ale_linters = {
\   'ruby': ['rubocop'],
\   'javascript': ['eslint'],
\   'css': ['eslint'],
\}
let g:ale_fixers = {
\   'javascript': ['eslint'],
\   'css': ['eslint'],
\}
let g:ale_fix_on_save = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0

" ---------------------------------------------------------------------------
" Ruby/Rails
" ---------------------------------------------------------------------------

let g:ale_ruby_rubocop_executable = 'bundle'

" Set this in your vimrc file to disabling highlighting
let g:ale_set_highlights = 0
highlight ALEWarning ctermbg=DarkMagenta

" Run tests with vimux + turbux
let g:turbux_command_prefix = 'bin/rails'
let g:turbux_command_test_unit = 'test'

" Execute current buffer as ruby
map <S-r> :w !ruby<CR>

" View routes or Gemfile in large split
map <leader>gr :topleft :split config/routes.rb<cr>
map <leader>gg :topleft :split Gemfile<cr>

" Open alternate file, e.g. test, for current file - requires tpope/vim-rails
map <leader><tab> :AV<cr>

" Go to definition in split
map <leader>gd :vsp <cr>:exec("tag ".expand("<cword>"))<cr>

" ---------------------------------------------------------------------------
" Plugins
" ---------------------------------------------------------------------------

"--------------------------
" Emmet - tab for expansion
imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")

set laststatus=2

"-------------------------
" Lightline
set showtabline=2  " always show tabline
let g:lightline = {}
let g:lightline.colorscheme = 'gruvbox'
let g:lightline.component = { 'separator': '' }
let g:lightline.component_function = { 'gitbranch': 'fugitive#head', 'bufferinfo': 'lightline#buffer#bufferinfo' }
let g:lightline.component_expand = { 'buffers': 'lightline#bufferline#buffers' }
let g:lightline.component_type = { 'buffers': 'tabsel' }
let g:lightline.active = { 'left': [ [ 'paste' ], [ 'gitbranch', 'readonly', 'filename', 'modified' ] ] }
" let g:lightline.tabline = { 'left': [['bufferinfo'],['separator'],['buffers']], 'right': [['close']]}
let g:lightline.tabline = { 'left': [['bufferinfo'],['separator'],['tabs']], 'right': [['close']]}
let g:lightline#bufferline#filename_modifier = ':t'
let g:lightline#bufferline#show_number=2
let g:lightline#bufferline#enable_devicons=1
let g:lightline#bufferline#unicode_symbols=1
let g:lightline#bufferline#number_map = {
\ 0: '0 ', 1: '1 ', 2: '2 ', 3: '3 ', 4: '4 ',
\ 5: '5 ', 6: '6 ', 7: '7 ', 8: '8 ', 9: '9 '}
" nmap <Leader>1 <Plug>lightline#bufferline#go(1)
" nmap <Leader>2 <Plug>lightline#bufferline#go(2)
" nmap <Leader>3 <Plug>lightline#bufferline#go(3)
" nmap <Leader>4 <Plug>lightline#bufferline#go(4)
" nmap <Leader>5 <Plug>lightline#bufferline#go(5)
" nmap <Leader>6 <Plug>lightline#bufferline#go(6)
" nmap <Leader>7 <Plug>lightline#bufferline#go(7)
" nmap <Leader>8 <Plug>lightline#bufferline#go(8)
" nmap <Leader>9 <Plug>lightline#bufferline#go(9)
" nmap <Leader>0 <Plug>lightline#bufferline#go(10)

"-------------------------
" Markdown
let g:markdown_enable_spell_checking = 0

"-------------------------
" NERDTree
let NERDTreeShowBookmarks = 0
let NERDChristmasTree = 1
let NERDTreeWinPos = "left"
let NERDTreeHijackNetrw = 1
let NERDTreeWinSize = 30
let NERDTreeChDirMode = 2
let NERDTreeDirArrows = 1
let NERDTreeMinimalUI=1
silent! nmap <silent> <Leader>m :NERDTreeToggle<CR>
silent! nmap <silent> <leader>f :NERDTreeFind<CR>

"-------------------------
" NERDCommenter

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

if has("gui_macvim") && has("gui_running")
  map <D-/> <plug>NERDCommenterToggle<CR>
  imap <D-/> <Esc><plug>NERDCommenterToggle<CR>
else
  map <leader>/ <plug>NERDCommenterToggle<CR>
endif

"-------------------------
" Surround

" yss-
let g:surround_45 = "<% \r %>"
" yss=
let g:surround_61 = "<%= \r %>"

" ---------------------------------------------------------------------------
" Strip trailing whitespace
" ---------------------------------------------------------------------------
function! <SID>StripTrailingWhitespaces()
  " Don't try to strip whitespace in non buffers
  if (!empty(&buftype))
    return
  endif

  " Only strip whitespace if isn't a slim, haml or emblem file
  if &filetype =~ 'slim' || &filetype =~ 'haml' || &filetype =~ 'emblem'
    return
  endif
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  %s/\s\+$//e
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" ---------------------------------------------------------------------------
" Add support to go to file in JS without file extention
" ---------------------------------------------------------------------------
augroup suffixes
  autocmd!
  let associations = [
    \ ["javascript", ".js,.ts,.json,.jsx,.graphql"],
    \ ["typescript", ".js,.ts,.json,.jsx,.graphql"]]

  for ft in associations
    execute "autocmd FileType " . ft[0] . " setlocal suffixesadd=" . ft[1]
  endfor
augroup END

" ---------------------------------------------------------------------------
" Autosave
" ---------------------------------------------------------------------------

" Strip trailing whitespaces then save all files on focus lost
autocmd FocusLost * :call <SID>StripTrailingWhitespaces() | silent! wa

" ---------------------------------------------------------------------------
" Column color
" ---------------------------------------------------------------------------

" set colorcolumn=120
" highlight ColorColumn guibg=#2c2d27 ctermbg=235
" highlight clear SignColumn

set fillchars+=vert:│

" Override color scheme
autocmd ColorScheme * highlight VertSplit guibg=NONE
autocmd ColorScheme * highlight NonText guifg=bg
