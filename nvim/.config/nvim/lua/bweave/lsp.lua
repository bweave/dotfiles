--
-- lua/bweave/lsp/lua
--

local utils = require("bweave.utils")
local nmap = utils.nmap
local installed_via_bundler = utils.installed_via_bundler
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

local on_attach = function(client)
	nmap("gd", vim.lsp.buf.definition, "LSP Go to Definition")
	nmap("<leader>lgd", vim.lsp.buf.definition, "LSP Go to Definition")
	nmap("<leader>lgD", vim.lsp.buf.declaration, "LSP Go to Declaration")
	nmap("<leader>li", vim.lsp.buf.implementation, "LSP Implementation")
	nmap("<leader>lr", vim.lsp.buf.references, "LSP References")
	nmap("<leader>ls", vim.lsp.buf.signature_help, "LSP Signature Help")
	nmap("]d", vim.diagnostic.goto_next, "LSP Next Diagnostic")
	nmap("[d", vim.diagnostic.goto_prev, "LSP Previous Diagnostic")
	nmap("<F2>", vim.lsp.buf.rename, "LSP Rename")
	nmap("<leader>lD", vim.lsp.buf.type_definition, "LSP Type Definition")
	nmap("<leader>ldo", vim.diagnostic.open_float, "LSP Show Info")
	nmap("<leader>lds", vim.diagnostic.setloclist, "LSP Set Loclist")
	nmap("<leader>lf", vim.lsp.buf.format, "LSP Format")

	if client.name == "rust_analyzer" then
		nmap("<leader>la", require("rust-tools").code_action_group.code_action_group(), "LSP Code Action")
		nmap("<leader>lk", require("rust-tools").hover_actions.hover_actions()("LSP Hover"))
	else
		nmap("<leader>la", vim.lsp.buf.code_action, "LSP Code Action")
		nmap("<leader>lk", vim.lsp.buf.hover, "LSP Hover")
	end

	if client.name == "tsserver" then
		client.server_capabilities.document_formatting = false
		client.server_capabilities.document_range_formatting = false
	end
end

-- virtual text config
vim.diagnostic.config({
	virtual_text = {
		-- source = "always",  -- Or "if_many"
		prefix = "●", -- Could be '■', '▎', 'x'
	},
	severity_sort = true,
	float = {
		source = "always", -- Or "if_many"
	},
})
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "single",
})
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = "single",
})
local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- null-ls for tooling that's non-lsp-compliant like Rubocop
local null_ls = require("null-ls")
local sources = {
	null_ls.builtins.formatting.stylua, -- lua formatting
	null_ls.builtins.code_actions.shellcheck, -- bashls uses this
}

-- ruby / rubocop via null-ls
if not installed_via_bundler("solargraph") and installed_via_bundler("rubocop") then
	local rubocop_source = null_ls.builtins.diagnostics.rubocop.with({
		command = "bundle",
		args = vim.list_extend({ "exec", "rubocop" }, null_ls.builtins.diagnostics.rubocop._opts.args),
	})

	vim.list_extend(sources, { rubocop_source })
end

null_ls.setup({ sources = sources, on_attach = on_attach })

-- lua
require("neodev").setup({
	library = {
		plugins = { "nvim-treesitter", "plenary.nvim", "gitsigns.nvim" },
	},
})

require("lspconfig").sumneko_lua.setup({
	settings = {
		Lua = {
			diagnostics = { globals = { "vim", "hs", "packer_plugins" } },
			format = { enable = false },
			telemetry = { enable = false },
		},
	},
	capabilities = capabilities,
	on_attach = on_attach,
})

-- syntax_tree
if installed_via_bundler("syntax_tree") then
	require("lspconfig").syntax_tree.setup({
		cmd = { "bundle", "exec", "stree", "lsp" },
		capabilities = capabilities,
		on_attach = on_attach,
	})
end

-- ruby / solargraph
if installed_via_bundler("solargraph") then
	require("lspconfig").solargraph.setup({
		cmd = { "bundle", "exec", "solargraph", "stdio" },
		init_options = {
			formatting = false,
		},
		settings = {
			solargraph = {
				diagnostics = true,
			},
		},
		capabilities = capabilities,
		on_attach = on_attach,
	})
end

-- javascript / typescript
-- this plugin calls lspconfig and sets up tsserver
require("typescript").setup({
	disable_commands = false, -- :Typescript* commands
	debug = false,
	server = {
		capabilities = capabilities,
		init_options = {
			disableAutomaticTypingAcquisition = true,
		},
		on_attach = on_attach,
	},
})

-- eslint
require("lspconfig").eslint.setup({
	settings = {
		validate = "on",
		codeAction = {
			disableRuleComment = {
				location = "separateLine",
			},
			showDocumentation = {
				enable = true,
			},
		},
	},
	capabilities = capabilities,
	on_attach = on_attach,
})

-- golang
require("lspconfig").gopls.setup({ capabilities = capabilities, on_attach = on_attach })

-- bash scripting
require("lspconfig").bashls.setup({ capabilities = capabilities, on_attach = on_attach })

-- yaml
require("lspconfig").yamlls.setup({ capabilities = capabilities, on_attach = on_attach })

-- json
require("lspconfig").jsonls.setup({
	init_options = {
		provideFormatter = true,
	},
	capabilities = capabilities,
	on_attach = on_attach,
})

-- html
require("lspconfig").html.setup({ capabilities = capabilities, on_attach = on_attach })

-- css
require("lspconfig").cssls.setup({ capabilities = capabilities, on_attach = on_attach })
