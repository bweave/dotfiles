--
-- bweave.autocommands
--

local auGroup = vim.api.nvim_create_augroup("BWBufferCleanup", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	command = "%s/\\s\\+$//e",
	desc = "Trim trailing whitespace on save",
	group = auGroup,
})

vim.api.nvim_create_autocmd("VimResized", {
	pattern = "*",
	command = "wincmd =",
	desc = "Automatically resize splits when resizing the window",
	group = auGroup,
})
