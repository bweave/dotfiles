" =======================
" Status Line - Lightline
" =======================

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
      \   'colorscheme': 'one',
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
      \  'left': [['obsession'],['tabs']],
      \  'right': []
      \ }

" tab colors
let s:palette = g:lightline#colorscheme#{g:lightline.colorscheme}#palette
let s:palette.tabline.tabsel = [ [ '#282C34', '#61afef', 253, 233, 'bold' ] ]
let s:palette.tabline.middle = s:palette.normal.middle
unlet s:palette
