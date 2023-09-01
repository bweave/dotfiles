--
-- lua/bweave/autocommands.lua
--

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local bweaveGroup = augroup("BweaveGroup", {})

-- autocmd("CursorHold", {
-- 	pattern = "*",
-- 	command = "echon ''",
-- 	desc = "Automatically clear cmd line",
-- 	group = bweaveGroup,
-- })

autocmd("BufWritePre", {
	pattern = "*",
	command = "%s/\\s\\+$//e",
	desc = "Trim trailing whitespace on save",
	group = bweaveGroup,
})
autocmd("VimResized", {
	pattern = "*",
	command = "wincmd =",
	desc = "Automatically resize splits when resizing the window",
	group = bweaveGroup,
})
autocmd({ "InsertLeave", "WinEnter" }, {
	command = "set cursorline",
	desc = "Show cursor line only in active window",
	group = bweaveGroup,
})
autocmd({ "InsertEnter", "WinLeave" }, {
	command = "set nocursorline",
	desc = "Show cursor line only in active window",
	group = bweaveGroup,
})
autocmd("FileType", {
	command = "setlocal formatoptions-=o",
	desc = "New lines with 'o' or 'O' from commented lines don't continue commenting",
	group = bweaveGroup,
})
autocmd("TermOpen", {
	pattern = "*",
	command = "setlocal listchars= nonumber norelativenumber nocursorline",
	desc = "Disable line numbers and cursorline",
	group = bweaveGroup,
})
autocmd("TermOpen", {
	pattern = "*",
	command = "startinsert",
	desc = "Start terminal in Insert mode",
	group = bweaveGroup,
})
autocmd("BufLeave", {
	pattern = "term://*",
	command = "stopinsert",
	desc = "Stop Insert mode when leaving a terminal",
	group = bweaveGroup,
})
autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		-- TODO: not sure what's up with this erroring
    -- require('lualine').refresh()
	end,
	desc = "Reload lualine",
	group = bweaveGroup,
})
