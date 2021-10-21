-- Plugin Settings

-- ale
vim.g.ale_fix_on_save = 1
vim.g.ale_ruby_rubocop_executable = 'bundle'
vim.g.ale_ruby_ruby_executable = '~/.rbenv/shims/ruby'
vim.g.ale_linters = {
   ruby = {'rubocop'},
   javascript = {'eslint'},
   javascriptreact = {'eslint'},
   css = {'eslint'},
   sql = {'sqlint'},
   mysql = {'sqlint'},
}
vim.g.ale_fixers = {
  ['*'] = {'remove_trailing_lines', 'trim_whitespace'},
   ruby = {'rubocop'},
   javascript = {'eslint'},
   javascriptreact = {'eslint'},
   css = {'eslint'},
}

-- vim-test
vim.g['test#strategy'] = "neovim"
vim.g['test#preserve_screen'] = true
vim.g['test#neovim#term_position'] = "vert botright 80"
vim.g['test#vim#term_position'] = "vert botright 80"

-- neoterm
vim.g.neoterm_default_mod = "vert botright 80"

-- emmet
vim.g.user_emmet_leader_key = ','

-- treesitter
-- local ts = require 'nvim-treesitter.configs'
-- ts.setup {
--   ensure_installed = 'maintained',
--   highlight = {
--     enable = true,
--     additional_vim_regex_highlighting = true, -- compatibility with ruby endwise
--   },
-- }

-- lsp
local lsp = require 'lspconfig'
local lspfuzzy = require 'lspfuzzy'
lsp.solargraph.setup {
  settings = {
    solargraph = {
      diagnostics = true,
      bundlerPath = '~/.rbenv/shims/bundle'
    }
  }
}
lsp.tsserver.setup {}
lspfuzzy.setup {}  -- Make the LSP client use FZF instead of the quickfix list

require'nvim-tree'.setup()

-- lualine
local lualine = require 'lualine'
lualine.setup {
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

local bufferline = require 'bufferline'
bufferline.setup {
  options = {
    numbers = "ordinal"
  }
}

require('gitsigns').setup {
  keymaps = {
    -- Default keymap options
    noremap = true,

    ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'"},
    ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'"},

    ['n <leader>sh'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
    ['v <leader>sh'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    ['n <leader>uh'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
    ['n <leader>rh'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
    ['v <leader>rh'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    ['n <leader>Rh'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
    ['n <leader>ph'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
    ['n <leader>gb'] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',
    ['n <leader>Sh'] = '<cmd>lua require"gitsigns".stage_buffer()<CR>',
    ['n <leader>Uh'] = '<cmd>lua require"gitsigns".reset_buffer_index()<CR>',

    -- Text objects
    ['o ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
    ['x ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>'
  },
}

vim.g.splitjoin_split_mapping = ''
vim.g.splitjoin_join_mapping = ''
vim.g.splitjoin_trailing_comma = 1
vim.g.vim_jsx_pretty_colorful_config = 1
vim.g.preferred_searcher = 'ag'
vim.g.fzf_layout = { down = '30%' }
vim.g.fzf_preview_window = ''
vim.g.fzf_buffers_jump = 1
vim.g.gutentags_file_list_command = 'rg --files'
vim.g.gutentags_ctags_exclude = {
  '*.md', '*.markdown', '*.css', '*.scss', '*.html', '*.erb', '*.json', '*.xml',
  'yarn.lock', 'package.json', 'Gemfile.lock', 'Gemfile', 'Procfile', 'Guardfile', 'vendor/assets/*',
  'public', 'log', 'node_modules', 'tmp'
}
