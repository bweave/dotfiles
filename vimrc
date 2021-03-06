"  ___      _    __ _ _               __   ___
" |   \ ___| |_ / _(_) |___ ___  ___  \ \ / (_)_ __
" | |) / _ \  _|  _| | / -_|_-< |___|  \ V /| | '  \
" |___/\___/\__|_| |_|_\___/__/         \_/ |_|_|_|_|
"
" 1. Base
" 2. Plugins
" 3. Settings
" 4. Mappings

""""""""""""""""""
" Base
""""""""""""""""""
set nocp
filetype plugin on
set encoding=UTF-8

set mouse=i
set autoindent                                     "always set autoindenting on
set autoread                                       "automatically read changes in the file
set backspace=indent,eol,start                     "make backspace behave properly in insert mode
set clipboard=unnamed                              "use system clipboard; requires has('unnamedplus') to be 1
" set cmdheight=2
set colorcolumn=121                                "display text width column
set completeopt=longest,menuone,preview            "better insert mode completions
set cursorline                                     "highlight current line
set formatoptions-=cro                             "disable auto comments on new lines
set hidden                                         "hide buffers instead of closing them even if they contain unwritten changes
set hlsearch
set ignorecase                                     "searches are case insensitive...
set incsearch                                      "incremental search highlight
set laststatus=2                                   "always display the status bar
set lazyredraw                                     "lazily redraw screen while executing macros, and other commands
set nobackup                                       "disable backup
set nowritebackup                                  "disable backup
set noswapfile                                     "disable swap files
set nowrap                                         "disable soft wrap for lines
set relativenumber number                          "relative line numbers
set scrolloff=2                                    "always show 2 lines above/below the cursor
set showcmd                                        "don't display incomplete commands
set smartcase                                      " ..unless they contain at least one capital letter
set splitbelow                                     "vertical splits will be at the bottom
set splitright                                     "horizontal splits will be to the right
set tabstop=2 shiftwidth=2 softtabstop=2 expandtab "use two spaces for indentation
set ttimeout                                       "time waited for key press(es) to complete...
set ttimeoutlen=50                                 " ...makes for a faster key response
set ttyfast                                        "more characters will be sent to the screen for redrawing
set wildmenu                                       "better menu with completion in command mode
set wildmode=longest:full,full

set t_Co=256                        "enable 256 colors
set background=dark
" hi Normal guibg=NONE ctermbg=NONE "with a transparent terminal, this is nice

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

if has('nvim')
  set inccommand=nosplit
endif

"remove trailing whitespace on save
autocmd! BufWritePre * :%s/\s\+$//e

"automatically resize splits when resizing the window
autocmd VimResized * wincmd =

"remove current line highlight in unfocused window
au VimEnter,WinEnter,BufWinEnter,FocusGained,CmdwinEnter * set cul
au WinLeave,FocusLost,CmdwinLeave * set nocul

"wiplog
autocmd FileType javascript iabbrev <buffer> wiplog console.log("WIPLOG",)<left>
" autocmd FileType ruby iabbrev <buffer> wiplog Rails.logger.debug "=" * 80<CR>Rails.logger.debug <CR>Rails.logger.debug "=" * 80<Up>

"Co-authored-by
autocmd FileType gitcommit iabbrev <buffer> co Co-authored-by: SOMEONE <HANDLE@users.noreply.github.com>

""""""""""""""""""
" Plugins
""""""""""""""""""

call plug#begin('~/.vim/plugins')
Plug 'airblade/vim-gitgutter'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'joshdick/onedark.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'kassio/neoterm'
Plug 'ludovicchabant/vim-gutentags'
Plug 'mattn/emmet-vim'
Plug 'lifepillar/vim-gruvbox8'
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'slim-template/vim-slim'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-crystal/vim-crystal'
Plug 'vim-test/vim-test'
Plug 'w0rp/ale'
Plug 'wsdjeg/vim-fetch'

Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'
call plug#end()

""""""""""""""""""
" Settings
""""""""""""""""""

if has('macunix')
  function! OsDarkModeTheme()
    if system("defaults read -g AppleInterfaceStyle") =~ '^Dark'
      colorscheme onehalfdark   " for the dark version of the theme
      set background=dark
    else
      colorscheme onehalflight  " for the light version of the theme
      set background=light
    endif
  endfunction
  " initialize the colorscheme for the first run
  call OsDarkModeTheme()
else
  colorscheme onehalfdark
endif

let g:airline_theme="base16"
let g:airline_powerline_fonts = 1
let g:airline#extensions#obsession#indicator_text = "⚡️ "
let g:airline#extensions#ale#error_symbol = "❕"
let g:airline#extensions#ale#warning_symbol = "❔"

