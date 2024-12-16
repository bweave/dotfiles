-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function unmap(mode, lhs)
  vim.keymap.del(mode, lhs)
end

-- remove <leader>/ to toggle comments since it's available with <leader>sg
unmap("n", "<leader>/")

-- remove window keymaps, note which-key.lua has a related change, too
unmap("n", "<leader>ww")
unmap("n", "<leader>wd")
unmap("n", "<leader>w-")
unmap("n", "<leader>w|")
unmap("n", "<leader>wm")

local function keymap(mode, keys, func, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end

  vim.keymap.set(mode, keys, func, options)
end

local function nmap(keys, func, desc)
  keymap("n", keys, func, { desc = desc })
end

local function vmap(keys, func, desc)
  keymap("v", keys, func, { desc = desc })
end

-- C-P classic
nmap("<C-P>", function()
  if vim.loop.fs_stat(vim.loop.cwd() .. "/.git") then
    require("telescope.builtin").git_files({ hidden = true })
  else
    require("telescope.builtin").find_files({ hidden = true })
  end
end, "Find files")

-- toggle maximize window
nmap("<leader>m", function()
  LazyVim.toggle.maximize()
end, "Maximize Toggle")

-- Find finle in Explorer
nmap("<leader>F", "<cmd>Neotree reveal=true<cr>", "Find file in Explorer")

-- Find buffers
unmap("n", "<leader>bb") -- remove <leader>bb mapping so I can replace it, besides, <C-^> already does the job
nmap("<leader>bb", require("telescope.builtin").buffers, "Find Buffers")

-- zen mode
nmap("<leader>z", function()
  require("zen-mode").toggle()
end, "ZenMode")

-- close buffer
nmap("<leader>w", "<cmd>bd<cr>", "Close buffer")
nmap("<leader>W", "<cmd>%bd<cr>", "Close all buffers")

-- colorscheme
nmap("<leader>C", function()
  require("telescope.builtin").colorscheme({ enable_preview = true })
end, "Colorscheme with preview")

-- splitjoin
nmap("<leader>j", "<cmd>SplitjoinSplit<cr>", "Split")
nmap("<leader>k", "<cmd>SplitjoinJoin<cr>", "Join")

-- toggle highlights
nmap("<leader>h", ":set hlsearch! hlsearch?<CR>", "Toggle Highlights")
