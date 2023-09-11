--
-- after/ftplugin/markdown.lua
--

local nmap = require("bweave.utils").nmap

vim.opt_local.wrap = true
vim.opt_local.smartindent = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
nmap("j", "gj", "Move down by screen lines")
nmap("k", "gk", "Move up by screen lines")
