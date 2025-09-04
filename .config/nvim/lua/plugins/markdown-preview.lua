return {
  "iamcco/markdown-preview.nvim",
  config = function()
    vim.cmd([[do FileType]])
    vim.g.mkdp_theme = "light"

    -- if style.css is not found in the current directory, use the default style
    local style = vim.fn.expand("%:h") .. "/style.css"
    if vim.fn.filereadable(style) == 0 then
      style = vim.fn.stdpath("config") .. "/style.css"
    end
  end,
}
