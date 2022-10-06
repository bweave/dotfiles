--------------------------------------------------------------------------
-- lazy.nvim-tree
-- nvim_tree_highlight_opened_files, nvim_tree_git_hl, nvim_tree_respect_buf_cwd, nvim_tree_icons, nvim_tree_show_icons
--------------------------------------------------------------------------

local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
	return
end

local M = {}

M.setup = function()
	nvim_tree.setup({
		view = {
			hide_root_folder = false,
			mappings = {
				list = {
					{ key = "?", action = "toggle_help" },
				},
			},
		},
	})
end

return M
