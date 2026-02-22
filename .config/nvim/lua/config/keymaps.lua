-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function unmap(mode, lhs)
  vim.keymap.del(mode, lhs)
end

-- remove <leader>/ to toggle comments since it's available with <leader>sg
unmap("n", "<leader>/")

-- remove window keymaps, note which-key.lua has a related change, too
-- unmap("n", "<leader>ww")
unmap("n", "<leader>wd")
-- unmap("n", "<leader>w-")
-- unmap("n", "<leader>w|")
unmap("n", "<leader>wm")

local wk = require("which-key")
local function add_which_key(lhs, rhs, opts)
  opts = opts or {}
  opts["mode"] = opts["mode"] or "n"
  local keybind = { lhs, rhs }
  for k, v in pairs(opts) do
    keybind[k] = v
  end
  wk.add({ keybind })
end

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
add_which_key("<leader>z", function()
  require("zen-mode").toggle()
end, { desc = "ZenMode", icon = "󰍉 " })

-- close buffer
-- nmap("<leader>w", "<cmd>bd<cr>", "Close buffer")
-- nmap("<leader>W", "<cmd>%bd<cr>", "Close all buffers")

-- colorscheme
add_which_key("<leader>C", function()
  require("telescope.builtin").colorscheme({ enable_preview = true })
end, { desc = "Colorscheme with preview", icon = " " })

-- splitjoin
add_which_key("<leader>j", "<cmd>SplitjoinSplit<cr>", { desc = "Split", icon = "󰹹" })
add_which_key("<leader>k", "<cmd>SplitjoinJoin<cr>", { desc = "Join", icon = "󰹳 " })

-- toggle highlights
nmap("<leader>h", ":set hlsearch! hlsearch?<CR>", "Toggle Highlights")

-- berg weekly update
add_which_key("<leader>U", function()
  local date_str = os.date("%m-%d-%Y")
  local file_path = "~/brain/berg-weekly-updates/" .. date_str .. ".md"
  local dir_path = vim.fn.expand("~/brain/berg-weekly-updates")
  vim.fn.mkdir(dir_path, "p")
  local success, err = pcall(function()
    vim.cmd("Template " .. vim.fn.fnameescape(file_path) .. " berg_weekly_update")
  end)
  if not success then
    vim.notify("Failed to create weekly update: " .. tostring(err), vim.log.levels.ERROR)
  else
    vim.notify("Created weekly update: " .. file_path, vim.log.levels.INFO)
  end
end, { desc = "Berg Weekly Update", icon = "󰨳" })
