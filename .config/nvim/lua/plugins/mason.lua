-- add any tools you want to have installed below
return {
  "williamboman/mason.nvim",
  opts = {
    -- Dont' install Ruby tools with Mason. They must be installed manually.
    exclude = { "rubocop", "ruby_lsp", "solargraph", "syntax_tree" },
    ensure_installed = {
      "bash-language-server",
      "css-lsp",
      "eslint-lsp",
      "flake8",
      "gopls",
      "html-lsp",
      "json-lsp",
      "lua-language-server",
      "selene",
      "shellcheck",
      "shfmt",
      "sqlls",
      "stylua",
      "typescript-language-server",
      "yaml-language-server",
    },
  },
}
