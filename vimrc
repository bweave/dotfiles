" set nocompatible

so ~/.vim/plugins.vim

set hidden                   " hide buffers when abandoned instead of unload
set synmaxcol=1000           " Don't syntax highlight long lines

" enable project-specific .vimrc files
set exrc
" disable unsafe commands in your project-specific .vimrc files
set secure

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
set updatetime=250
set timeoutlen=250 ttimeoutlen=0 " Avoid delays

" do not create backup, swap file, use git for version management
set nobackup
set nowritebackup
set noswapfile

" no line wrapping
set nowrap

" Set character encoding to use in vim
set encoding=utf-8
set termencoding=utf-8

" Show matching brackets
set showmatch

" Use 256 colors in vim
set t_Co=256

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
set showtabline=2
set nonumber
set relativenumber number " show relative numbers
set splitbelow
set splitright
set list
set lazyredraw
set ttyfast
if (has("termguicolors"))
  set termguicolors
endif

" some stuff to get the mouse going in term
set mouse=a
if !has('nvim')
  set ttymouse=xterm2
endif

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

" Selected Theme
colo onedark

" ---------------------------------------------------------------------------
" Text Formatting
" ---------------------------------------------------------------------------

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" Mappings
" ---------------------------------------------------------------------------

" Color themes
nnoremap <leader>c :Colors<CR>

" Neovim specific
if has("nvim")
	tnoremap <Esc><Esc> <C-\><C-n>
endif

" vim-test
" if has("nvim")
	" let test#strategy = "neovim"
" else
	" let test#strategy = "vimterminal"
" endif
let test#strategy = 'vimux'
nnoremap <leader>t :TestFile<CR>
nnoremap <leader>T :TestNearest<CR>
" nnoremap <leader>st :TREPLSendLine<CR>
" vnoremap <leader>st :TREPLSendSelection<CR>

" Vim + Tmux
nnoremap <Leader>vp :VimuxPromptCommand<CR>

" eslint-disable-line
inoremap <leader>ee /*eslint-disable-line*/

" Buffers
nnoremap <leader>b :Buffers<CR>

" Delete buffer
nnoremap <leader>w :bd<CR>

" Tags in current file
nnoremap t :BTags<CR>

" Navigating Splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Tabs
nnoremap <silent><leader>tt :tabnew<CR>
nnoremap <leader>tw :tabclose<CR>

nnoremap <Leader><Leader>1 1gt<CR>
nnoremap <Leader><Leader>2 2gt<CR>
nnoremap <Leader><Leader>3 3gt<CR>
nnoremap <Leader><Leader>4 4gt<CR>
nnoremap <Leader><Leader>5 5gt<CR>
nnoremap <Leader><Leader>6 6gt<CR>
nnoremap <Leader><Leader>7 7gt<CR>
nnoremap <Leader><Leader>8 8gt<CR>
nnoremap <Leader><Leader>9 9gt<CR>

" Splitjoin
let g:splitjoin_split_mapping = ''
let g:splitjoin_join_mapping = ''
nmap sj :SplitjoinJoin<CR>
nmap ss :SplitjoinSplit<CR>

" Replace
nnoremap <C-s> :%s//<left>
vmap <C-s> :s//<left>

" Quickly edit/reload the vimrc file
nnoremap <silent> <leader>ev :e ~/.vimrc<CR>
nnoremap <silent> <leader>ep :e ~/.vim/plugins.vim<CR>
nnoremap <silent> <leader>ec :CocConfig<CR>
nnoremap <silent> <leader>rv :so $MYVIMRC<CR>

" The Silver Searcher
if executable('ag')
  let $FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'

  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Ag search current selection
  nnoremap s :Ag<CR>

  "<leader>a to Silver Searcher
  nnoremap <leader>s :Ag!<space>
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
map <leader><tab> :A<cr>
map <leader><leader><tab> :AV<cr>

" Go to definition in split
map <leader>gd :vsp <cr>:exec("tag ".expand("<cword>"))<cr>