let g:markdown_fenced_languages = ['css', 'html', 'python', 'ruby', 'javascript', 'typescript=javascript', 'zsh=sh', 'bash=sh', 'vim']
let g:splitjoin_split_mapping = ''
let g:splitjoin_join_mapping = ''
let g:splitjoin_trailing_comma = 1
let g:vim_jsx_pretty_colorful_config = 1
let g:markdown_enable_spell_checking = 0
let g:any_jump_search_prefered_engine = 'ag'
let g:any_jump_grouping_enabled = 1
let b:preferred_searcher = 'ag'
let g:fzf_layout = { 'down': '30%' }
let g:fzf_preview_window = ''
let g:fzf_buffers_jump = 1
let g:gutentags_file_list_command = 'rg --files'
let g:gutentags_ctags_exclude = [
\ '*.md', '*.markdown', '*.css', '*.scss', '*.html', '*.erb', '*.json', '*.xml',
\ 'yarn.lock', 'package.json', 'Gemfile.lock', 'Gemfile', 'Procfile', 'Guardfile', 'vendor/assets/*',
\ 'public', 'log', 'node_modules', 'tmp'
\]
let g:ale_ruby_rubocop_executable = 'bundle'
let g:ale_linters = {
\   'ruby': ['rubocop'],
\   'javascript': ['eslint'],
\   'css': ['eslint'],
\}
let g:ale_fixers = {
\   'ruby': ['rubocop'],
\   'javascript': ['eslint'],
\   'css': ['eslint'],
\}
let g:ale_fix_on_save = 1
if has('nvim')
  let test#strategy = "neovim"
elseif has('gui_macvim')
  let test#strategy = "iterm"
else
  let test#strategy = "vimterminal"
endif
let g:test#preserve_screen = 1
let test#neovim#term_position = "vert botright 80"
let g:neoterm_default_mod = "vert botright 80"
let test#vim#term_position = "vert botright 80"
let g:user_emmet_install_global = 0
" autocmd FileType html EmmetInstall
" let g:user_emmet_expandabbr_key='<Tab>'
" autocmd FileType html imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")

" If another buffer tries to replace NERDTree, put in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

" fzf
function! s:list_buffers()
  redir => list
  silent ls
  redir END
  return split(list, "\n")
endfunction

function! s:delete_buffers(lines)
  execute 'bwipeout' join(map(a:lines, {_, line -> split(line)[0]}))
endfunction

command! BD call fzf#run(fzf#wrap({
  \ 'source': s:list_buffers(),
  \ 'sink*': { lines -> s:delete_buffers(lines) },
  \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept'
\ }))


let g:currentmode={
\ 'n'  : 'N',
\ 'no' : 'N·Op',
\ 'v'  : 'V',
\ 'V'  : 'V',
\ '^V' : 'V',
\ 's'  : 'S',
\ 'S'  : 'S',
\ '^S' : 'S',
\ 'i'  : 'I',
\ 'R'  : 'R',
\ 'Rv' : 'V',
\ 'c'  : 'C',
\ 'cv' : 'Ex',
\ 'ce' : 'Ex',
\ 'r'  : 'P',
\ 'rm' : 'M',
\ 'r?' : 'C',
\ '!'  : 'S',
\ 't'  : 'T'
\}


""""""""""""""""""
" Mappings
""""""""""""""""""""

let mapleader = "\<Space>"

" quick window switching
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" Quickly edit/reload the vimrc file
nnoremap <silent> <leader>ev :e ~/.vimrc<CR>
nnoremap <silent> <leader>rv :so ~/.vimrc<CR>

" Toggle hlsearch with <leader>hs
nmap <leader>hs :set hlsearch! hlsearch?<CR>

" Esc to normal mode in terminal
tnoremap <leader><Esc> <C-\><C-n>

" toggle paste mode
map <leader>p :set invpaste<CR>

" delete buffer
nnoremap <leader>w :bd<CR>

" keep visual selection after indenting
vnoremap < <gv
vnoremap > >gv

nnoremap <C-P> :FZF<cr>
nnoremap <leader>/ :Commentary<CR>
vnoremap <leader>/ :Commentary<CR>
nnoremap <leader>BD :BD<cr>
nnoremap <leader>E :NERDTreeToggle<CR>
nnoremap <leader>S :tab drop .vscode/scratchpad_local.md<CR>
nnoremap <leader>O :vs ~/Desktop/Onboarding.md<CR>
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>c :Colors<cr>
nnoremap <leader>f :NERDTreeFind<CR>
nnoremap <leader>gd :exec("tag ".expand("<cword>"))<cr>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>j :SplitjoinSplit<cr>
nnoremap <leader>k :SplitjoinJoin<cr>
nnoremap <leader>s :Ag <C-R><C-W><CR>
nnoremap <leader>t :TestFile<CR>
nnoremap <leader>T :TestNearest<CR>

" define line highlight color
highlight LineHighlight ctermbg=239 guibg=#474e5d
" highlight the current line
nnoremap <silent> <Leader>hl :call matchadd('LineHighlight', '\%'.line('.').'l')<CR>
" clear all the highlighted lines
nnoremap <silent> <Leader>cl :call clearmatches()<CR>

" Convert Ruby hash keys
nnoremap <Leader>ht :HashKeysToString<CR>
vnoremap <Leader>ht :HashKeysToString<CR>
nnoremap <Leader>hy :HashKeysToSymbol<CR>
vnoremap <Leader>hy :HashKeysToSymbol<CR>
