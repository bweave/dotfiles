require('bweave.settings')

-- Mappings
vim.g.mapleader = ' '

map = function(mode, lhs, rhs, opts)
  local options = {noremap = true, silent = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Plugins

-- auto-install paq if needed
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth=1', 'https://github.com/savq/paq-nvim.git', install_path})
end

paq = require('paq').paq  -- a convenient global alias
paq {'savq/paq-nvim'}    -- paq-nvim manages itself

local function plugin(name)
  require("bweave.plugins." .. name)
end

plugin "ale"
plugin "bufferline"
plugin "clipper"
plugin "emmet"
plugin "fzf"
plugin "gitsigns"
plugin "goyo"
plugin "gutentags"
plugin "javascript"
plugin "jsx-pretty"
-- plugin "lightbulb"
-- plugin "lspconfig"
plugin "lualine"
plugin "lush"
plugin "multiple-cursors"
plugin "neoterm"
plugin "nvim-fzf"
plugin "nvim-tree"
plugin "slim"
plugin "splitjoin"
plugin "tpope-commentary"
plugin "tpope-dispatch"
plugin "tpope-endwise"
plugin "tpope-fugitive"
plugin "tpope-obsession"
plugin "tpope-vim-rails"
plugin "tpope-vim-repeat"
plugin "tpope-vim-rhubarb"
plugin "tpope-vim-surround"
plugin "treesitter"
plugin "vim-fetch"
plugin "vim-jinja2-syntax"
plugin "vim-test"
plugin "vim-tmux-navigator"
plugin "whichkey"