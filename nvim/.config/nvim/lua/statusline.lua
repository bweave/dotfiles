local function debug(val)
    print(vim.inspect(val))
end

local fn = vim.fn
local o = vim.o
local cmd = vim.cmd
local api = vim.api
local lsp_status = require 'lsp-status'

local trunc_widths = {
  mode       = 80,
  git_status = 90,
  filename   = 140,
}

local function is_truncated(width)
  local current_width = api.nvim_win_get_width(0)
  return current_width < width
end

-- local colors = {
--   active = '%#StatusLine#',
--   inactive = '%#StatuslineNC#',
--   mode = '%#Mode#',
--   mode_alt = '%#ModeAlt#',
--   git = '%#Git#',
--   git_alt = '%#GitAlt#',
--   filetype = '%#Filetype#',
--   filetype_alt = '%#FiletypeAlt#',
--   line_col = '%#LineCol#',
--   line_col_alt = '%#LineColAlt#',
-- }

local separators = {
  arrow = '  ',
  blank = ' ',
  pipe = ' | ',
}

local modes = {
  ["n"]  = { "N", "NORMAL" },
  ["no"] = { "N·P", "N·PENDING" } ,
  ["v"]  = { "V", "VISUAL"  },
  ["V"]  = { "V·L", "V·LINE"  },
  [""] = { "V·B", "V·BLOCK" }, -- this is not ^V, but it's , they're different
  ["s"]  = { "S", "SELECT" },
  ["S"]  = { "S·L", "S·LINE" },
  [""] = { "S·B", "S·BLOCK" }, -- same with this one, it's not ^S but it's 
  ["i"]  = { "I", "INSERT" },
  ["ic"] = { "I", "INSERT" },
  ["R"]  = { "R", "REPLACE" },
  ["Rv"] = { "V·R", "V·REPLACE" },
  ["c"]  = { "C", "COMMAND" },
  ["cv"] = { "V·E", "VIM·EX" },
  ["ce"] = { "E", "EX" },
  ["r"]  = { "P", "PROMPT" },
  ["rm"] = { "M", "MORE" },
  ["r?"] = { "C", "CONFIRM" },
  ["!"]  = { "S", "SHELL" },
  ["t"]  = { "T", "TERMINAL" },
  ["nt"]  = { "NT", "N·TERMINAL" },
}

local function vim_mode()
  local paste = vim.o.paste and "[P] " or ""
  local current_mode = vim.api.nvim_get_mode().mode
  local mode = modes[current_mode] or { "Unknown:", "U" }
  local mode_text = is_truncated(trunc_widths.mode) and mode[1] or mode[2]
  return paste .. mode_text
end

local function get_git_status()
  -- use fallback because it doesn't set this variable on the initial `BufEnter`
  local signs = vim.b.gitsigns_status_dict or {head = '', added = 0, changed = 0, removed = 0}
  local is_git = signs.head ~= ''

  if is_truncated(trunc_widths.git_status) then
    return is_git and string.format(' %s', signs.head or '') or ''
  end

  return is_git and string.format(
    ' %s +%s ~%s -%s',
    signs.head, signs.added, signs.changed, signs.removed
  ) or ''
end

local function filename()
  return is_truncated(trunc_widths.filename) and "%<%t" or "%<%f"
end

local function filetype()
  local file_name, file_ext = fn.expand("%:t"), fn.expand("%:e")
  local icon = require'nvim-web-devicons'.get_icon(file_name, file_ext, { default = true })
  local filetype = vim.bo.filetype

  if filetype == '' then return '' end
  return string.format('%s %s', icon, filetype):lower()
end

local function position()
  return "%l:%c"
end

local function active_status_line()
  if api.nvim_buf_get_option(api.nvim_get_current_buf(), 'ft') == 'NvimTree' then
    vim.opt_local.statusline = ' '
    return
  end

  vim.opt_local.statusline = table.concat {
    separators.blank,
    vim_mode(),
    separators.arrow,
    filename(),
    separators.pipe,
    filetype(),
    separators.pipe,
    position(),
    "%=",
    get_git_status(),
    lsp_status.status(),
    separators.blank,
  }
end

local function inactive_status_line()
  if api.nvim_buf_get_option(api.nvim_get_current_buf(), 'ft') == 'NvimTree' then
    vim.opt_local.statusline = ' '
    return
  end

  vim.opt_local.statusline = table.concat {
    separators.blank,
    filename(),
    "%=",
    separators.blank,
  }
end

-- Set active, inactive
api.nvim_create_augroup("Statusline", {})
api.nvim_create_autocmd({"BufEnter", "WinEnter", "ModeChanged", "OptionSet"}, {
  group = "Statusline",
  pattern = "*",
  callback = active_status_line,
})
api.nvim_create_autocmd({"BufLeave", "WinLeave"}, {
  group = "Statusline",
  pattern = "*",
  callback = inactive_status_line,
})

-- Reloads this file when you save this file

cmd [[
  augroup statusline_config
    autocmd!
    autocmd BufWritePost statusline.lua source <afile>
  augroup end
]]
