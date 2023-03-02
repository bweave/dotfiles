--
-- after/ftplugin/javascript.lua
--

local cmd = vim.cmd
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local auGroup = augroup("BwJsAutocmds", {})

cmd('iabbrev <buffer> wiplog console.log("WIPLOG", )<left>')

autocmd("BufWritePre", {
	command = "silent! EslintFixAll",
	group = auGroup,
})
