" ======================
" Key Mappings
" ======================

let mapleader = "\<Space>"

" Quickly edit/reload the vimrc file
nnoremap <silent> <leader>ev :e ~/.vimrc<CR>
nnoremap <silent> <leader>ep :e ~/.vim/plugins.vim<CR>
nnoremap <silent> <leader>ec :CocConfig<CR>
nnoremap <silent> <leader>rv :so $MYVIMRC<CR>

" Navigating Splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Map Ctrl-p to FZF
nnoremap <silent> <C-p> :Files<cr>
nnoremap <silent> <leader>b :Buffers<cr>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Toggle hlsearch with <leader>hs
nmap <leader>hs :set hlsearch! hlsearch?<CR>

" Align blocks of text and keep them selected
vmap < <gv
vmap > >gv

" Buffers
" nnoremap <leader>b :Buffers<CR>

" Delete buffer
nnoremap <leader>w :bd<CR>

" Tags in current file
nnoremap t :BTags<CR>

" Replace
nnoremap <C-s> :%s//<left>
vmap <C-s> :s//<left>

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

" Color themes
nnoremap <leader>c :Colors<CR>

" Esc to normal mode in terminal
tnoremap <Esc><Esc> <C-\><C-n>

" vim-test
nnoremap <leader>t :TestFile<CR>
nnoremap <leader>T :TestNearest<CR>

" Vim + Tmux: run command
nnoremap <Leader>vp :VimuxPromptCommand<CR>

" Splitjoin
let g:splitjoin_split_mapping = ''
let g:splitjoin_join_mapping = ''
nmap sj :SplitjoinJoin<CR>
nmap ss :SplitjoinSplit<CR>

" Search with Silver Searcher
if executable('ag')
  let $FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
  set grepprg=ag\ --nogroup\ --nocolor
  " Ag search current selection
  nnoremap s :Ag <C-R><C-W><CR>
  "<leader>s to Silver Searcher
  nnoremap <leader>s :Ag!<space>
end

" Format json strings
com! FormatJSON %!python -m json.tool

" Magit
nmap <silent> <leader>gs :Magit<CR>

" Go to definition
map <leader>gd :exec("tag ".expand("<cword>"))<cr>

" NERDTree
silent! nmap <silent> <Leader>e :NERDTreeToggle<CR>
silent! nmap <silent> <leader>f :NERDTreeFind<CR>

" NERDCommenter
map <leader>/ <plug>NERDCommenterToggle<CR>

" Open alternate file, e.g. test, for current file - requires tpope/vim-rails
map <leader><tab> :A<cr>
map <leader><leader><tab> :AV<cr>

" Emmet - tab for expansion
let g:user_emmet_expandabbr_key='<Tab>'
imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")

" Git
" Jump between hunks
nmap <Leader>gn <Plug>GitGutterNextHunk  " git next
nmap <Leader>gp <Plug>GitGutterPrevHunk  " git previous
" Hunk-add and hunk-revert for chunk staging
nmap <Leader>ga <Plug>GitGutterStageHunk  " git add (chunk)
nmap <Leader>gu <Plug>GitGutterUndoHunk   " git undo (chunk)
" Push to remote
nnoremap <leader>gP :! git push<CR>
" Show git blame
nnoremap <Leader>gb :Gblame<CR>
