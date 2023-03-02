--
-- lua/bweave/utils.lua
--

local M = {}

local function keymap(mode, keys, func, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end

	vim.keymap.set(mode, keys, func, options)
end

function M.nmap(keys, func, desc)
	keymap("n", keys, func, { desc = desc })
end

function M.vmap(keys, func, desc)
	keymap("v", keys, func, { desc = desc })
end

function M.tmap(keys, func, desc)
	keymap("t", keys, func, { desc = desc })
end

local function buf_keymap(mode, keys, func, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end

	vim.api.nvim_buf_set_keymap(0, mode, keys, func, options)
end

function M.nbufmap(keys, func, desc)
	buf_keymap("n", keys, func, { desc = desc })
end

function M.blank(s)
	return (
		s == nil
		or s == vim.NIL
		or (type(s) == "string" and string.match(s, "%S") == nil)
		or (type(s) == "table" and next(s) == nil)
	)
end

function M.present(s)
	return not M.blank(s)
end

function M.error(msg)
	vim.notify(msg, vim.log.levels.ERROR, { title = "GH CLI" })
end

-- switch statement
-- usage:
-- local a = 2
-- switch(a, {
--   [1] = function()  -- for case 1
--     print "Case 1."
--   end,
--   [2] = function()  -- for case 2
--     print "Case 2."
--   end,
--   [3] = function()  -- for case 3
--     print "Case 3."
--   end
-- })
function M.switch(param, case_table)
	local case = case_table[param]
	if case then
		return type(case) == "function" and case() or case
	end
	local def = case_table["default"]
	return def and def() or nil
end

function M.installed_via_bundler(gemname)
	local gemfile = vim.fn.findfile("Gemfile.lock")
	if vim.fn.filereadable(gemfile) == 0 then
		return false
	end

	local found = false
	for line in io.lines(gemfile) do
		if string.find(line, gemname) then
			found = true
			break
		end
	end

	return found
end

return M
