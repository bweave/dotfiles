-- Plugins
local cmd = vim.cmd
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

-- Get Packer if it's not present
local packer_bootstrap
if fn.isdirectory(install_path) == 0 then
	print("downloading packer.nvim")
	packer_bootstrap = fn.system({
		"git",
		"clone",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	vim.cmd([[packadd packer.nvim]])
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Install plugins
packer.startup({
	function(use)
		-- Add you plugins here:
		use("wbthomason/packer.nvim") -- packer can manage itself

		use({ "kyazdani42/nvim-web-devicons" }) -- sweet icons
		use({
			"kyazdani42/nvim-tree.lua",
			cmd = "NvimTreeToggle",
			config = function()
				require("lazy.nvim-tree").setup()
			end,
		})
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
		use({ "RRethy/nvim-base16" })
		use({ "nvim-lualine/lualine.nvim" })
		use({
			"lewis6991/gitsigns.nvim",
			requires = { "nvim-lua/plenary.nvim" },
			config = function()
				local status, gitsigns = pcall(require, "gitsigns")
				if not status then
					return
				end

				gitsigns.setup()
			end,
		})
		use({
			"editorconfig/editorconfig-vim",
			config = function()
				vim.g.EditorConfig_exclude_patterns = { "fugitive://.*" }
			end,
		})
		use({ "goolord/alpha-nvim", requires = { "kyazdani42/nvim-web-devicons" } }) -- Dashboard (start screen)
		use({
			"Shatur/neovim-session-manager",
			config = function()
				local status, session_manager = pcall(require, "session_manager")
				if not status then
					return
				end

				session_manager.setup({
					autoload_mode = require("session_manager.config").AutoloadMode.CurrentDir,
				})
			end,
		})
		use({ "junegunn/fzf", dir = "~/.fzf", run = "./install --all" })
		use({
			"ibhagwan/fzf-lua",
			requires = { "kyazdani42/nvim-web-devicons" },
		})
		use({ "vijaymarupudi/nvim-fzf" })
		use({
			"vim-ruby/vim-ruby",
			ft = "ruby",
			requires = {
				{ "tpope/vim-rails", after = "vim-ruby" },
			},
		})
		use({
			"tpope/vim-fugitive",
			requires = {
				{ "tpope/vim-rhubarb", after = "vim-fugitive" },
				{ "tpope/vim-dispatch", after = "vim-rhubarb" },
			},
		})
		use({ "tpope/vim-commentary" })
		use({ "tpope/vim-repeat" })
		use({ "tpope/vim-surround" })
		use({ "vim-test/vim-test" })
		use({ "wincent/vim-clipper" })
		use({ "pangloss/vim-javascript" })
		use({ "rktjmp/lush.nvim" })
		use({
			"maxmellon/vim-jsx-pretty",
			config = function()
				vim.g.vim_jsx_pretty_colorful_config = 1
			end,
		})
		use({
			"mattn/emmet-vim",
			config = function()
				vim.g.user_emmet_leader_key = ","
			end,
		})
		use({
			"AndrewRadev/splitjoin.vim",
			config = function()
				vim.g.splitjoin_split_mapping = ""
				vim.g.splitjoin_join_mapping = ""
				vim.g.splitjoin_trailing_comma = 1
				vim.g.splitjoin_ruby_hanging_args = 0
			end,
		})
		use({
			"kassio/neoterm",
			config = function()
				vim.g.neoterm_default_mod = "vert botright 80"
				vim.g.neoterm_repl_ruby = "pry"
				vim.g.neoterm_autoinsert = "1"
			end,
		})
		use({ "folke/which-key.nvim" })

		-- LSP
		use("williamboman/mason.nvim")
		use("WhoIsSethDaniel/mason-tool-installer.nvim")
		use({
			"neovim/nvim-lspconfig",
			requires = {
				"jose-elias-alvarez/typescript.nvim",
				"williamboman/mason-lspconfig.nvim",
				"WhoIsSethDaniel/toggle-lsp-diagnostics.nvim",
			},
		})
		use({ "jose-elias-alvarez/null-ls.nvim" })

		-- Diagnostics
		use({
			"folke/trouble.nvim",
			requires = "kyazdani42/nvim-web-devicons",
			config = function()
				local status, trouble = pcall(require, "trouble")
				if not status then
					return
				end

				trouble.setup({
					auto_preview = false,
				})
			end,
		})

		-- Completion
		use({
			"hrsh7th/nvim-cmp",
			requires = {
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-cmdline",
				"hrsh7th/cmp-nvim-lsp-signature-help",
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-nvim-lua",
				"petertriho/cmp-git",
				"hrsh7th/cmp-path",
				"f3fora/cmp-spell",
				"onsails/lspkind.nvim",
			},
		})
		use("nvim-lua/lsp-status.nvim")
		use({
			"L3MON4D3/LuaSnip", -- Snippets with completion
			requires = {
				"saadparwaiz1/cmp_luasnip",
				"rafamadriz/friendly-snippets",
			},
		})
		-- crystal lang
		use({ "jlcrochet/vim-crystal" })

		-- Automatically set up your configuration after cloning packer.nvim
		-- Put this at the end after all plugins
		if packer_bootstrap then
			require("packer").sync()
		end
	end,
	config = {
		display = {
			open_fn = require("packer.util").float,
		},
	},
})

-- Reloads neovim and plugins whenever you save this file
cmd([[
  augroup user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])
