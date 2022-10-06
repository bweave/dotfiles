--------------------------------------------------------------------------
-- LSP
--------------------------------------------------------------------------

local lsp_status = require("lsp-status")
lsp_status.register_progress()
lsp_status.config({
	diagnostics = false, -- using the built-in to lualine
	select_symbol = function(cursor_pos, symbol) -- sumneko_lua offers more capabilities for ranges
		if symbol.valueRange then
			local value_range = {
				["start"] = {
					character = 0,
					line = vim.fn.byte2line(symbol.valueRange[1]),
				},
				["end"] = {
					character = 0,
					line = vim.fn.byte2line(symbol.valueRange[2]),
				},
			}

			return require("lsp-status.util").in_range(cursor_pos, value_range)
		end
	end,
})

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities = vim.tbl_extend("keep", capabilities, lsp_status.capabilities)

local on_attach = function(client, bufnr)
	local opts = { buffer = 0, silent = true }

	-- TODO: can I setup which-key here instead of these mappings?
	-- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
	-- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
	-- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
	-- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
	-- vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
	-- vim.keymap.set('n', 'gS', vim.lsp.buf.signature_help, opts)
	-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
	-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
	-- vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
	-- vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
	-- vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
	-- vim.keymap.set('n', '<leader>de', vim.diagnostic.open_float, opts)
	-- vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, opts)
	-- vim.keymap.set('n', '<leader>f', vim.lsp.buf.formatting, opts)

	if client.name == "tsserver" then
		client.server_capabilities.document_formatting = false
		client.server_capabilities.document_range_formatting = false
	end

	lsp_status.on_attach(client)
end

-- configuration toggles
-- require('toggle_lsp_diagnostics').init({ start_on = true, virtual_text = false, underline = false })

-- global diagnostic configuration
vim.diagnostic.config({
	virtual_text = false,
	underline = false,
	signs = { priority = 10 },
	float = {
		source = "if_many",
	},
})

-- automatic lsp server installs
require("mason").setup() -- does more but the lspconfig extension is all we use it for
require("mason-lspconfig").setup({ automatic_installation = { exclude = { "solargraph" } } })
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

local installed_via_bundler = require("utils").installed_via_bundler
-- ruby / syntax_tree
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
				logLevel = "debug",
			},
		},
		capabilities = capabilities,
		on_attach = on_attach,
	})
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

-- javascript / typescript
require("lspconfig").tsserver.setup({ capabilities = capabilities, on_attach = on_attach })

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

-- lua
require("lspconfig").sumneko_lua.setup({
	settings = {
		Lua = {
			diagnostics = { globals = { "vim", "hs", "packer_plugins" } },
			workspace = { library = vim.api.nvim_get_runtime_file("", true) },
			format = { enable = false },
			telemetry = { enable = false },
		},
	},
	capabilities = capabilities,
	on_attach = on_attach,
})

-- bash scripting
require("lspconfig").bashls.setup({ capabilities = capabilities, on_attach = on_attach })

-- yaml
require("lspconfig").yamlls.setup({ capabilities = capabilities, on_attach = on_attach })

-- json
require("lspconfig").jsonls.setup({ capabilities = capabilities, on_attach = on_attach })

-- html
require("lspconfig").html.setup({ capabilities = capabilities, on_attach = on_attach })

-- css
require("lspconfig").cssls.setup({ capabilities = capabilities, on_attach = on_attach })

-- golang
require("lspconfig").gopls.setup({ capabilities = capabilities, on_attach = on_attach })

----
-- diagnostics
----
function PrintDiagnostics(opts, bufnr, line_nr, client_id)
	bufnr = bufnr or 0
	line_nr = line_nr or (vim.api.nvim_win_get_cursor(0)[1] - 1)
	opts = opts or { ["lnum"] = line_nr }

	local line_diagnostics = vim.diagnostic.get(bufnr, opts)
	if vim.tbl_isempty(line_diagnostics) then
		return
	end

	local diagnostic_message = ""
	for i, diagnostic in ipairs(line_diagnostics) do
		diagnostic_message = diagnostic_message .. string.format("%d: %s", i, diagnostic.message or "")
		print(diagnostic_message)
		if i ~= #line_diagnostics then
			diagnostic_message = diagnostic_message .. "\n"
		end
	end
	-- vim.api.nvim_echo({{diagnostic_message, "Normal"}}, false, {})
end

vim.cmd([[ autocmd! CursorHold * lua PrintDiagnostics() ]])

----
-- formatting
----
local BWFormatting = vim.api.nvim_create_augroup("BWFormatting", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.lua",
	callback = function()
		vim.lsp.buf.format()
	end,
	group = BWFormatting,
})
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.rb",
	callback = function()
		vim.lsp.buf.format()
	end,
	group = BWFormatting,
})
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.go",
	callback = function()
		vim.lsp.buf.format()
	end,
	group = BWFormatting,
})
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.tsx", "*.ts", "*.jsx", "*.js" },
	command = "silent! EslintFixAll",
	group = BWFormatting,
})