" ---------------------------------------------------------------------------
" Plugins
" ---------------------------------------------------------------------------

" Seoul256 color scheme
let g:seoul256_background = 234

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
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
  \ 'header':  ['fg', 'Comment'] }

"--------------------------
" CoC
"
" Better display for messages
" set cmdheight=2
" don't give |ins-completion-menu| messages.
" set shortmess+=cF

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
" inoremap <silent><expr> <TAB>
      " \ pumvisible() ? "\<C-n>" :
      " \ <SID>check_back_space() ? "\<TAB>" :
      " \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" function! s:check_back_space() abort
  " let col = col('.') - 1
  " return !col || getline('.')[col - 1]  =~# '\s'
" endfunction

" Use <c-space> to trigger completion.
" inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
" USE <C-y> instead b/c of conflict with tpope/endwise
" inoremap <expr> <CR><CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
" nmap <silent> [c <Plug>(coc-diagnostic-prev)
" nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
" nmap <silent> <leader>gd <Plug>(coc-definition)
" nmap <silent> <leader>gy <Plug>(coc-type-definition)
" nmap <silent> <leader>gi <Plug>(coc-implementation)
" nmap <silent> <leader>gr <Plug>(coc-references)

" Use K to show documentation in preview window
" nnoremap <silent> K :call <SID>show_documentation()<CR>

" function! s:show_documentation()
  " if (index(['vim','help'], &filetype) >= 0)
    " execute 'h '.expand('<cword>')
  " else
    " call CocAction('doHover')
  " endif
" endfunction

" Highlight symbol under cursor on CursorHold
" autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
" nmap <leader>rn <Plug>(coc-rename)

"--------------------------
" Gitgutter
set signcolumn=yes

" Use fontawesome icons as signs
let g:gitgutter_sign_added = ''
let g:gitgutter_sign_modified = ''
let g:gitgutter_sign_removed = ''
let g:gitgutter_sign_removed_first_line = ''
let g:gitgutter_sign_modified_removed = ''

" Use same colors as editor bg
let g:gitgutter_override_sign_column_highlight=0

" Jump between hunks
nmap <Leader>gn <Plug>GitGutterNextHunk  " git next
nmap <Leader>gp <Plug>GitGutterPrevHunk  " git previous

" Hunk-add and hunk-revert for chunk staging
nmap <Leader>ga <Plug>GitGutterStageHunk  " git add (chunk)
nmap <Leader>gu <Plug>GitGutterUndoHunk   " git undo (chunk)

"--------------------------
" Gutentags
let g:gutentags_file_list_command = 'rg --files'
let g:gutentags_ctags_exclude = ['*.md', '*.markdown', '*.css', '*.scss', '*.html', '*.erb', '*.json', '*.xml',
                          \ 'yarn.lock', 'package.json', 'Gemfile.lock', 'Gemfile', 'Procfile', 'Guardfile', 'vendor/assets/*',
                          \]

"--------------------------
" Emmet - tab for expansion
let g:user_emmet_expandabbr_key='<Tab>'
imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")

"-------------------------
" Lightline

function! LightlineTags()
    return '%{gutentags#statusline("⚙tags...")}'
endfunction

function! LightlineObsession()
  return '%{ObsessionStatus("⚡️", "🚫")}'
endfunction

function! LightlineReadonly()
  return &readonly ? '' : ''
endfunction

function! LightlineFugitive()
  if exists('*fugitive#head')
    let branch = fugitive#head()
    return branch !=# '' ? ''.branch : ''
  endif
  return ''
endfunction

