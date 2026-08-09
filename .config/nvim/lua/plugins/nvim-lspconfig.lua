return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = {
      enabled = false,
    },
    servers = {
      eslint = {},
      yamlls = {
        settings = {
          yaml = {
            format = {
              -- Disable yamlls formatting — it uses prettier internally which
              -- collapses block-style YAML into flow-style (single-line) output
              enable = false,
            },
          },
        },
      },
      ruby_lsp = {
        mason = false,
        cmd = function(dispatchers, config)
          local root_dir = config and (config.cmd_cwd or config.root_dir)
          -- ruby-lsp sends semanticTokens/full/delta responses after Neovim
          -- has cleared the callback (e.g. on restart). Swallow that specific
          -- error rather than logging noise on every startup.
          local orig_on_error = dispatchers.on_error
          dispatchers.on_error = function(code, err)
            if code == vim.lsp.rpc.client_errors.NO_RESULT_CALLBACK_FOUND then return end
            if orig_on_error then orig_on_error(code, err) end
          end
          -- devbox projects manage Ruby via nix/direnv — pass through the
          -- environment as-is so devbox's ruby-lsp is used. Non-devbox projects
          -- need the strip so stale nix vars from a previous direnv session don't
          -- override rbenv's gem paths.
          local uses_devbox = root_dir and vim.fn.filereadable(root_dir .. "/devbox.json") == 1
          local cmd = uses_devbox
            and { "ruby-lsp" }
            or  {
                  "env", "-u", "BUNDLE_GEMFILE", "-u", "RUBYGEMS_GEMDEPS",
                  "-u", "GEM_HOME", "-u", "GEM_PATH", "-u", "GEMRC",
                  "-u", "RUBYLIB", "-u", "RUBY_CONFDIR",
                  "ruby-lsp",
                }
          return vim.lsp.rpc.start(cmd, dispatchers, root_dir and { cwd = root_dir })
        end,
        -- Projects with both gems (e.g. rubocop-rails-omakase + syntax_tree)
        -- follow the syntax_tree README pattern: syntax_tree formats,
        -- rubocop lints. "auto" picks rubocop-as-formatter first so we
        -- set these explicitly. Both run as in-process ruby-lsp add-ons,
        -- so no separate LSPs needed. In rubocop-only projects, drop
        -- `formatter` back to "auto".
        init_options = {
          formatter = "syntax_tree",
          linters = { "rubocop" },
        },
      },
    },
    setup = {
      eslint = function()
        Snacks.util.lsp.on({ name = "eslint" }, function(_, client)
          client.server_capabilities.documentFormattingProvider = true
        end)
        Snacks.util.lsp.on({ name = "tsserver" }, function(_, client)
          client.server_capabilities.documentFormattingProvider = false
        end)
      end,
      -- ruby-lsp 0.26.9 throws InvalidLocationError in find_char_position on
      -- documentHighlight/signatureHelp requests — disable those providers so
      -- Snacks.words and signature popups don't trigger server errors.
      ruby_lsp = function()
        Snacks.util.lsp.on({ name = "ruby_lsp" }, function(_, client)
          client.server_capabilities.documentHighlightProvider = false
          client.server_capabilities.signatureHelpProvider = nil
        end)
      end,
    },
  },
}
