-- Plugins

-- auto-install paq if needed
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth=1', 'https://github.com/savq/paq-nvim.git', install_path})
end

local paq = require('paq-nvim').paq  -- a convenient alias
paq {'savq/paq-nvim', opt = true}    -- paq-nvim manages itself

paq {'akinsho/bufferline.nvim'}
paq {'hoob3rt/lualine.nvim'}
paq {'junegunn/fzf', run = fn['fzf#install']}
paq {'junegunn/fzf.vim'}
paq {'kassio/neoterm'} -- TODO: mappings to make this useful?
paq {'kosayoda/nvim-lightbulb'}
paq {'kyazdani42/nvim-web-devicons'}
paq {'kyazdani42/nvim-tree.lua'}
paq {'lewis6991/gitsigns.nvim'}
paq {'ludovicchabant/vim-gutentags'}
paq {'mattn/emmet-vim'}
paq {'maxmellon/vim-jsx-pretty'}
paq {'neovim/nvim-lspconfig'}
paq {'nvim-lua/plenary.nvim'}
paq {'nvim-treesitter/nvim-treesitter'}
paq {'ojroques/nvim-lspfuzzy'}
paq {'pangloss/vim-javascript'}
paq {'rktjmp/lush.nvim'}
paq {'slim-template/vim-slim'}
paq {'terryma/vim-multiple-cursors'}
paq {'tpope/vim-commentary'}
paq {'tpope/vim-dispatch'}
paq {'tpope/vim-endwise'}
paq {'tpope/vim-fugitive'}
paq {'tpope/vim-obsession'}
paq {'tpope/vim-rails'}
paq {'tpope/vim-repeat'}
paq {'tpope/vim-rhubarb'}
paq {'tpope/vim-surround'}
paq {'vim-crystal/vim-crystal'}
paq {'vim-test/vim-test'}
paq {'w0rp/ale'}
paq {'wincent/vim-clipper'}
paq {'wsdjeg/vim-fetch'}
paq {'Glench/Vim-Jinja2-Syntax'}

-- Local plugins
vim.opt.runtimepath:append("~/src/bweave-nvim") -- my dark theme built with Lush
vim.opt.runtimepath:append("~/src/nord-light")  -- Nord light theme built with Lush
vim.cmd 'colorscheme bweave'
