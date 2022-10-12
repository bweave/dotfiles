--------------------------------------------------------------------------
-- color
--------------------------------------------------------------------------
local M = {}

local status, fzf = pcall(require, "fzf")
if not status then
	return
end
local helpers = require("fzf.helpers")

function file_exists(name)
	local f = io.open(name, "r")
	if f ~= nil then
		io.close(f)
		return true
	else
		return false
	end
end
vim.cmd("colorscheme " .. colorscheme)

-- It would be dope if we could just rely on vim.env.BASE16_THEME,
-- but sadly, there's no good way that I know of to tell
-- all_the_iterms.py that their env var $BASE16_THEME needs to update.
-- Instead, we can read the value from ~/.base16_theme.
local colorscheme = "default"
local base16_theme_path = vim.env.HOME .. "/.base16_theme"
if file_exists(base16_theme_path) then
	for line in io.lines(base16_theme_path) do
		local theme = line:match("^export BASE16_THEME=(.+)")
		if theme ~= nil then
			colorscheme = "base16-" .. theme
		end
	end
end
vim.cmd("colorscheme " .. colorscheme)

-- IMPORTANT: this function is the canonical way to set colorscheme
M.set_colorscheme = function(name)
	local theme_function = string.gsub(name, "-", "_", 1)
	print(theme_function)
	vim.fn.system(theme_function)
end

M.select_colorscheme = function()
	coroutine.wrap(function()
		local current_background = vim.o.background
		local current_colorscheme = vim.g.colors_name or "default"
		local colors = vim.list_extend({}, vim.fn.getcompletion("base16", "color"))

		local preview = helpers.choices_to_shell_cmd_previewer(function(items)
			vim.cmd("colorscheme " .. items[1])
		end, nil)
		local cli_args = table.concat({
			"--no-multi",
			"--preview-window nohidden:right:0",
			"--preview " .. preview,
		}, " ")
		local opts = { height = 10, width = 50 }
		local result = fzf.fzf(colors, cli_args, opts)

		if result then
			M.set_colorscheme(result[1])
		else
			vim.o.background = current_background
			vim.cmd("colorscheme " .. current_colorscheme)
		end
	end)()
end

return M
