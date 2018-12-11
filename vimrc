set nocompatible              " be iMproved, required

so ~/.vim/plugins.vim



" Settings
set autoread





" Clipboard
set clipboard=unnamed





" GUI
syntax on
syntax enable
set t_CO=Fira_Mono_for_Powerline:17
set background=dark
set laststatus=2
set updatetime=750
set number
set relativenumber
set tabstop=2
set shiftwidth=2
set expandtab
set backspace=2 " make backspace work like most other apps
set linespace=15
set encoding=utf-8
set breakindent
set incsearch
set hlsearch
set ignorecase
set smartcase
set splitbelow
set splitright



" Airline
let g:airline_theme="distinguished"




" Resizing
nnoremap <S-Left> :vertical resize +5<CR>
nnoremap <S-Right> :vertical resize -5<CR>
nnoremap <S-Up> :resize +10<CR>
nnoremap <S-Down> :resize -10<CR>




" Neomake
let g:neomake_logfile = '/usr/local/var/log/neomake.log'
let g:neomake_javascript_eslint_exe = $PWD .'/node_modules/.bin/eslint'
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_javascript_eslint_args = ['-f', 'compact', '--fix']
let g:neomake_ruby_rubocop_exe = $PWD . "/bin/rubocop"




" Atags
" only generate tags for files NOT in .gitignore
let g:atags_build_commands_list = [
    \ 'ag -g "" | ctags -L - --fields=+l -f tags.tmp',
    \ 'awk "length($0) < 400" tags.tmp > tags',
    \ 'rm tags.tmp'
    \ ]




" Auto Commands
augroup autosourcing
  autocmd!
  autocmd BufWritePost .vimrc source %
augroup END

augroup eslinting
  autocmd!
  " Call neomake#Make directly instead of the Neomake provided command so we can inject the callback
  autocmd BufWritePost * call neomake#Make(1, [], function('s:Neomake_callback'))

  " Callback for reloading file in buffer when eslint has finished and maybe has autofixed some stuff
  function! s:Neomake_callback(options)
    if (a:options.name ==? 'eslint') && (a:options.has_next == 0)
      checktime
    endif
  endfunction
augroup END

augroup tags
  " autocmd BufWritePost * call atags#generate()
augroup END

augroup visuals_and_such
  autocmd!
  " Trim trailing whitespace
  autocmd BufWritePre * kz|:%s/\s\+$//e|'z
  autocmd VimResized * :wincmd =
augroup END





" PLUGINS ===========================================================





" CtrlP
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:30,results:30'





" Mouse
set mouse+=a





" The Silver Searcher
if executable('ag')
	" Use ag over grep
	set grepprg=ag\ --nogroup\ --nocolor

	" Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
	let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

	" ag is fast enough that CtrlP doesn't need to cache
	let g:ctrlp_use_caching = 0
endif





" Mappings
let mapleader = "\<Space>"
nmap <Leader>ev :tabedit $MYVIMRC<cr>
nmap <Leader>ep :tabedit ~/.vim/plugins.vim<cr>
nmap <Leader>es :e ~/.vim/snippets/
nmap <Leader>b :CtrlPBuffer<cr>
nmap <c-e> :CtrlPMRUFiles<cr>
nnoremap <C-g> :NERDTreeToggle<cr>
map <leader><tab> :AV<cr>
map <C-]> :vsp <cr>:exec("tag ".expand("<cword>"))<cr>
map <leader><C-\> :tab split<cr>:exec("tag ".expand("<cword>"))<cr>
map <leader>i mmgg=G`m
map <leader>p :set paste<cr><esc>"*]p:set nopaste<cr>
map <cr> :nohlsearch<cr>
nnoremap K :grep! "\b<c-R><c-W>\b"<cr>:cw<cr>
imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")





" JSX
let g:jsx_ext_required = 0
let g:user_emmet_settings = {
			\  'javascript' : {
			\      'extends' : 'jsx',
			\  },
			\}
