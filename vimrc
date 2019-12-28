" set nocompatible

so ~/.vim/plugins.vim
so ~/.vim/config/base.vim
so ~/.vim/config/look_and_feel.vim
so ~/.vim/config/text_formatting.vim
so ~/.vim/config/key_mappings.vim
so ~/.vim/config/git.vim
so ~/.vim/config/tags.vim
so ~/.vim/config/lang.vim
so ~/.vim/config/linters.vim
so ~/.vim/config/testing.vim
so ~/.vim/config/nerdtree.vim
so ~/.vim/config/surround.vim
so ~/.vim/config/snippets.vim
so ~/.vim/config/fzf.vim
" so ~/.vim/config/denite.vim
" so ~/.vim/config/coc.vim

let &showbreak='  '
vmap j gj
vmap k gk
nmap j gj
nmap k gk
command! -nargs=* Wrap set wrap linebreak breakindent
