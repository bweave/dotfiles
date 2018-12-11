set nocompatible " be iMproved

" Begin Vundle
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

"--------------------------
" tpope plugins
"--------------------------
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rhubarb'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-obsession'

"--------------------------
" utility
"--------------------------
Plugin 'optroot/auto-pairs'
Plugin 'scrooloose/nerdcommenter'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'airblade/vim-gitgutter'
Plugin 'alvan/vim-closetag'
Plugin 'jszakmeister/vim-togglecursor'
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'w0rp/ale'
Plugin 'benmills/vimux'
Plugin 'jgdavey/vim-turbux'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'josemarluedke/airline-tabline-folder-formatter.vim'
Plugin 'vim-scripts/Tabmerge'
Plugin 'godlygeek/tabular'
Plugin 'jreybert/vimagit'

"--------------------------
" tools to explore the file system
"--------------------------
Plugin 'corntrace/bufexplorer'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'vim-scripts/ctags.vim'
Plugin 'mileszs/ack.vim'
Plugin 'epmatsw/ag.vim'

set rtp+=/usr/local/bin/fzf
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'

Plugin 'ludovicchabant/vim-gutentags'

"--------------------------
" language and syntax
"--------------------------
Plugin 'gabrielelana/vim-markdown'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'

call vundle#end()            " required
filetype plugin indent on    " required
