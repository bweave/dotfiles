local M = {}
local fzf = require("fzf").fzf
local action = require("fzf.actions").action
local Utils = require("bweave.utils")

-- The default colors suck, so let's exclude them.
local colors_to_exclude = {
  "blue",
  "darkblue",
  "delek",
  "desert",
  "elflord",
  "evening",
  "industry",
  "koehler",
  "morning",
  "murphy",
  "pablo",
  "peachpuff",
  "ron",
  "shine",
  "slate",
  "torte",
  "zellner",
}

local function get_colorschemes()
  local colorscheme_vim_files = vim.fn.globpath(vim.o.rtp, "colors/*.vim", true, true)
  local colors = {}
  for _, colorscheme_file in ipairs(colorscheme_vim_files) do
    local color = vim.fn.fnamemodify(colorscheme_file, ":t:r")
    if not Utils.table_contains(colors_to_exclude, color) then
      table.insert(colors, color)
    end
  end
  return colors
end

local function get_current_colorscheme()
  if vim.g.colors_name then
    return vim.g.colors_name
  else
    return 'default'
  end
end

M.colors = function()
  coroutine.wrap(function ()
    local preview_function = action(function (args)
      if args then
        local colorscheme = args[1]
        vim.cmd("set winhl=Normal:Normal")
        vim.cmd("colorscheme " .. colorscheme)
      end
    end)

    local current_colorscheme = get_current_colorscheme()
    local choices = fzf(get_colorschemes(), "--preview=" .. preview_function .. " --preview-window right:0", { height = 10, width = 50 })
    if not choices then
      vim.cmd("colorscheme " .. current_colorscheme)
    else
      vim.cmd("colorscheme" .. choices[1])
    end
  end)()
end

return M
