--
-- lua/bweave/keymaps.lua
--

local utils = require("bweave.utils")
local nmap = utils.nmap
local vmap = utils.vmap
local tmap = utils.tmap

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
nmap("<Space>", "<Nop>", "Leader")
vmap("<Space>", "<Nop>", "Leader")

-- Better window navigation
nmap("<C-h>", "<C-w>h", "Window left")
nmap("<C-j>", "<C-w>j", "Window down")
nmap("<C-k>", "<C-w>k", "Window up")
nmap("<C-l>", "<C-w>l", "Window right")

-- Appearance
nmap("<leader>ad", function()
	if vim.o.bg == "light" then
		vim.o.bg = "dark"
	else
		vim.o.bg = "light"
	end
end, "[A]ppearance Toggle background light/[d]ark")

nmap("<leader>at", ":TransparentToggle<CR>", "[A]ppearance Toggle [T]ransparency")

-- Finders
nmap("<leader>E", require("nvim-tree").toggle, "Toggle file explorer")
nmap("<C-p>", ":Telescope find_files follow=true hidden=true<CR>", "Find [F]iles")
nmap("<leader>f", ":Telescope find_files follow=true hidden=true<CR>", "Find [F]iles")
nmap("<leader>F", ":NvimTreeFindFile<CR>", "Find [F]ile in explorer")
nmap("<leader>b", require("telescope.builtin").buffers, "Find [B]uffers")
nmap("<leader>c", require("telescope.builtin").colorscheme, "[C]olorschemes")
nmap("<leader>r", require("telescope.builtin").registers, "[R]egisters")
nmap("<leader>K", require("telescope.builtin").keymaps, "[K]eymaps")
nmap("<leader>sd", require("telescope.builtin").diagnostics, "[S]earch [D]iagnostics")
nmap(
	"<leader>ec",
	":Telescope find_files cwd=" .. vim.fn.stdpath("config") .. " follow=true hidden=true<CR>",
	"[E]dit [C]onfig files"
)
nmap(
	"<leader>ed",
	":Telescope find_files cwd=" .. vim.env.HOME .. "/dotfiles" .. " follow=true hidden=true<CR>",
	"[E]dit [D]otfiles"
)
nmap(
	"<leader>es",
	":Telescope find_files cwd=.vscode search_file=scratchpad_local.md follow=true hidden=true<CR>",
	"[E]dit [S]cratchpad"
)

-- Search
nmap("<leader>s", require("telescope.builtin").live_grep, "[S]earch")
nmap("<leader>S", require("telescope.builtin").grep_string, "[S]earch word under cursor")
nmap("<leader>h", ":set hlsearch! hlsearch?<CR>", "Toggle [H]ighlights")

-- Buffers
nmap("<S-right>", ":bnext<CR>", "Next buffer")
nmap("<S-left>", ":bprevious<CR>", "Previous buffer")
nmap("<S-M-right>", ":tabnext<CR>", "Next tab")
nmap("<S-M-left>", ":tabprevious<CR>", "Previous tab")
nmap("<leader>w", ":bd<CR>", "[B]uffer [D]elete")
nmap("<leader>/", ":Commentary<CR>", "Toggle [C]omments")
vmap("<leader>/", ":Commentary<CR>", "Toggle [C]omments")
nmap("<leader>j", ":SplitjoinSplit<CR>", "SplitJoin split")
nmap("<leader>k", ":SplitjoinJoin<CR>", "SplitJoin join")
nmap("<leader>L", ':let @*=fnamemodify(expand("%"), ":~:.") . ":" . line(".")<CR>', "Copy path w/[l]ine number")
nmap("<leader>p", ":set invpaste<CR>", "Toggle [P]aste")
vmap("<", "<gv", "Dedent selection")
vmap(">", ">gv", "Indent selection")

-- Git
nmap("<leader>gs", ":vertical Git<CR>", "[G]it [S]tatus")
nmap("<leader>gH", ":GBrowse<CR>", "[G]it[h]ub")
nmap("<leader>gb", ":Git blame<CR>", "[G]it [B]lame")
nmap("<leader>gB", require("telescope.builtin").git_branches, "[G]it [B]ranches")
nmap("<leader>gS", require("telescope.builtin").git_stash, "[G]it [S]tashes")
nmap("<leader>ghp", require("gitsigns").preview_hunk, "[G]it [P]review [H]unk")
nmap("<leader>ghr", require("gitsigns").reset_hunk, "[G]it [R]eset [H]unk")

-- Testing
nmap("<leader>tt", ":TestFile<CR>", "Test file")
nmap("<leader>tT", ":TestNearest<CR>", "Test nearest")
nmap("<leader>tr", function()
	local installed_via_bundler = require("bweave.utils").installed_via_bundler
	local rerun = installed_via_bundler("rerun") and "bundle exec rerun" or "rerun"
	local rerun_args = "-bcx --no-notify --"
	local rspec = installed_via_bundler("rspec")
	local test_runner = rspec and "bundle exec rspec" or "bin/rails test"
	local test_type = rspec and "spec" or "test"
	local test_file = vim.fn.expand("%"):gsub("app", test_type):gsub("(%a+)(%.%a+)$", "%1_" .. test_type .. "%2")
	local test_command = table.concat({ rerun, rerun_args, test_runner, test_file }, " ")

	vim.cmd.Texec(test_command)
end, "Rerun Rails test/spec")

-- Terminal
nmap("<leader>T", ":botright vsplit term://$SHELL<CR>", "New [T]erminal")
tmap("<Esc><Esc>", "<C-\\><C-n>", "Esc to Normal mode")
