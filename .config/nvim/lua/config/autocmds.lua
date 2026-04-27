-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Reset cursor style and color on exit so terminal/tmux isn't left with nvim's colorscheme cursor
vim.api.nvim_create_autocmd("VimLeave", {
  callback = function()
    io.write("\27]112\7") -- OSC 112: reset cursor color to terminal default
    io.write("\27[2 q") -- DECSCUSR: reset to block cursor
  end,
})
