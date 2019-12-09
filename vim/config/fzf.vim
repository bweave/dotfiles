" ======================
" FZF
" ======================
" Enable preview for Files
command! -bang -nargs=? -complete=dir Files
      \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

if has('nvim') " Nvim gets a floating up top window that's kinda cool
  let $FZF_DEFAULT_OPTS .= ' --layout=reverse'

  function! FloatingFZF()
    let buf = nvim_create_buf(v:false, v:true)

   " here be dragoons
    let height = &lines
    let width = float2nr(&columns - (&columns * 2 / 10))
    let col = float2nr((&columns - width) / 2)
    let col_offset = &columns / 10
    let opts = {
          \ 'relative': 'editor',
          \ 'row': 1,
          \ 'col': col + col_offset,
          \ 'width': width * 2 / 1,
          \ 'height': height / 2
          \ }

    let win = nvim_open_win(buf, v:true, opts)
   " uncomment this if you want a normal background color for the fzf window
    "call setwinvar(win, '&winhighlight', 'NormalFloat:Normal')
    call setwinvar(win, '&winhl', 'NormalFloat:Pmenu')

  " this is to remove all line numbers and so on from the window
    setlocal
          \ buftype=nofile
          \ nobuflisted
          \ bufhidden=hide
          \ nonumber
          \ norelativenumber
          \ signcolumn=no
  endfunction

  let g:fzf_layout = { 'window': 'call FloatingFZF()' }
endif

" Custom FZF func for deleting buffers - Shift + Tab to mark multiple
function! Bufs()
  redir => list
  silent ls
  redir END
  return split(list, "\n")
endfunction

command! BD call fzf#run(fzf#wrap({
      \ 'source': Bufs(),
      \ 'sink*': { lines -> execute('bwipeout '.join(map(lines, {_, line -> split(line)[0]})))  },
      \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept'
      \ }))
nnoremap silent <leader>bd :BD<CR>
