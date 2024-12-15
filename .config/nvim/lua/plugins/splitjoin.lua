return {
  "AndrewRadev/splitjoin.vim",
  config = function()
    -- remove default mappings
    vim.g.splitjoin_split_mapping = ""
    vim.g.splitjoin_join_mapping = ""
    -- use trailing commas
    vim.g.splitjoin_trailing_comma = 1
    -- disable weird hanging args in ruby since lsp formatting handles it
    vim.g.splitjoin_ruby_hanging_args = 0
  end,
}
