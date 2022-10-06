--------------------------------------------------------------------------
-- bweave.completion
--------------------------------------------------------------------------

local cmp = require("cmp")
local luasnip = require("luasnip")

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local key_mappings = {
	["<C-p>"] = cmp.mapping(function(fallback)
		if cmp.visible() then
			cmp.select_prev_item()
		elseif has_luasnip and luasnip.choice_active() then
			luasnip.change_choice(-1)
		else
			fallback()
		end
	end, { "i", "c" }),

	["<S-TAB>"] = cmp.mapping(function(fallback)
		if cmp.visible() then
			cmp.select_prev_item()
		elseif has_luasnip and luasnip.choice_active() then
			luasnip.change_choice(-1)
		else
			fallback()
		end
	end, { "i", "c" }),

	["<C-n>"] = cmp.mapping(function(fallback)
		if cmp.visible() then
			cmp.select_next_item()
		elseif has_luasnip and luasnip.choice_active() then
			luasnip.change_choice(1)
		else
			fallback()
		end
	end, { "i", "c" }),

	["<Tab>"] = cmp.mapping(function(fallback)
		if cmp.visible() then
			cmp.select_next_item()
		elseif has_luasnip and luasnip.choice_active() then
			luasnip.change_choice(1)
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
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			luasnip.lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	window = {
		-- completion = cmp.config.window.bordered(),
		-- documentation = cmp.config.window.bordered(),
	},
	mapping = key_mappings,
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "nvim_lsp_signature_help" },
		{ name = "nvim_lua" },
		{ name = "buffer" },
		{ name = "spell", keyword_length = 4 },
	}, {
		{ name = "buffer" },
	}),
	completion = { completeopt = "menu,menuone,noinsert" },
})

cmp.setup.cmdline("/", {
	mapping = key_mappings,

	formatting = {
		format = function(_, vim_item)
			vim_item.kind = nil
			vim_item.source = nil

			return vim_item
		end,
	},

	sources = {
		{ name = "buffer" },
	},
})

cmp.setup.cmdline(":", {
	mapping = key_mappings,

	formatting = {
		format = function(_, vim_item)
			vim_item.kind = nil

			return vim_item
		end,
	},

	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})
