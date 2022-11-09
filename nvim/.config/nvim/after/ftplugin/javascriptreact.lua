----
---- javascriptreact filetype
----

local auGroup = vim.api.nvim_create_augroup("BwJsReactAutocmds", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function()
		-- require("typescript").actions.addMissingImports({ sync = true })
		-- require("typescript").actions.organizeImports({ sync = true })
		-- require("typescript").actions.removeUnused({ sync = true })
		require("typescript").actions.fixAll({ sync = true })

		vim.lsp.buf.format()
	end,
	group = auGroup,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	command = "silent! EslintFixAll",
	group = auGroup,
})

vim.api.nvim_create_autocmd("FileType", {
	command = 'inoreabbrev wiplog console.log("WIPLOG",)<left>',
	desc = "WIPLOG for js",
	group = auGroup,
})
