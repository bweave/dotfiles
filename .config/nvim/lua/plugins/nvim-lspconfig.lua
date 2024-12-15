return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = {
      enabled = false,
    },
    servers = {
      eslint = {},
      ruby_lsp = {
        mason = false,
        -- You need to install rubocop and ruby-lsp: gem install ruby-lsp rubocop
        init_options = {
          formatter = "rubocop",
          linters = { "rubocop" },
        },
      },
      syntax_tree = {
        -- You need to install syntax_tree: gem install syntax_tree
        mason = false,
      },
    },
    setup = {
      eslint = function()
        require("lazyvim.util").lsp.on_attach(function(client)
          if client.name == "eslint" then
            client.server_capabilities.documentFormattingProvider = true
          elseif client.name == "tsserver" then
            client.server_capabilities.documentFormattingProvider = false
          end
        end)
      end,
    },
  },
}
