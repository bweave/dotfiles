--
-- fzf-lua
--

local status, fzf_lua = pcall(require, "fzf-lua")
if not status then
	return
end

fzf_lua.setup({
	winopts = {
		height = 0.40, -- window height
		width = 1, -- window width
		row = 1, -- window row position (0=top, 1=bottom)
		col = 0, -- window col position (0=left, 1=right)
	},
	fzf_opts = {
		["--info"] = "hidden",
		["--layout"] = false,
	},
})