let g:lightline = {
\   'colorscheme': 'onedark',
\   'component': { 'lineinfo': '⭡ %3l:%-2v', 'close': "\uf00d", },
\   'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
\   'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" },
\ }
let g:lightline.component_function = {
\  'readonly': 'LightlineReadonly',
\  'gitbranch': 'LightlineFugitive',
\  'bufferinfo': 'lightline#buffer#bufferinfo'
\}
let g:lightline.component_expand = {
\  'buffers': 'lightline#bufferline#buffers',
\  'obsession': 'LightlineObsession',
\  'tags': 'LightlineTags'
\ }
let g:lightline.component_type = {
\  'paste': 'warning',
\  'buffers': 'tabsel',
\ }
let g:lightline.active = {
\  'left': [['mode', 'paste'], ['gitbranch', 'readonly', 'filename', 'modified']],
\  'right': [['percent', 'lineinfo'], ['fileformat', 'fileencoding', 'filetype', 'filesize'], ['tags']]
\ }
let g:lightline.inactive = g:lightline.active
let g:lightline.tabline = {
\  'left': [['obsession', 'tags'],['tabs']],
\  'right': []
\ }
let g:lightline#bufferline#filename_modifier = ':t'
let g:lightline#bufferline#show_number=2
let g:lightline#bufferline#enable_devicons=1
let g:lightline#bufferline#unicode_symbols=1
let g:lightline#bufferline#number_map = {
\ 0: '0 ', 1: '1 ', 2: '2 ', 3: '3 ', 4: '4 ',
\ 5: '5 ', 6: '6 ', 7: '7 ', 8: '8 ', 9: '9 '}
nmap <Leader>1 <Plug>lightline#bufferline#go(1)
nmap <Leader>2 <Plug>lightline#bufferline#go(2)
nmap <Leader>3 <Plug>lightline#bufferline#go(3)
nmap <Leader>4 <Plug>lightline#bufferline#go(4)
nmap <Leader>5 <Plug>lightline#bufferline#go(5)
nmap <Leader>6 <Plug>lightline#bufferline#go(6)
nmap <Leader>7 <Plug>lightline#bufferline#go(7)
nmap <Leader>8 <Plug>lightline#bufferline#go(8)
nmap <Leader>9 <Plug>lightline#bufferline#go(9)
nmap <Leader>0 <Plug>lightline#bufferline#go(10)

" status line colors
let s:palette = g:lightline#colorscheme#{g:lightline.colorscheme}#palette
" let s:palette.normal.middle = [ [ 'NONE', 'NONE', 'NONE', 'NONE' ] ]
" let s:palette.inactive.middle = s:palette.normal.middle
" let s:palette.normal.left = [ [ 'NONE', 'NONE', 'NONE', 233 ] ]
" let s:palette.inactive.left = s:palette.normal.left
" let s:palette.normal.right = s:palette.normal.left
" let s:palette.inactive.right = s:palette.normal.left

" tab colors
let s:palette.tabline.tabsel = [ [ '#282C34', '#61afef', 253, 233, 'bold' ] ]
" let s:palette.tabline.middle = s:palette.normal.middle
" unlet s:palette


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
let NERDTreeAutoDeleteBuffer = 1
silent! nmap <silent> <Leader>e :NERDTreeToggle<CR>
silent! nmap <silent> <leader>f :NERDTreeFind<CR>

"-------------------------
" NERDCommenter

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Support JSX comments
let g:NERDCustomDelimiters={
\ "javascript.jsx": { "left": "//", "right": "", "leftAlt": "{/*", "rightAlt": "*/}" },
\}

map <leader>/ <plug>NERDCommenterToggle<CR>

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
" Magit
" ---------------------------------------------------------------------------

" Push to remote
nnoremap <leader>gP :! git push<CR>  " git Push
let g:magit_discard_untracked_do_delete=1

" ---------------------------------------------------------------------------
" Fugitive
" ---------------------------------------------------------------------------

" Show commits for every source line
nnoremap <Leader>gb :Gblame<CR>  " git blame

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
" autocmd ColorScheme * highlight VertSplit guibg=NONE
" autocmd ColorScheme * highlight NonText guifg=bg

" ---------------------------------------------------------------------------
" rcodetools
" ---------------------------------------------------------------------------
" autocmd FileType ruby nmap <buffer> <C-m> <Plug>(xmpfilter-mark)
" autocmd FileType ruby nmap <buffer> <C-r> <Plug>(xmpfilter-run)
