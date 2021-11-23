paq {'kosayoda/nvim-lightbulb'}

vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]] -- lsp lightbulb
