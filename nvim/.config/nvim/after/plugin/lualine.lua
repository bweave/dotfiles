--
-- Lualine
--

local status, lualine = pcall(require, "lualine")
if not status then
	return
end

local winbar_file_path = function()
	local winbar_filetype_exclude = {
		"NvimTree",
		"Trouble",
		"fugitive",
		"help",
		"packer",
		"qf",
		"startuptime",
	}
	if vim.tbl_contains(winbar_filetype_exclude, vim.bo.filetype) then
		return ""
	end
	local file_path = vim.api.nvim_eval_statusline("%f", {}).str
	local modified = vim.api.nvim_eval_statusline("%M", {}).str == "+" and "[+]" or ""
	return "%=" .. "%#WinBarPath#" .. " " .. file_path .. "%*" .. "%#WinBarModified#" .. modified .. " " .. "%*"
end

lualine.setup({
	options = {
		disabled_filetypes = { "NvimTree" },
		globalstatus = true,
	},
	theme = "auto",
	sections = {
		lualine_a = { "mode" },
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
		lualine_x = { winbar_file_path },
		lualine_y = {},
		lualine_z = {},
	},
	inactive_winbar = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {},
		lualine_x = { winbar_file_path },
		lualine_y = {},
		lualine_z = {},
	},
	extensions = { "nvim-tree", "fzf", "quickfix", "fugitive" },
})
