-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local options = {
  cursorline = true,
  number = true,
  relativenumber = false,
}

for k, v in pairs(options) do
  vim.o[k] = v
end
