set nocompatible " be iMproved

" Begin Vundle
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'chrisbra/Colorizer'

"--------------------------
" tpope plugins
"--------------------------
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rhubarb'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-obsession'
Plugin 'tpope/vim-projectionist'

"--------------------------
" colors
"--------------------------
Plugin 'ayu-theme/ayu-vim'
Plugin 'junegunn/seoul256.vim'
Plugin 'morhetz/gruvbox'
Plugin 'shinchu/lightline-gruvbox.vim'
Plugin 'whatyouhide/vim-gotham'
Plugin 'AlessandroYorba/Sierra'
Plugin 'liuchengxu/space-vim-dark'
Plugin 'rakr/vim-one'

"--------------------------
" utility
"--------------------------
Plugin 'mhinz/vim-startify'
Plugin 'optroot/auto-pairs'
Plugin 'scrooloose/nerdcommenter'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'airblade/vim-gitgutter'
Plugin 'alvan/vim-closetag'
Plugin 'jszakmeister/vim-togglecursor'
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'w0rp/ale'
Plugin 'mattn/emmet-vim'
Plugin 'itchyny/lightline.vim'
Plugin 'mengelbrecht/lightline-bufferline'
Plugin 'ryanoasis/vim-devicons'
Plugin 'vim-scripts/Tabmerge'
Plugin 'godlygeek/tabular'
Plugin 'jreybert/vimagit'
Plugin 'matze/vim-move'
Plugin 'tmhedberg/matchit'
Plugin 'Valloric/MatchTagAlways'
Plugin 'janko/vim-test'
Plugin 'benmills/vimux'

"--------------------------
" tools to explore the file system
"--------------------------
Plugin 'jlanzarotta/bufexplorer'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'mileszs/ack.vim'
Plugin 'epmatsw/ag.vim'

set rtp+=/usr/local/bin/fzf
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'

Plugin 'ludovicchabant/vim-gutentags'

" Denite
Plugin 'roxma/vim-hug-neovim-rpc'
Plugin 'roxma/nvim-yarp'
Plugin 'Shougo/denite.nvim'

"--------------------------
" language and syntax
"--------------------------
Plugin 'plasticboy/vim-markdown'
Plugin 'iamcco/markdown-preview.nvim'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'leafgarland/typescript-vim'

"--------------------------
" Completion
"--------------------------
" TODO: try out nvim-lsp once it's in a tagged version


"--------------------------
" Ruby Refactoring
"--------------------------
Plugin 'ecomba/vim-ruby-refactoring'

call vundle#end()            " required
filetype plugin indent on    " required
