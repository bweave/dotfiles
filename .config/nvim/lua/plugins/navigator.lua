return {
  "numToStr/Navigator.nvim",
  config = function()
    require("Navigator").setup({
      -- Save modified buffer(s) when moving to mux
      -- nil - Don't save (default)
      -- 'current' - Only save the current modified buffer
      -- 'all' - Save all the buffers
      auto_save = nil,

      -- Disable navigation when the current mux pane is zoomed in
      disable_on_zoom = false,

      -- Multiplexer to use
      -- 'auto' - Chooses mux based on priority (default)
      -- table - Custom mux to use
      mux = "auto",
    })
  end,
  keys = {
    { "<C-h>", "<cmd>NavigatorLeft<cr>", mode = { "n", "t" } },
    { "<C-j>", "<cmd>NavigatorDown<cr>", mode = { "n", "t" } },
    { "<C-k>", "<cmd>NavigatorUp<cr>", mode = { "n", "t" } },
    { "<C-l>", "<cmd>NavigatorRight<cr>", mode = { "n", "t" } },
  },
}
