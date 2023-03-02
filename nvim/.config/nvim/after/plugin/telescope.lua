--
-- after/plugin/telescope.lua
--

local telescope_ok, telescope = pcall(require, "telescope")
if not telescope_ok then
	print("!! telescope couldn't be required !!")
	return
end

local actions = require("telescope.actions")
local action_layout = require("telescope.actions.layout")

telescope.setup({
	defaults = {
		file_ignore_patterns = { ".git/", "node_modules", "pack/" },
		mappings = {
			n = {
				["<M-p>"] = action_layout.toggle_preview,
			},
			i = {
				["<esc>"] = actions.close,
				["<M-p>"] = action_layout.toggle_preview,
			},
		},
	},
})
telescope.load_extension("fzf")
telescope.load_extension("ui-select")
