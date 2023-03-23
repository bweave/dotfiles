--
--
--

local M = {}

function M.winbar_line()
	local winbar_filetype_exclude = {
		"NvimTree",
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
	local modified_icon = vim.api.nvim_eval_statusline("%M", {}).str == "+" and "" or ""

	local align_right = "%="
	local file = "%#WinBarPath# " .. file_path .. "%*"
	local modified = "%#WinBarModified#" .. modified_icon .. "%*"
	return align_right .. modified .. file
end

function M.setup()
	local modified_color = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("diffRemoved")), "fg")
	local file_path_color = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Normal")), "fg")

	vim.api.nvim_set_hl(0, "WinBarPath", { fg = file_path_color, italic = true })
	vim.api.nvim_set_hl(0, "WinBarModified", { fg = modified_color })

	vim.opt.winbar = "%{%v:lua.require'bweave.winbar'.winbar_line()%}"
end

return M
