-- add more treesitter parsers
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    indent = {
      enable = true,
      -- Treesitter indent for Ruby is buggy: reindents `def`/`end` to column 0
      -- mid-typing. Vim's built-in ruby indent handles this correctly.
      disable = { "ruby" },
    },
    ensure_installed = {
      "bash",
      "css",
      "dockerfile",
      "go",
      "html",
      "javascript",
      "jsdoc",
      "json",
      "lua",
      "markdown",
      "markdown_inline",
      "python",
      "query",
      "regex",
      "ruby",
      "sql",
      "toml",
      "tsx",
      "typescript",
      "vim",
      "yaml",
    },
  },
}
