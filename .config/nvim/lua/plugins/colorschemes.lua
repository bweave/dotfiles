return {
  {
    "loctvl842/monokai-pro.nvim",
    config = function()
      require("monokai-pro").setup({
        transparent_background = true,
      })
    end,
  },
  {
    "neanias/everforest-nvim",
    config = function()
      require("everforest").setup({
        transparent_background_level = 2,
        background = "soft",
      })
    end,
  },
  {
    "ellisonleao/gruvbox.nvim",
    opts = {
      contrast = "soft",
      transparent_mode = true,
    },
  },
  {
    "rebelot/kanagawa.nvim",
    opts = {
      transparent = true,
      theme = "dragon",
    },
  },
  {
    "navarasu/onedark.nvim",
    opts = {
      style = "warmer",
      transparent = true,
    },
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require("rose-pine").setup({
        styles = {
          transparency = true,
        },
      })
    end,
  },
}
