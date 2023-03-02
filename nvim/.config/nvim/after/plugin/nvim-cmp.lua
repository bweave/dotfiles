--
-- nvim-cmp
-- https://github.com/hrsh7th/nvim-cmp
--

local cmp = require("cmp")
local has_luasnip, luasnip = pcall(require, "luasnip")
local has_words_before = function()
	-- unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local key_mappings = {
	["<S-Tab>"] = cmp.mapping(function(fallback)
		if cmp.visible() then
			cmp.select_prev_item()
		elseif has_luasnip and luasnip.choice_active() then
			luasnip.change_choice(-1)
		elseif has_luasnip and luasnip.jumpable(-1) then
			luasnip.jump(-1)
		else
			fallback()
		end
	end, { "i", "c" }),

	["<Tab>"] = cmp.mapping(function(fallback)
		if cmp.visible() then
			cmp.select_next_item()
		elseif has_luasnip and luasnip.choice_active() then
			luasnip.change_choice(1)
		elseif has_luasnip and luasnip.expand_or_jumpable() then
			luasnip.expand_or_jump()
		elseif has_words_before() then
			cmp.complete()
		else
			fallback()
		end
	end, { "i", "c" }),

	["<C-u>"] = cmp.mapping(function(fallback)
		if cmp.visible() then
			cmp.scroll_docs(-4)
		elseif has_luasnip and luasnip.choice_active() then
			require("luasnip.extras.select_choice")()
		else
			fallback()
		end
	end, { "i", "s" }),

	["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
	["<C-y>"] = cmp.mapping(cmp.mapping.confirm(), { "i", "c" }),
	["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
	["<C-e>"] = cmp.mapping(cmp.mapping.abort(), { "i", "c" }),
}

cmp.setup({
	snippet = {
		expand = function(args)
			if has_luasnip then
				luasnip.lsp_expand(args.body)
			end
		end,
	},
	window = {
		completion = cmp.config.window.bordered({ border = "single" }),
		documentation = cmp.config.window.bordered({ border = "single" }),
	},
	enabled = function()
		return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
	end,
	mapping = key_mappings,
	sources = {
		{ name = "luasnip" },
		-- { name = "friendly-snippets" },
		{ name = "nvim_lsp" },
		{ name = "nvim_lsp_signature_help" },
		{ name = "spell" },
		{ name = "buffer" },
		{ name = "treesitter" },
		{ name = "gh_mentions" },
		{ name = "gh_coauthors" },
	},
	completion = { completeopt = "menu,menuone,noinsert" },
})

cmp.setup.cmdline("/", {
	mapping = key_mappings,
	sources = {
		{ name = "buffer" },
	},
})

cmp.setup.cmdline(":", {
	mapping = key_mappings,
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})
