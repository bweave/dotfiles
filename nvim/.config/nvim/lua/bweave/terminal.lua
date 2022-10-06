--
-- bweave.terminal
--

-- Open a terminal pane on the right using :Term
vim.cmd([[command! Term :botright vsplit term://$SHELL]])

-- Terminal visual tweaks:
-- enter insert mode when switching to terminal
-- close terminal buffer on process exit
local BWTerminalTweaks = vim.api.nvim_create_augroup("BWTerminalTweaks", { clear = true })

vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "*",
	command = "setlocal listchars= nonumber norelativenumber nocursorline",
	desc = "Disable line numbers and cursorline",
	group = BWTerminalTweaks,
})

vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "*",
	command = "startinsert",
	desc = "Start terminal in Insert mode",
	group = BWTerminalTweaks,
})

vim.api.nvim_create_autocmd("BufLeave", {
	pattern = "term://*",
	command = "stopinsert",
	desc = "Stop Insert mode when leaving a terminal",
	group = BWTerminalTweaks,
})
