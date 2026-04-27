return {
  "f-person/auto-dark-mode.nvim",
  opts = {
    set_dark_mode = function()
      vim.api.nvim_set_hl(0, "Cursor", {})
      vim.o.background = "dark"
      vim.cmd.colorscheme("catppuccin-mocha")
    end,
    set_light_mode = function()
      vim.api.nvim_set_hl(0, "Cursor", {})
      vim.o.background = "light"
      vim.cmd.colorscheme("github_light_high_contrast")
    end,
  },
}
