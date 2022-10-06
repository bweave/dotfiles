--
-- bweave.utils
--

local M = {}

function M.installed_via_bundler(gemname)
	local gemfile = vim.fn.findfile("Gemfile.lock")

	if vim.fn.filereadable(gemfile) == 0 then
		return
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
