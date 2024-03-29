--
-- mason.nvim, mason-lspconfig.nvim, mason-tool-installer.nvim
-- https://github.com/williamboman/mason.nvim
-- https://github.com/williamboman/mason-lspconfig.nvim
-- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim

require("mason").setup()

-- automatic lsp server installs
require("mason-lspconfig").setup({
	automatic_installation = {
		exclude = { "solargraph", "ruby-lsp", "syntax_tree" },
	},
})

-- mason auto-update
require("mason-tool-installer").setup({
	ensure_installed = {
		"bash-language-server",
		"css-lsp",
		"eslint-lsp",
		"gopls",
		"html-lsp",
		"json-lsp",
		"lua-language-server",
		"selene",
		"shellcheck", -- used by bash-language-server
		"sqlls",
		"stylua",
		"typescript-language-server",
		"yaml-language-server",
	},
	auto_update = true,
	run_on_start = true,
	start_delay = 5000,
})
