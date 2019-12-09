" ======================
" Denite
" ======================

try " Wrap in try/catch to avoid errors on initial install before plugin is available
" Use ag
call denite#custom#var('file/rec', 'command', ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'default_opts', ['-i', '--vimgrep'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])
call denite#custom#source('file_rec', 'sorters', ['sorter_sublime'])
call denite#custom#filter('matcher_ignore_globs', 'ignore_globs', [ '.git/', 'node_modules/', 'images/', '*.min.*', 'img/', 'fonts/', '*.png'])

" Custom options for Denite
"   auto_resize             - Auto resize the Denite window height automatically.
"   prompt                  - Customize denite prompt
"   direction               - Specify Denite window direction as directly below current pane
"   winminheight            - Specify min height for Denite window
"   highlight_mode_insert   - Specify h1-CursorLine in insert mode
"   prompt_highlight        - Specify color of prompt
"   highlight_matched_char  - Matched characters highlight
"   highlight_matched_range - matched range highlight
      " \ 'split': 'floating',
let s:denite_options = {'default' : {
      \ 'start_filter': 1,
      \ 'auto_resize': 1,
      \ 'source_names': 'short',
      \ 'prompt': '>> ',
      \ 'reversed': 1,
      \ 'statusline': 0,
      \ 'highlight_matched_char': 'None',
      \ 'highlight_matched_range': 'Visual',
      \ 'highlight_window_background': 'Visual',
      \ 'highlight_filter_background': 'DiffAdd',
      \ 'winrow': 1,
      \ 'winheight': 10,
      \ 'winminheight': 1,
      \ 'vertical_preview': 1
      \ }}

" Loop through denite options and enable them
function! s:profile(opts) abort
  for l:fname in keys(a:opts)
    for l:dopt in keys(a:opts[l:fname])
      call denite#custom#option(l:fname, l:dopt, a:opts[l:fname][l:dopt])
    endfor
  endfor
endfunction

call s:profile(s:denite_options)
catch
  echo 'Denite not installed. It should work after running :PlugInstall'
endtry

" Define mappings while in 'filter' mode
"   <C-o>         - Switch to normal mode inside of search results
"   <Esc>         - Exit denite window in any mode
"   <CR>          - Open currently selected file in any mode
"   <C-t>         - Open currently selected file in a new tab
"   <C-v>         - Open currently selected file a vertical split
"   <C-h>         - Open currently selected file in a horizontal split
autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
  imap <silent><buffer> <C-o> <Plug>(denite_filter_quit)
  inoremap <silent><buffer><expr> <Esc> denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Esc> denite#do_map('quit')
  inoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
  inoremap <silent><buffer><expr> <C-t> denite#do_map('do_action', 'tabopen')
  inoremap <silent><buffer><expr> <C-v> denite#do_map('do_action', 'vsplit')
  inoremap <silent><buffer><expr> <C-h> denite#do_map('do_action', 'split')
endfunction

" Define mappings while in denite window
"   <CR>        - Opens currently selected file
"   q or <Esc>  - Quit Denite window
"   d           - Delete currenly selected file
"   p           - Preview currently selected file
"   <C-o> or i  - Switch to insert mode inside of filter prompt
"   <C-t>       - Open currently selected file in a new tab
"   <C-v>       - Open currently selected file a vertical split
"   <C-h>       - Open currently selected file in a horizontal split
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
  nnoremap <silent><buffer><expr> q denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Esc> denite#do_map('quit')
  nnoremap <silent><buffer><expr> d denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> i denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <C-o> denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <C-t> denite#do_map('do_action', 'tabopen')
  nnoremap <silent><buffer><expr> <C-v> denite#do_map('do_action', 'vsplit')
  nnoremap <silent><buffer><expr> <C-h> denite#do_map('do_action', 'split')
endfunction

" Denite Custom Menus
let s:menus = {}

let s:menus.ZSH = { 'description': 'ZSH config' }
let s:menus.ZSH.file_candidates = [
    \ ['zshrc', '~/.zshrc'],
    \ ['zshenv', '~/.zshenv'],
    \ ['aliases', '~/.aliases'],
    \ ]

let s:menus.VIM = { 'description': 'Vim config' }
let s:menus.VIM.file_candidates = [
      \ ['Edit vimrc', '~/.vimrc'],
      \ ['Edit plugins', '~/.vim/plugins.vim'],
      \ ]
let s:menus.VIM.command_candidates = [
      \ ['Reload config', 'so $MYVIMRC'],
      \ ['Install plugins', 'PluginInstall'],
      \ ]

let s:menus.BOX = { 'description': 'PCO Box' }
let s:menus.BOX.command_candidates = [
    \ ['Start', '!box start'],
    \ ['Restart', '!box restart'],
    \ ['Stop', '!box stop'],
    \ ['Restart App', '!box restart-app'],
    \ ['Restart Nginx', '!box restart-nginx'],
    \ ]

call denite#custom#var('menu', 'menus', s:menus)

" Mappings
nmap <C-p> :Denite file/rec<CR>
nmap <leader>b :Denite buffer<CR>
nnoremap <leader>s :Denite grep<CR>
nnoremap <C-s> :DeniteCursorWord grep:.<CR>
