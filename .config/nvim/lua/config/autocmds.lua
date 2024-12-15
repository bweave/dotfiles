-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- auto-restore sessions
vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("Sessions", { clear = true }),
  callback = function()
    print("Checking if we should load session...")
    if vim.fn.argc() == 0 and not vim.g.started_with_stdin then
      print("Loading session...")
      require("persistence").load()
      require("nvim-tree.api").tree.toggle(false, true)
    end
  end,
  nested = true,
})
