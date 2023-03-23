--
-- after/plugin/lualine.lua
--

local lualine_status, lualine = pcall(require, "lualine")
if not lualine_status then
	print("!! lualine couldn't be required !!")
end
lualine.setup({
	options = {
		disabled_filetypes = { "NvimTree" },
		globalstatus = true,
	},
	theme = "auto",
	sections = {
		lualine_a = {
			{
				"mode",
				fmt = function(mode)
					return vim.go.paste == true and mode .. " | PASTE" or mode
				end,
			},
		},
		lualine_b = { "branch", "diff" },
		lualine_c = {},
		lualine_x = { "filetype", "require('lsp-status').status()" },
		lualine_y = { "diagnostics" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {
		lualine_a = { "buffers" },
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = { "tabs" },
	},
	winbar = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {},
		-- lualine_x = { winbar_file_path },
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	inactive_winbar = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {},
		-- lualine_x = { winbar_file_path },
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	extensions = { "nvim-tree", "fzf", "quickfix", "fugitive" },
})
