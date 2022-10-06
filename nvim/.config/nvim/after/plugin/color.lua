--------------------------------------------------------------------------
-- Colors
--------------------------------------------------------------------------
vim.cmd("colorscheme base16-decaf")

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
local base16_theme_fname = vim.fn.expand(vim.env.HOME .. "/.base16_theme")

-- this function is the only way we should be setting our colorscheme
M.set_colorscheme = function(name)
	local HOME = vim.env.HOME
	local go_path = vim.fn.system({ "go", "env", "GOPATH" }):gsub("\n", "")
	local cmd = string.format("%s/bin/base16-universal-manager", go_path)
	local config = string.format("--config=%s/.config/base16-universal-manager/config.yaml", HOME)
	local scheme = string.format("--scheme=%s", name:match("-([%w-]+)"))

	-- set global base16 theme
	vim.fn.system({ cmd, config, scheme })

	-- tell all nvims to reload updated base16 theme
	for socket, kind in vim.fs.dir("/tmp") do
		if kind == "socket" and socket:find("nvimsocket") then
			local server = string.format("/tmp/%s", socket)
			local remote_send = ":colo base16<cr>"

			vim.fn.system({ "nvim", "--server", server, "--remote-send", remote_send })
		end
	end

	-- TODO: tell tmux to reload its base16 theme
	-- tell tmux to reload its base16 theme
	-- if vim.env.TMUX then
	-- 	vim.fn.system({
	-- 		"tmux",
	-- 		"source-file",
	-- 		string.format("%s/.tmux/plugins/base16-tmux/colors/%s.conf", HOME, name),
	-- 	})
	-- end
end

M.select_colorscheme = function()
	coroutine.wrap(function()
		local current_colorscheme = vim.g.colors_name or "default"
		local colors = vim.list_extend({}, vim.fn.getcompletion("base16", "color"))

		local preview = helpers.choices_to_shell_cmd_previewer(function(items)
			vim.cmd("colo " .. items[1])
		end, nil, false)
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
			vim.cmd("colo " .. current_colorscheme)
		end
	end)()
end

return M
