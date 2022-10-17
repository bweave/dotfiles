--
-- ruby filetype
--

vim.g.ruby_indent_hanging_elements = 0

local auGroup = vim.api.nvim_create_augroup("BwRubyAutocmds", {})

vim.api.nvim_create_autocmd("FileType", {
	command = 'inoreabbrev wiplog Rails.logger.debug "=" * 80<CR>Rails.logger.debug <CR>Rails.logger.debug "=" * 80<Up>',
	desc = "WIPLOG for ruby",
	group = auGroup,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function()
		vim.lsp.buf.format()
	end,
	group = auGroup,
})
