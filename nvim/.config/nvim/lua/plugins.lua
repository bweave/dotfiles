--
-- lua/plugins.lua
--

-- Plugins via Packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	is_bootstrap = true
	vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
	vim.cmd([[packadd packer.nvim]])
end

require("packer").startup(function(use)
	use({ "wbthomason/packer.nvim" })
	use({ "Shatur/neovim-session-manager" })
	use({ "RRethy/nvim-base16" })
	use({ "rmehri01/onenord.nvim" })
	use({ "editorconfig/editorconfig-vim" })
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		requires = {
			"RRethy/nvim-treesitter-endwise",
			"windwp/nvim-ts-autotag",
			"nvim-treesitter/playground",
			"windwp/nvim-autopairs",
			"andymass/vim-matchup",
		},
	})
	use({ "nvim-lua/plenary.nvim" })
	use({ "kyazdani42/nvim-web-devicons" })
	use({ "kyazdani42/nvim-tree.lua" })
	use({ "nvim-lualine/lualine.nvim" })
	use({ "lewis6991/gitsigns.nvim" })
	use({ "pangloss/vim-javascript" })
	use({ "maxmellon/vim-jsx-pretty" })
	use({ "mattn/emmet-vim" })
	use({
		"vim-ruby/vim-ruby",
		ft = "ruby",
		requires = {
			{ "tpope/vim-rails", after = "vim-ruby" },
		},
	})
	use({ "tpope/vim-commentary" })
	use({
		"tpope/vim-fugitive",
		requires = {
			{ "tpope/vim-rhubarb", after = "vim-fugitive" },
			{ "tpope/vim-dispatch", after = "vim-rhubarb" },
		},
	})
	use({
		"tpope/vim-surround",
		requires = {
			{ "tpope/vim-repeat", after = "vim-surround" },
		},
	})
	use({ "AndrewRadev/splitjoin.vim" })
	use({ "kassio/neoterm" })
	use({
		"vim-test/vim-test",
		requires = {
			{ "tpope/vim-projectionist" },
		},
	})
	use({
		"ibhagwan/fzf-lua",
		-- optional for icon support
		requires = { "nvim-tree/nvim-web-devicons" },
	})
	use({ "williamboman/mason.nvim" })
	use({ "WhoIsSethDaniel/mason-tool-installer.nvim" })
	use({
		"neovim/nvim-lspconfig",
		requires = {
			"folke/lua-dev.nvim",
			"jose-elias-alvarez/typescript.nvim",
			"simrat39/rust-tools.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
	})
	use({ "j-hui/fidget.nvim" })
	use({ "jose-elias-alvarez/null-ls.nvim" })
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"ray-x/cmp-treesitter",
		},
	})
	use({
		"L3MON4D3/LuaSnip",
		requires = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
	})
	use({ "folke/which-key.nvim" })

	if is_bootstrap then
		require("packer").sync()
	end
end)

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
	print("==================================")
	print("    Plugins are being installed")
	print("    Wait until Packer completes,")
	print("       then restart nvim")
	print("==================================")
	return
end

-- Automatically source and re-compile packer whenever you save this init.lua
vim.cmd([[
  augroup user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])
