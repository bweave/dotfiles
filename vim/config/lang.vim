" ======================
" Lang
" ======================

" Add support to go to file in JS without file extention
augroup suffixes
  autocmd!
  let associations = [
    \ ["javascript", ".js,.ts,.json,.jsx,.graphql"],
    \ ["typescript", ".js,.ts,.json,.jsx,.graphql"]]

  for ft in associations
    execute "autocmd FileType " . ft[0] . " setlocal suffixesadd=" . ft[1]
  endfor
augroup END

