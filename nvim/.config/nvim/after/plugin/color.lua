--------------------------------------------------------------------------
-- color
--------------------------------------------------------------------------
local M = {}

local status, fzf = pcall(require, "fzf")
if not status then
	return
end
local helpers = require("fzf.helpers")

local function debug(msg)
	print(vim.inspect(msg))
end

-- this is our single source of truth created above
local base16_filename = vim.fn.expand(vim.env.HOME .. "/.base16_theme")

local get_colorscheme = function()
	local file = io.open(base16_filename, "r")
	local theme = "default"

	if file ~= nil then
		theme = file:read()
		file:close()
	end

	return theme
end
vim.cmd("colorscheme " .. get_colorscheme())

local set_global_base16_theme = function(theme)
	local file = io.open(base16_filename, "w")

	if file ~= nil then
		file:write(theme)
		file:close()
	end
end

local set_all_nvim_colorschemes = function(colorscheme)
	for socket, kind in vim.fs.dir("/tmp") do
		if kind == "socket" and socket:find("nvimsocket") then
			local server = string.format("/tmp/%s", socket)
			local remote_send = string.format(":colorscheme %s<cr>", colorscheme)
			vim.fn.system({ "nvim", "--server", server, "--remote-send", remote_send })
		end
	end
end

local set_all_iterm_color_presets = function(preset)
	-- TODO
end

local set_tmux_theme = function(theme)
	if vim.env.TMUX then
		vim.fn.system({
			"tmux",
			"source-file",
			string.format("%s/.tmux/plugins/base16-tmux/colors/%s.conf", vim.env.HOME, theme),
		})
	end
end

-- this function is the only way we should be setting our colorscheme
M.set_colorscheme = function(name)
	set_global_base16_theme(name)
	set_all_nvim_colorschemes(name)
	set_all_iterm_color_presets(name)
	set_tmux_theme(name)
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
