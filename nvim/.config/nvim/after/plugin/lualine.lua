--
-- after/plugin/lualine.lua
--

local lualine_status, lualine = pcall(require, "lualine")
if not lualine_status then
  print("!! lualine couldn't be required !!")
end

local modified_color = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("WarningMsg")), "fg")
vim.api.nvim_set_hl(0, "WinBarModified", { fg = modified_color })

lualine.setup({
  options = {
    disabled_filetypes = { "NvimTree" },
    globalstatus = true,
    theme = "auto",
  },
  sections = {
    lualine_a = {
      {
        "mode",
        fmt = function(mode)
          return vim.go.paste == true and mode .. " | PASTE" or mode
        end,
      },
    },
    lualine_b = {
      "branch",
      "diff",
      {
        "diagnostics",
        source = { "nvim" },
        sections = { "error" },
      },
      {
        "diagnostics",
        source = { "nvim" },
        sections = { "warn" },
      },
      {
        "%w",
        cond = function()
          return vim.wo.previewwindow
        end,
      },
      {
        "%r",
        cond = function()
          return vim.bo.readonly
        end,
      },
      {
        "%q",
        cond = function()
          return vim.bo.buftype == "quickfix"
        end,
      },
    },
    lualine_c = {},
    lualine_x = {},
    lualine_z = { "location" },
  },
  tabline = {
    lualine_a = {},
    lualine_b = {
      {
        "buffers",
        max_length = vim.o.columns * 0.9,
        use_mode_colors = true,
      },
    },
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    -- lualine_z = {},
    lualine_z = {
      {
        "tabs",
        section_separators = { right = "", left = "" },
        component_separators = { right = "", left = "" },
      },
    },
  },
  winbar = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
      {
        "filename",
        color = function()
          local fg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Normal")), "fg")
          local bg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Normal")), "bg")
          return { fg = fg, bg = bg, gui = "italic" }
        end,
        colored = true,
        path = 1,
        symbols = {
          modified = "%#WinBarModified#",
        },
      },
    },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  inactive_winbar = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
      {
        "filename",
        color = function()
          local bg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Normal")), "bg")
          return { fg = "gray", bg = bg, gui = "italic" }
        end,
        colored = true,
        path = 1,
        symbols = {
          modified = "%#WinBarModified#",
        },
      },
    },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  extensions = { "nvim-tree", "fzf", "quickfix", "fugitive" },
})
