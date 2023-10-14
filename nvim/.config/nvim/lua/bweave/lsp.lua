--
-- lua/bweave/lsp/lua
--

local utils = require("bweave.utils")
local nmap = utils.nmap
local vmap = utils.vmap
local installed_via_bundler = utils.installed_via_bundler
local config_exists = utils.config_exists
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

local on_attach = function(client)
  nmap("gd", vim.lsp.buf.definition, "[G]o to [D]efinition")
  nmap("<leader>lgd", vim.lsp.buf.definition, "[G]o to [D]efinition")
  nmap("<leader>lgD", vim.lsp.buf.declaration, "[G]o to [D]eclaration")
  nmap("<leader>li", vim.lsp.buf.implementation, "[I]mplementation")
  nmap("<leader>lr", vim.lsp.buf.references, "[R]eferences")
  nmap("<leader>lS", vim.lsp.buf.signature_help, "[S]ignature Help")
  nmap("<leader>len", vim.diagnostic.goto_next, "[N]ext Diagnostic")
  nmap("<leader>lep", vim.diagnostic.goto_prev, "[P]revious Diagnostic")
  nmap("<F2>", vim.lsp.buf.rename, "Rename")
  nmap("<leader>lD", vim.lsp.buf.type_definition, "Type [D]efinition")
  nmap("<leader>ls", vim.diagnostic.open_float, "[S]how Info")
  nmap("<leader>ll", vim.diagnostic.setloclist, "[L]ist")
  nmap("<leader>lf", vim.lsp.buf.format, "[F]ormat")

  -- fzf-lua helpers
  nmap("<leader>lFa", require("fzf-lua").lsp_finder, "[F]ind [A]ll")
  nmap("<leader>lFr", require("fzf-lua").lsp_references, "[F]ind [R]eferences")
  nmap("<leader>lFd", require("fzf-lua").lsp_definitions, "[F]ind [D]efinitions")
  nmap("<leader>lFD", require("fzf-lua").lsp_declarations, "[F]ind [D]eclarations")
  nmap("<leader>lFe", require("fzf-lua").diagnostics_document, "[F]ind Diagnostics in [D]ocument")
  nmap("<leader>lFw", require("fzf-lua").diagnostics_workspace, "[F]ind Diagnostics in [W]orkspace")
  nmap("<leader>lFc", require("fzf-lua").lsp_code_actions, "[F]ind [C]ode actions")

  if client.name == "rust_analyzer" then
    nmap("<leader>la", require("rust-tools").code_action_group.code_action_group, "Code [A]ction")
    vmap("<leader>la", require("rust-tools").code_action_group.code_action_group, "Code [A]ction")
    nmap("<leader>lk", require("rust-tools").hover_actions.hover_actions("Hover"))
  else
    nmap("<leader>la", vim.lsp.buf.code_action, "Code [A]ction")
    nmap("<leader>lk", vim.lsp.buf.hover, "Hover")
  end

  if client.name == "tsserver" then
    client.server_capabilities.document_formatting = false
    client.server_capabilities.document_range_formatting = false
  end
end

-- virtual text config
vim.diagnostic.config({
  virtual_text = {
    source = "always", -- Or "if_many"
    prefix = "●", -- Could be '■', '▎', 'x'
  },
  severity_sort = true,
  float = {
    source = "always", -- Or "if_many"
  },
})
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "single",
})
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = "single",
})
local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- ruby / rubocop
if not installed_via_bundler("solargraph") and installed_via_bundler("rubocop") and
    config_exists(".rubocop.yml") then
  require("lspconfig").rubocop.setup({
    cmd = { "bundle", "exec", "rubocop", "--lsp" },
    capabilities = capabilities,
    on_attach = on_attach,
  })
end

-- lua
require("neodev").setup({
  library = {
    plugins = { "nvim-treesitter", "plenary.nvim", "gitsigns.nvim" },
  },
})

require("lspconfig").lua_ls.setup({
  settings = {
    Lua = {
      completion = { enable = true, showWord = "Disable" },
      diagnostics = { globals = { "vim", "hs" } },
      hint = { enable = true, arrayIndex = "Disable" },
      format = {
        enable = true,
        defaultConfig = {
          break_all_list_when_line_exceed = "1",
          indent_size = "2",
          indent_style = "space",
          max_line_length = "100",
          quote_style = "double",
          trailing_table_separator = "smart",
        },
      },
      telemetry = { enable = false },
      workspace = { checkThirdParty = false },
    },
  },
  capabilities = capabilities,
  on_attach = on_attach,
})

-- ruby / syntax_tree
if installed_via_bundler("syntax_tree") then
  require("lspconfig").syntax_tree.setup({
    cmd = { "bundle", "exec", "stree", "lsp" },
    capabilities = capabilities,
    on_attach = on_attach,
  })
end

-- ruby / solargraph
if installed_via_bundler("solargraph") then
  require("lspconfig").solargraph.setup({
    cmd = { "bundle", "exec", "solargraph", "stdio" },
    init_options = {
      formatting = false,
    },
    settings = {
      solargraph = {
        diagnostics = true,
      },
    },
    capabilities = capabilities,
    on_attach = on_attach,
  })
end

-- javascript / typescript
-- this plugin calls lspconfig and sets up tsserver
require("typescript").setup({
  disable_commands = false, -- :Typescript* commands
  debug = false,
  server = {
    capabilities = capabilities,
    init_options = {
      disableAutomaticTypingAcquisition = true,
    },
    on_attach = on_attach,
  },
})

-- eslint
require("lspconfig").eslint.setup({
  settings = {
    validate = "on",
    codeAction = {
      disableRuleComment = {
        location = "separateLine",
      },
      showDocumentation = {
        enable = true,
      },
    },
  },
  capabilities = capabilities,
  on_attach = on_attach,
})

-- rust
require("rust-tools").setup({ capabilities = capabilities, on_attach = on_attach })

-- golang
require("lspconfig").gopls.setup({ capabilities = capabilities, on_attach = on_attach })

-- bash scripting
require("lspconfig").bashls.setup({ capabilities = capabilities, on_attach = on_attach })

-- yaml
require("lspconfig").yamlls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    yaml = {
      keyOrdering = false,
    },
  },
})

-- json
require("lspconfig").jsonls.setup({
  init_options = {
    provideFormatter = true,
  },
  capabilities = capabilities,
  on_attach = on_attach,
})

-- html
require("lspconfig").html.setup({ capabilities = capabilities, on_attach = on_attach })

-- css
require("lspconfig").cssls.setup({ capabilities = capabilities, on_attach = on_attach })
