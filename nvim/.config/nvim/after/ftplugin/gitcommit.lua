--
-- gitcommit filetype
--

local auGroup = vim.api.nvim_create_augroup("BWAbbreviations", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	command = "iabbrev <buffer> co Co-authored-by: SOMEONE <HANDLE@users.noreply.github.com>",
	desc = "Co-authored-by",
	group = auGroup,
})
