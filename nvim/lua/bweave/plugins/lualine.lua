paq {'hoob3rt/lualine.nvim'}

local branch = {
  "branch",
  icons_enabled = true,
  icon = "",
}

local buffers = {
  "buffers",
  max_length = vim.o.columns,
}

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic", "ale" },
  sections = { "error", "warn" },
  symbols = { error = " ", warn = " " },
  colored = false,
  update_in_insert = false,
  always_visible = true,
}

local diff = {
  "diff",
  colored = false,
  symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
  cond = hide_in_width
}

local filename = {'filename', file_status = true}

local mode = {
  'mode',
  fmt = function(str)
    return str:sub(1,1)
  end,
}

local location = {
	"location",
	padding = 0,
}

local lualine = require 'lualine'
lualine.setup {
  options = {
    icons_enabled = true,
    theme = 'onedark',
    component_separators = {left = '', right = ''},
    section_separators = { left = ' ', right = ' '},
    disabled_filetypes = {}
  },
  sections = {
    lualine_a = {mode},
    lualine_b = {branch, diff},
    lualine_c = {},
    lualine_x = {"filetype"},
    lualine_y = {location},
    lualine_z = {diagnostics},
  },
  inactive_sections = {
    lualine_a = {mode},
    lualine_b = {branch, diff},
    lualine_c = {},
    lualine_x = {"filetype"},
    lualine_y = {location},
    lualine_z = {diagnostics},
  },
  tabline = {},
  extensions = {
    'fugitive',
    'fzf',
    'nvim-tree'
  }
}
