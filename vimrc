set nocompatible              " be iMproved, required

filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" My plugins
Plugin 'vimwiki/vimwiki'
Plugin 'mkitt/tabline.vim'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-rake'
Plugin 'tpope/vim-bundler'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-projectionist'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'scrooloose/nerdcommenter'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'gabesoft/vim-ags'
Plugin 'vim-airline/vim-airline'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'Valloric/YouCompleteMe'
Plugin 'Raimondi/delimitMate'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'thoughtbot/vim-rspec'
Plugin 'atelierbram/Base2Tone-vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'leafgarland/typescript-vim'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'mattn/emmet-vim'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'vincom2/tabmerge-mirror'
Plugin 'pangloss/vim-javascript'
Plugin 'slim-template/vim-slim.git'
Plugin 'mxw/vim-jsx'
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'
Plugin 'ryanoasis/vim-devicons'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" Put your non-Plugin stuff after this line

set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types:h16
let g:airline_powerline_fonts = 1
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1

set runtimepath^=~/.vim/bundle/ctrlp.vim
autocmd VimResized * :wincmd =
let mapleader = "\<Space>"
set laststatus=2
set updatetime=250
set number
set tabstop=2
set shiftwidth=2
set backspace=2 " make backspace work like most other apps
set linespace=3
set anti enc=utf-8
set encoding=utf-8
let g:airline_powerline_fonts=1
set breakindent
set incsearch
set hlsearch
set ignorecase
set smartcase
set splitbelow
set splitright

set mouse+=a
if &term =~ '^screen'
	" tmux knows the extended mouse mode
	set ttymouse=xterm2
endif
if has("mouse_sgr")
	set ttymouse=sgr
else
	set ttymouse=xterm2
end

syntax on
syntax enable
set background=dark

let g:airline_theme='Base2Tone_EveningDark'

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" Mappings
map <C-n> :NERDTreeTabsToggle<CR>
map <C-\> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
map <leader><C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <leader>i mmgg=G`m
map <leader>p :set paste<CR><esc>"*]p:set nopaste<cr>
map <leader>h :nohlsearch<cr>

" Rspec.vim mappings
let g:rspec_runner = "os_x_iterm2"
map <leader>t :call RunCurrentSpecFile()<CR>
map <leader>s :call RunNearestSpec()<CR>
map <leader>l :call RunLastSpec()<CR>
map <leader>a :call RunAllSpecs()<CR>

" Emmet JSX
let g:user_emmet_settings = {
			\  'javascript' : {
			\      'extends' : 'jsx',
			\  },
			\}
