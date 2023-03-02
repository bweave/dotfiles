--
-- after/plugin/treesitter.lua
--

local treesitter_ok, treesitter_configs = pcall(require, "nvim-treesitter.configs")
if not treesitter_ok then
	print("!! nvim-treesitter couldn't be required !!")
	return
end

treesitter_configs.setup({
	ensure_installed = {
		"bash",
		"comment",
		"css",
		"dockerfile",
		"go",
		"html",
		"javascript",
		"jsdoc",
		"json",
		"lua",
		"markdown",
		"markdown_inline",
		"python",
		"query",
		"regex",
		"ruby",
		"rust",
		"scheme",
		"scss",
		"sql",
		"toml",
		"tsx",
		"typescript",
		"vim",
		"yaml",
	},
	autotag = { enable = true }, -- nvim-ts-autotag
	endwise = { enable = true }, -- nvim-treesitter-endwise
	highlight = { enable = true, additional_vim_regex_highlighting = false },
	incremental_selection = {
		enable = true,
		-- keymaps = {
		-- 	init_selection = "<c-space>",
		-- 	node_incremental = "<c-space>",
		-- 	scope_incremental = "<c-s>",
		-- 	node_decremental = "<c-backspace>",
		-- },
	},
	indent = { enable = false },
	matchup = { enable = true }, -- vim-matchup
	playground = { enable = true }, -- nvim-treesitter/playground
	query_linter = { enable = true }, -- nvim-treesitter/playground
	-- textobjects = {
	-- 	select = {
	-- 		enable = true,
	-- 		lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
	-- 		keymaps = {
	-- 			-- You can use the capture groups defined in textobjects.scm
	-- 			["aa"] = "@parameter.outer",
	-- 			["ia"] = "@parameter.inner",
	-- 			["af"] = "@function.outer",
	-- 			["if"] = "@function.inner",
	-- 			["ac"] = "@class.outer",
	-- 			["ic"] = "@class.inner",
	-- 		},
	-- 	},
	-- 	move = {
	-- 		enable = true,
	-- 		set_jumps = true, -- whether to set jumps in the jumplist
	-- 		goto_next_start = {
	-- 			["]m"] = "@function.outer",
	-- 			["]]"] = "@class.outer",
	-- 		},
	-- 		goto_next_end = {
	-- 			["]M"] = "@function.outer",
	-- 			["]["] = "@class.outer",
	-- 		},
	-- 		goto_previous_start = {
	-- 			["[m"] = "@function.outer",
	-- 			["[["] = "@class.outer",
	-- 		},
	-- 		goto_previous_end = {
	-- 			["[M"] = "@function.outer",
	-- 			["[]"] = "@class.outer",
	-- 		},
	-- 	},
	-- 	swap = {
	-- 		enable = true,
	-- 		swap_next = {
	-- 			["<leader>a"] = "@parameter.inner",
	-- 		},
	-- 		swap_previous = {
	-- 			["<leader>A"] = "@parameter.inner",
	-- 		},
	-- 	},
	-- },
})

-- nvim-autopairs - not a treesitter module but uses it
local autopairs_ok, autopairs = pcall(require, "nvim-autopairs")
if not autopairs_ok then
	print("!! nvim-autopairs couldn't be required !!")
	return
end

autopairs.setup({ check_ts = true, map_cr = true })
