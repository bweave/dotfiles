paq {'hoob3rt/lualine.nvim'}

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
        sources = {'nvim_diagnostics', 'ale'},
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
