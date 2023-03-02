--
-- after/ftplugin/ruby.lua
--

local cmd = vim.cmd
local g = vim.g
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local auGroup = augroup("BwRubyAutocmds", {})
local installed_via_bundler = require("bweave.utils").installed_via_bundler

g.ruby_indent_hanging_elements = 0

cmd(
	'iabbrev <buffer> wiplog Rails.logger.debug "=" * 80<CR> Rails.logger.debug "#{self.class.name}##{__method__}"<CR> Rails.logger.debug <CR> Rails.logger.debug "=" * 80<Up>'
)

if installed_via_bundler("rubocop") or installed_via_bundler("syntax_tree") then
	autocmd("BufWritePost", {
		callback = function()
			vim.lsp.buf.format()
		end,
		group = auGroup,
		pattern = "*.rb",
	})
end
