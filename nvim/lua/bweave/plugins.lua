-- Plugins

-- Local plugins
vim.opt.runtimepath:append("~/src/bweave-nvim") -- my dark theme built with Lush
vim.opt.runtimepath:append("~/src/nord-light")  -- Nord light theme built with Lush
vim.cmd 'colorscheme bweave'

-- auto-install paq if needed
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth=1', 'https://github.com/savq/paq-nvim.git', install_path})
end

local paq = require('paq-nvim').paq  -- a convenient alias
paq {'savq/paq-nvim', opt = true}    -- paq-nvim manages itself
paq {'rktjmp/lush.nvim'}
paq {'hoob3rt/lualine.nvim'}
paq {'akinsho/bufferline.nvim'}
paq {'kyazdani42/nvim-web-devicons'}
paq {'neovim/nvim-lspconfig'}
paq {'nvim-treesitter/nvim-treesitter'}
paq {'junegunn/fzf', run = fn['fzf#install']}
paq {'junegunn/fzf.vim'}
paq {'ojroques/nvim-lspfuzzy'}
paq {'nvim-lua/plenary.nvim'}
paq {'lewis6991/gitsigns.nvim'}
paq {'kosayoda/nvim-lightbulb'}
paq {'kassio/neoterm'}

-- Plugin Settings -- TODO: move this to plugin_settings.lua

local ts = require 'nvim-treesitter.configs'
ts.setup {ensure_installed = 'maintained', highlight = {enable = true}}

local lsp = require 'lspconfig'
local lspfuzzy = require 'lspfuzzy'

-- We use the default settings for ccls and pylsp: the option table can stay empty
lsp.solargraph.setup {}
lsp.tsserver.setup {}
lspfuzzy.setup {}  -- Make the LSP client use FZF instead of the quickfix list

-- TODO: this needs to move to Mappings
-- map('n', '<space>,', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
-- map('n', '<space>;', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
-- map('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>')
-- map('n', '<space>d', '<cmd>lua vim.lsp.buf.definition()<CR>')
-- map('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>')
-- map('n', '<space>h', '<cmd>lua vim.lsp.buf.hover()<CR>')
-- map('n', '<space>m', '<cmd>lua vim.lsp.buf.rename()<CR>')
-- map('n', '<space>r', '<cmd>lua vim.lsp.buf.references()<CR>')
-- map('n', '<space>s', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')

require'lualine'.setup {
  options = {
    icons_enabled = true,
    theme = 'onedark',
    component_separators = {'', ''},
    section_separators = {'', ''},
    disabled_filetypes = {}
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff'},
    lualine_c = {{'filename', file_status = true}},
    lualine_x = {'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location',
      {
        'diagnostics',
        -- table of diagnostic sources, available sources:
        -- nvim_lsp, coc, ale, vim_lsp
        sources = {'nvim_lsp', 'ale'},
        -- displays diagnostics from defined severity
        sections = {'error', 'warn', 'info', 'hint'},
        -- all colors are in format #rrggbb
        color_error = "#ff0000", -- changes diagnostic's error foreground color
        color_warn = "#ff0000", -- changes diagnostic's warn foreground color
        color_info = "#ff0000", -- Changes diagnostic's info foreground color
        color_hint = "#ff0000", -- Changes diagnostic's hint foreground color
        symbols = {error = '🚫', warn = '⚠️', info = 'I', hint = 'H'}
      }
    }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {{'filename', file_status = true}},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {
    'fugitive',
    'fzf',
    'nerdtree',
    'nvim-tree'
  }
}

require'bufferline'.setup {
  options = {
    numbers = "ordinal"
  }
}
