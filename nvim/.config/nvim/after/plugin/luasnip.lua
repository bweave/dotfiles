--
-- after/plugin/luasnip.lua
--

local ok, ls = pcall(require, "luasnip")
if not ok then
	return
end

local types = require("luasnip.util.types")

ls.config.setup({
	history = true,
	updateevents = "TextChanged,TextChangedI",
	ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = { { "←  Choice", "Comment" } },
			},
		},
		-- [types.insertNode] = {
		--   active = {
		--     virt_text = { { '← ...', 'Todo' } },
		--   },
		-- },
	},
	-- store_selection_keys = '<Tab>',
	-- enable_autosnippets = true,
})

vim.keymap.set({ "i", "s" }, "<C-k>", function()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-j>", function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end, { silent = true })

-- reload snippets
vim.keymap.set(
	"n",
	"<leader><leader>s",
	"<cmd>source " .. os.getenv("HOME") .. "/.config/nvim/after/plugin/luasnip.lua<CR>",
	{ noremap = true, silent = true }
)

require("luasnip.loaders.from_lua").load({ paths = os.getenv("HOME") .. "/.config/nvim/lua/bweave/snippets" })

-- ls.filetype_extend("ruby", { "rails" })
-- ls.filetype_extend("javascript", { "javascriptreact" })
-- require("luasnip.loaders.from_vscode").lazy_load()
