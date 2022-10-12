let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/dotfiles
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +75 nvim/lua/bweave/functions/fzf-git.lua
badd +1 nvim-minimal.lua
badd +7 nvim/lua/bweave/plugins/ale.lua
badd +30 nvim/lua/bweave/plugins/lspconfig.lua
badd +5 nvim/lua/bweave/plugins.lua
badd +6 nvim/lua/bweave/plugins/nvim-tree.lua
badd +40 nvim/lua/bweave/settings.lua
badd +20 mac_setup
badd +35 cloudbox_setup
badd +18 nvim/lua/bweave/plugins/fzf.lua
badd +1 nvim/lua/bweave/plugins/nvim-fzf.lua
badd +1 nvim/lua/bweave/functions/colors.lua
badd +2 scratch.lua
badd +287 zshrc
argglobal
%argdel
$argadd nvim-minimal.lua
edit zshrc
argglobal
setlocal fdm=marker
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 287 - ((16 * winheight(0) + 16) / 32)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 287
normal! 0
lcd ~/dotfiles
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
nohlsearch
let g:this_session = v:this_session
let g:this_obsession = v:this_session
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
