" ======================
" NERDTree
" ======================

let NERDTreeShowBookmarks = 0
let NERDChristmasTree = 1
let NERDTreeWinPos = "left"
let NERDTreeHijackNetrw = 1
let NERDTreeWinSize = 40
let NERDTreeChDirMode = 2
let NERDTreeDirArrows = 1
let NERDTreeMinimalUI=1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeStatusline=""

" NERDCommenter
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Support JSX comments
let g:NERDCustomDelimiters={
\ "javascript.jsx": { "left": "//", "right": "", "leftAlt": "{/*", "rightAlt": "*/}" },
\}
