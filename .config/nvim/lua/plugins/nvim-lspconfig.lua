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
        -- Clear devbox/bundler env vars so rbenv's ruby-lsp resolves gems
        -- from rbenv's gem path instead of nix store paths.
        cmd = function(dispatchers, config)
          local root_dir = config and (config.cmd_cwd or config.root_dir)
          return vim.lsp.rpc.start(
            {
              "env", "-u", "BUNDLE_GEMFILE", "-u", "RUBYGEMS_GEMDEPS",
              "-u", "GEM_HOME", "-u", "GEM_PATH", "-u", "GEMRC",
              "-u", "RUBYLIB", "-u", "RUBY_CONFDIR",
              "ruby-lsp",
            },
            dispatchers,
            root_dir and { cwd = root_dir }
          )
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
