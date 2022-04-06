paq {'folke/which-key.nvim'}

local setup = {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  -- operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    ["<space>"] = "SPC",
    ["<leader>"] = "SPC",
    ["<cr>"] = "RET",
    ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = '<c-d>', -- binding to scroll down inside the popup
    scroll_up = '<c-u>', -- binding to scroll up inside the popup
  },
  window = {
    border = "none", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0
  },
  layout = {
    height = { min = 5, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
}

local opts = {
  mode = "n", -- NORMAL mode
  -- prefix: use "<leader>f" for example for mapping everything related to finding files
  -- the prefix is prepended to every mapping part of `mappings`
  prefix = "<leader>", 
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false, -- use `nowait` when creating keymaps
}

local mappings = {
  b = { "<cmd>Buffers<cr>", "Buffers" },
  c = { "<cmd>Commits<cr>", "Commits" },
  C = { "<cmd>lua require('bweave.functions.colors').colors()<cr>", "Colors" },
  D = { "<cmd>lua require('bweave.functions.colors').toggle_dark_theme()<cr>", "Dark/light theme toggle" },
  e = {
    name = "Explorer",
    c = { "<cmd>NvimTreeClose<cr>", "Close" },
    o = { "<cmd>NvimTreeOpen<cr>", "Open" },
    r = { "<cmd>NvimTreeRefresh<cr>", "Refresh" },
  },
  E = { "<cmd>NvimTreeToggle<cr>", "Explorer toggle" },
  f = { "<cmd>FZF<cr>", "Files" },
  F = { "<cmd>NvimTreeFindFileToggle<cr>", "File in explorer toggle" },
  g = {
    name = "Git",
    b = {
      name = "Blame",
      f = { "<cmd>Git blame<cr>", "File" },
      l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Line" },
    },
    B = { "<cmd>GBrowse!<CR>", "Browse" },
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
    h = {
      name = "Hunk",
      p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
      r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
      s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
      u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk" },
    },
    s = { "<cmd>vertical Git<CR>", "Status" },
    d = { "<cmd>Gitsigns diffthis HEAD<cr>", "Diff" },
    r = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
  },
  G = {
    name = "Go to",
    d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Definition" },
    D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Declaration" },
    r = { "<cmd>lua vim.lsp.buf.references()<CR>", "References" },
  },
  h = { "<cmd>set hlsearch! hlsearch?<CR>", "Highlight toggle" },
  l = {
    name = "LSP",
    a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code action" },
    d = { "<cmd>lua vim.lsp.diagnostic.get_line_diagnostics()<CR>", "Line diagnostics" },
    K = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover" },
    r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
    s = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature help" },
  },
  n = {
    name = "Neovim",
    e = {
      name = "Edit configs",
      -- TODO: could this list be dynamically generated?
      i = { "<cmd>e ~/.config/nvim/init.lua<CR>", "init.lua"},
      m = { "<cmd>e ~/.config/nvim/lua/bweave/mappings.lua<CR>", "mappings.lua"},
      p = { "<cmd>e ~/.config/nvim/lua/bweave/plugins.lua<CR>", "plugins.lua"},
    },
    r = { "<cmd>so ~/.config/nvim/init.lua<CR>", "Reload config" },
  },
  O = { "<cmd>vs ~/Desktop/Onboarding.md<cr>", "Onboarding" },
  p = {
    name = "Paq",
    c = { "<cmd>PaqClean<cr>", "Clean" },
    C = { "<cmd>PaqLogClean<cr>", "Log Clean" },
    i = { "<cmd>PaqInstall<cr>", "Install" },
    l = { "<cmd>PaqList<cr>", "List" },
    L = { "<cmd>PaqLogOpen<cr>", "Log" },
    s = { "<cmd>PaqSync<cr>", "Sync" },
    u = { "<cmd>PaqUpdate<cr>", "Update" },
  },
  P = { "<cmd>set invpaste<cr>", "Paste mode toggle" },
  s = {
    name = "Search",
    w = { ":Ag <C-R><C-W><CR>", "Word under cursor" },
    p = { ":Ag ", "Project", silent = false },
  },
  S = { "<cmd>vs .vscode/scratchpad_local.md<cr>", "Scratchpad" },
  t = {
    name = "Test",
    r = { "<cmd>Texec rerun\\ -bcx\\ --no-notify\\ --\\ bin/rails\\ test\\ %<CR>", "Rails rerun test file" },
    t = { "<cmd>TestFile<CR>", "File" },
    T = { "<cmd>TestNearest<CR>", "Nearest" },
  },
  T = {
    name = "Terminal",
    n = { "<cmd>Tnew<CR>", "New" },
    r = {
      name = "REPL",
      f = { "<cmd>TREPLSendFile<CR>", "Send file" },
      l = { "<cmd>TREPLSendLine<CR>", "Send line" },
      s = { "<cmd>TREPLSendSelection<CR>", "Send selection" },
    },
  },
  w = { "<cmd>bdelete!<CR>", "Buffer delete" },
}

local which_key = require 'which-key'
which_key.setup(setup)
which_key.register(mappings, opts)
