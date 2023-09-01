--
-- after/ftplugin/ruby.lua
--

local g = vim.g
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local auGroup = augroup("BwRubyAutocmds", {})
local installed_via_bundler = require("bweave.utils").installed_via_bundler

g.ruby_indent_hanging_elements = 0

if installed_via_bundler("rubocop") or installed_via_bundler("syntax_tree") then
	autocmd("BufWritePre", {
		callback = function()
			vim.lsp.buf.format()
		end,
		group = auGroup,
		pattern = "*.rb",
	})
end
