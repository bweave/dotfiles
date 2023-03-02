--
-- after/ftplugin/lua.lua
--

vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function()
		vim.lsp.buf.format()
	end,
	group = vim.api.nvim_create_augroup("BwLuaAutocmds", { clear = true }),
})
