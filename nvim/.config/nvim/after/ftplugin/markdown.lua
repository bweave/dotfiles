--
-- after/ftplugin/markdown.lua
--

local nbufmap = require("bweave.utils").nbufmap

vim.opt_local.wrap = true
vim.opt_local.smartindent = true
nbufmap("j", "gj", "Move down by screen lines")
nbufmap("k", "gk", "Move up by screen lines")
