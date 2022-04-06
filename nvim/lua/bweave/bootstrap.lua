local PKGS = {
  -- List your packages here!
  'savq/paq-nvim';

  'AndrewRadev/splitjoin.vim';
  'Glench/Vim-Jinja2-Syntax';
  'akinsho/bufferline.nvim';
  'christoomey/vim-tmux-navigator';
  "folke/which-key.nvim";
  'hoob3rt/lualine.nvim';
  'junegunn/fzf';
  'junegunn/fzf.vim';
  'junegunn/goyo.vim';
  'junegunn/vim-peekaboo';
  'kassio/neoterm';
  'kosayoda/nvim-lightbulb';
  'kyazdani42/nvim-tree.lua';
  'kyazdani42/nvim-web-devicons';
  'lewis6991/gitsigns.nvim';
  'ludovicchabant/vim-gutentags';
  'mattn/emmet-vim';
  'maxmellon/vim-jsx-pretty';
  'neovim/nvim-lspconfig';
  'nvim-lua/plenary.nvim';
  'nvim-treesitter/nvim-treesitter';
  'nvim-treesitter/playground';
  'ojroques/nvim-lspfuzzy';
  'pangloss/vim-javascript';
  'rktjmp/lush.nvim';
  'slim-template/vim-slim';
  'terryma/vim-multiple-cursors';
  'tpope/vim-commentary';
  'tpope/vim-dispatch';
  'tpope/vim-endwise';
  'tpope/vim-fugitive';
  'tpope/vim-obsession';
  'tpope/vim-rails';
  'tpope/vim-repeat';
  'tpope/vim-rhubarb';
  'tpope/vim-rhubarb';
  'tpope/vim-surround';
  'vijaymarupudi/nvim-fzf';
  'vim-crystal/vim-crystal';
  'vim-test/vim-test';
  'w0rp/ale';
  'wincent/vim-clipper';
  'wsdjeg/vim-fetch';
}

local function clone_paq()
  local path = vim.fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim'
  if vim.fn.empty(vim.fn.glob(path)) > 0 then
    vim.fn.system {
      'git',
      'clone',
      '--depth=1',
      'https://github.com/savq/paq-nvim.git',
      path
    }
  end
end

local function bootstrap_paq()
  clone_paq()
  -- Load Paq
  vim.cmd('packadd paq-nvim')
  local paq = require('paq')
  -- Exit nvim after installing plugins
  vim.cmd('autocmd User PaqDoneInstall quit')
  -- Read and install packages
  paq(PKGS)
  paq.install()
end

return { bootstrap_paq = bootstrap_paq }
