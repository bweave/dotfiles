-- Autocommands

local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')

-- Autocommands

cmd 'autocmd VimResized * wincmd ='       -- automatically resize splits when resizing the window
cmd 'autocmd FileType javascript iabbrev <buffer> wiplog console.log("WIPLOG",)<left>' -- wiplog JS
cmd 'autocmd FileType ruby iabbrev <buffer> wiplog Rails.logger.debug "=" * 80<CR>Rails.logger.debug <CR>Rails.logger.debug "=" * 80<Up>' -- wiplog Ruby
cmd 'autocmd FileType gitcommit iabbrev <buffer> co Co-authored-by: SOMEONE <HANDLE@users.noreply.github.com>' -- Co-authored-by
cmd 'autocmd FileType php setlocal tabstop=4 shiftwidth=4 softtabstop=4' -- php
cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]] -- lsp lightbulb
