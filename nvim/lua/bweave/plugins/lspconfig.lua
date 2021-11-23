paq {'neovim/nvim-lspconfig'}
paq {'ojroques/nvim-lspfuzzy'}

local lsp = require 'lspconfig'
lsp.solargraph.setup {
  settings = {
    solargraph = {
      diagnostics = true,
      bundlerPath = '~/.rbenv/shims/bundle'
    }
  }
}
lsp.tsserver.setup {}

require 'lspfuzzy'.setup {}  -- Make the LSP client use FZF instead of the quickfix list

-- See `:help vim.lsp.*` for documentation on any of the below funcs
map("n", "<leader>F", "<cmd>lua vim.lsp.buf.formatting()<CR>")
map('n', '<A-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
map('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
map('n', '<leader>K', '<cmd>lua vim.lsp.buf.hover()<CR>')
map('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
map('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
map('n', '<leader>gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
map('n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
map('n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
map('n', '<leader>gn', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
map('n', '<leader>gp', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
map('n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>')
map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
map('n', '<leader>sl', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>')
-- map('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workleader_folder()<CR>')
-- map('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workleader_folders()))<CR>')
-- map('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workleader_folder()<CR>')
