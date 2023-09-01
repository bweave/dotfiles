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

-- Finders
nmap("<leader>E", ":NvimTreeToggle<CR>", "Toggle [E]xplorer")
nmap("<C-p>", require("fzf-lua").files, "Find [F]iles")
nmap("<leader>f", require("fzf-lua").files, "Find [F]iles")
nmap("<leader>F", ":NvimTreeFindFileToggle<CR>", "Find [F]ile in explorer")
nmap("<leader>b", require("fzf-lua").buffers, "Find [B]uffers")
nmap("<leader>c", require("fzf-lua").colorschemes, "[C]olorschemes")
nmap("<leader>q", require("fzf-lua").quickfix, "[Q]uickfix")
nmap("<leader>R", require("fzf-lua").registers, "[R]egisters")
nmap("<leader>K", require("fzf-lua").keymaps, "[K]eymaps")
nmap("<leader>ec", function()
	require("fzf-lua").files({ cwd = vim.fn.stdpath("config") })
end, "[E]dit [C]onfig files")
nmap("<leader>ed", function()
	require("fzf-lua").files({ cwd = vim.env.HOME .. "/dotfiles" })
end, "[E]dit [D]otfiles")
nmap("<leader>es", "<cmd>vs .vscode/scratchpad_local.md<CR>", "[E]dit [S]cratchpad")

-- Search
nmap("<leader>lF", require("fzf-lua").lsp_finder, "[F]inder")
nmap("<leader>s", require("fzf-lua").grep, "[S]earch")
nmap("<leader>S", require("fzf-lua").grep_cword, "[S]earch word under cursor")
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

-- Window
nmap("<leader>Wtr", function()
	vim.ui.input({ prompt = "Enter new tab name: " }, function(input)
		if input then
			vim.cmd("LualineRenameTab " .. input)
		end
	end)
end, "[W]indow [T]ab [R]ename")
nmap("<leader>Wtf", require("fzf-lua").tabs, "[W]indow [T]ab [F]ind")

-- Git
nmap("<leader>gm", ":GitMessenger<CR>", "[G]it [M]essenger")
nmap("<leader>gs", ":vertical Git<CR>", "[G]it [S]tatus")
nmap("<leader>gH", ":GBrowse<CR>", "[G]it[h]ub")
nmap("<leader>gb", ":Git blame<CR>", "[G]it [B]lame")
nmap("<leader>gB", require("fzf-lua").git_branches, "[G]it [B]ranches")
nmap("<leader>gS", require("fzf-lua").git_stash, "[G]it [S]tashes")
nmap("<leader>ghp", require("gitsigns").preview_hunk, "[G]it [P]review [H]unk")
nmap("<leader>ghr", require("gitsigns").reset_hunk, "[G]it [R]eset [H]unk")

-- Ruby & Rails
nmap("<leader>rc", ":Rails console<CR>", "Rails [c]onsole")
nmap("<leader>rl", ":Texec tail\\ -f\\ log/development.log<CR>", "Rails [l]og")
nmap("<leader>rR", ":Rails runner %<CR>", "Rails [R]unner")
nmap("<leader>rr", function()
	local installed_via_bundler = require("bweave.utils").installed_via_bundler
	local rerun = installed_via_bundler("rerun") and "bundle exec rerun" or "rerun"
	local rerun_args = "-bcx --no-notify --"
	local rspec = installed_via_bundler("rspec")
	local test_runner = rspec and "bundle exec rspec" or "bin/rails test"
	local test_type = rspec and "spec" or "test"
	local test_file = vim.fn.expand("%")
	if not test_file:match(test_type) then
		test_file = vim.fn.expand("%"):gsub("app", test_type):gsub("(%a+)(%.%a+)$", "%1_" .. test_type .. "%2")
	end
	local test_command = table.concat({ rerun, rerun_args, test_runner, test_file }, " ")

	vim.cmd.Texec(test_command)
end, "[R]erun Rails test/spec")
nmap("<leader>rs", ":Rails server<CR>", "Rails [s]erver")

-- Testing
nmap("<leader>tf", ":TestFile<CR>", "Test [F]ile")
nmap("<leader>tn", ":TestNearest<CR>", "Test [N]earest")
nmap("<leader>ts", ":TestSuite<CR>", "Test [S]uite")

-- Terminal
nmap("<leader>Tn", ":botright vsplit term://$SHELL<CR>", "[N]ew Terminal")
nmap("<leader>Trf", "<cmd>TREPLSendFile<CR>", "[R]epl [F]ile")
nmap("<leader>Trl", "<cmd>TREPLSendLine<CR>", "[R]epl [L]ine")
nmap("<leader>Trs", "<cmd>TREPLSendSelection<CR>", "[R]epl [S]election")
tmap("<Esc><Esc>", "<C-\\><C-n>", "Esc to Normal mode")
