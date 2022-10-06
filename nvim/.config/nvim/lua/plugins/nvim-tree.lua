--------------------------------------------------------------------------
-- Nvim-Tree
-- nvim_tree_highlight_opened_files, nvim_tree_git_hl, nvim_tree_respect_buf_cwd, nvim_tree_icons, nvim_tree_show_icons
--------------------------------------------------------------------------

local g = vim.g

g.nvim_tree_width_allow_resize  = 1

local status_ok, nvim_tree = pcall(require, 'nvim-tree')
if not status_ok then
  return
end

-- Call setup:
--- Each of these are documented in `:help nvim-tree.OPTION_NAME`
nvim_tree.setup {
  -- open_on_setup = true,
  -- open_on_setup_file = true,
  -- open_on_tab = true,
  -- auto_close = false,
  -- update_cwd = true,
  respect_buf_cwd = true,
  view = { width = 32 },
  renderer = {
    highlight_opened_files = "1",
    highlight_git = true,
    icons = {
      glyphs = { default = "" },
      show = {
        git = true,
        folder = true,
        folder_arrow = true,
        file = true,
      },
    },
    indent_markers = {
      enable = false,
      icons = {
        corner = "└ ",
        edge = "│ ",
        none = "  ",
      },
    },
  },
  actions = {
    change_dir = { enable = false },
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  filters = {
    dotfiles = true,
    custom = { 'node_modules', '.cache', '.bin' },
  },
}
