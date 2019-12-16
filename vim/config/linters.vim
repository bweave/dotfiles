" ======================
" Linters
" ======================

" ALE
let g:ale_ruby_rubocop_executable = 'bundle exec rubocop'
let g:ale_ruby_rubocop_executable = 'bundle'
let g:ale_linters = {
      \   'ruby': ['rubocop'],
      \   'javascript': ['eslint'],
      \   'css': ['eslint'],
      \}
let g:ale_fixers = {
      \   'javascript': ['eslint'],
      \   'css': ['eslint'],
      \}
let g:ale_fix_on_save = 1

" Set this in your vimrc file to disabling highlighting
" let g:ale_set_highlights = 0
" highlight ALEWarning ctermbg=DarkMagenta
