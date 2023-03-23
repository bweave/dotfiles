--
-- after/plugin/nvim-tree.lua
--

local nvim_tree_ok, nvim_tree = pcall(require, "nvim-tree")

if not nvim_tree_ok then
	print("!! nvim-tree couldn't be required !!")
	return
end

nvim_tree.setup({
	renderer = {
		root_folder_modifier = ":t",
	},
	view = {
		hide_root_folder = false,
		mappings = {
			list = {
				{ key = "?", action = "toggle_help" },
			},
		},
	},
})
