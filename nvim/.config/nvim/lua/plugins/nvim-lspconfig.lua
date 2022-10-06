--------------------------------------------------------------------------
-- Nvim LSP Config
--------------------------------------------------------------------------

--[[

Language servers setup:

For language servers list see:
https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

HTML/CSS/JSON --> vscode-html-languageserver
https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#html

JavaScript/TypeScript --> tsserver
https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#tsserver

Ruby --> solargraph
https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#solargraph

--]]

local lsp_status_ok, lspconfig = pcall(require, 'lspconfig')
if not lsp_status_ok then
  return
end

vim.diagnostic.config({ virtual_text = true })  -- Diagnostic options, see: `:help vim.diagnostic.config`

-- Show line diagnostics automatically in hover window
-- vim.cmd([[
--   autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, { focus = false })
-- ]])


lspconfig.tsserver.setup {
  on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Highlighting references
    if client.resolved_capabilities.document_highlight then
      vim.api.nvim_exec([[
      augroup lsp_document_highlight
      autocmd! * <buffer>
      autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
      ]], false)
    end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap = true, silent = true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<M-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

    if client.config.flags then
      client.config.flags.allow_incremental_sync = true
    end
    client.resolved_capabilities.document_formatting = false
  end
}

-- EFM Langserver Setup: giving this a shot for eslint_d
-- https://phelipetls.github.io/posts/configuring-eslint-to-work-with-neovim-lsp/
-- https://github.com/mattn/efm-langserver/pull/141#issuecomment-875317418
-- Install: go install github.com/mattn/efm-langserver@latest

local eslint_d = {
  lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
  lintStdin = true,
  lintFormats = {"%f:%l:%c: %m"},
  lintIgnoreExitCode = true,
  formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
  formatStdin = true
}

lspconfig.efm.setup {
  flags = {debounce_text_changes = 1000},
  cmd = {'efm-langserver', '-loglevel', '2', '-logfile', '/tmp/efm.log'},
  init_options = {documentFormatting = true},
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = true
    client.resolved_capabilities.goto_definition = false
    -- client.resolved_capabilities.code_action = nil
    vim.cmd([[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting()]])
  end,
  filetypes = {
    "css",
    "html",
    "javascript",
    "javascriptreact",
    "lua",
  },
  settings = {
    rootMarkers = {".git/"},
    lintDebounce =   "300ms",
    formatDebounce = "300ms",
    languages = {
      javascript = {eslint_d},
      javascriptreact = {eslint_d},
      lua = {
        { formatCommand = "lua-format --indent-width 2 --tab-width 2 --no-use-tab --column-limit 120 --column-table-limit 100 --no-keep-simple-function-one-line --no-chop-down-table --chop-down-kv-table --no-keep-simple-control-block-one-line --no-keep-simple-function-one-line --no-break-after-functioncall-lp --no-break-after-operator",
        formatStdin = true,
      }
    },
  }
}
                                                                                                               }
