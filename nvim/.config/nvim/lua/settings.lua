--------------------------------------------------------------------------
-- Settings
--------------------------------------------------------------------------

-- Nvim API aliases
local cmd = vim.cmd -- Execute Vim command
local exec = vim.api.nvim_exec -- Execute Vimstript
local g = vim.g -- Global vars
local opt = vim.opt -- Options (global, buffer, window-scoped)
local api = vim.api -- API

-- General
opt.backup = false -- Disable backups
opt.completeopt = "menuone,noselect" -- Autocomplete
opt.mouse = "a" -- Enable mouse
opt.swapfile = false -- Disable swapfiles
opt.writebackup = false -- Disable backups

-- UI
opt.colorcolumn = "101" -- Line lenght marker at 80 columns
opt.confirm = true -- Ask for confirmation
opt.cursorline = true -- Highlight curent line
opt.expandtab = true -- Use spaces, not tabs
opt.foldmethod = "marker" -- Enable folding (default 'foldmarker')
opt.ignorecase = true -- Ignore case letters when search
opt.inccommand = "nosplit" -- Show effects of command as you type
opt.linebreak = true -- Wrap on word boundary
opt.joinspaces = false -- Don't add 2 spaces when joining lines
opt.laststatus = 3 -- show global statusline
opt.number = true -- Show line number
opt.showmatch = true -- Highlight matching parenthesis
opt.showmode = false -- Don't show Vim mode in the command line since I have it in my statusline
opt.smartcase = true -- Ignore lowercase for the whole pattern
opt.splitbelow = true -- Orizontal split to the bottom
opt.splitright = true -- Vertical split to the right
opt.termguicolors = true -- Enable 24-bit RGB colors
opt.title = true -- Allow setting the terminal title
opt.titlestring = vim.fn.fnamemodify(vim.fn.getcwd(), ":t") -- Set the terminal title to the current directory
opt.wildmode = "list:full" -- List all items and start selecting matches in cmd completion
opt.wildignore =
	"blue.vim,darkblue.vim,delek.vim,desert.vim,evening.vim,elflord.vim,industry.vim,koehler.vim,morning.vim,murphy.vim,pablo.vim,peachpuff.vim,ron.vim,shine.vim,slate.vim,torte.vim,zellner.vim" -- ignore default colorschemes
opt.wrap = false -- Disable line wrapping

-- Indentation
opt.expandtab = true -- Use spaces instead of tabs
opt.shiftwidth = 2 -- Shift 2 spaces when tab
opt.smartindent = true -- Autoindent new lines
opt.tabstop = 2 -- 1 tab == 2 spaces

-- Memory & CPU Performance
opt.hidden = true -- Enable background buffers
opt.history = 100 -- Remember N lines in history
opt.lazyredraw = true -- Faster scrolling
opt.synmaxcol = 240 -- Max column for syntax highlight
opt.updatetime = 250 -- ms to wait for trigger an event

-- Startup
opt.shortmess:append("asI") -- Sane defaults

-- Disable builtins plugins
local disabled_built_ins = {
	-- "netrw", GBrowse uses this
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
	"gzip",
	"zip",
	"zipPlugin",
	"tar",
	"tarPlugin",
	"getscript",
	"getscriptPlugin",
	"vimball",
	"vimballPlugin",
	"2html_plugin",
	"logipat",
	"rrhelper",
	"spellfile_plugin",
	"matchit",
}

for _, plugin in pairs(disabled_built_ins) do
	g["loaded_" .. plugin] = 1
end

-- Remote
math.randomseed(os.time())
vim.fn.serverstart("/tmp/nvimsocket_" .. math.random(1, 10000))

-- Lang
g.ruby_indent_hanging_elements = 0

-- Autocommands
local BWBufferCleanup = vim.api.nvim_create_augroup("BWBufferCleanup", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	command = "%s/\\s\\+$//e",
	desc = "Trim trailing whitespace on save",
	group = BWBufferCleanup,
})
vim.api.nvim_create_autocmd("VimResized", {
	pattern = "*",
	command = "wincmd =",
	desc = "Automatically resize splits when resizing the window",
	group = BWBufferCleanup,
})

local BWAbbreviations = vim.api.nvim_create_augroup("BWAbbreviations", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	pattern = "javascript,javascriptreact",
	command = 'iabbrev <buffer> wiplog console.log("WIPLOG",)<left>',
	desc = "WIPLOG for js",
	group = BWAbbreviations,
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = "ruby",
	command = 'iabbrev <buffer> wiplog Rails.logger.debug "=" * 80<CR>Rails.logger.debug <CR>Rails.logger.debug "=" * 80<Up>',
	desc = "WIPLOG for ruby",
	group = BWAbbreviations,
})
vim.api.nvim_create_autocmd("FileType gitcommit", {
	command = "iabbrev <buffer> co Co-authored-by: SOMEONE <HANDLE@users.noreply.github.com>",
	desc = "Co-authored-by",
	group = BWAbbreviations,
})

-- Terminal
cmd([[command! Term :botright vsplit term://$SHELL]]) -- Open a terminal pane on the right using :Term

-- Terminal visual tweaks:
-- enter insert mode when switching to terminal
-- close terminal buffer on process exit
local BWTerminalTweaks = vim.api.nvim_create_augroup("BWTerminalTweaks", { clear = true })
vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "*",
	command = "setlocal listchars= nonumber norelativenumber nocursorline",
	desc = "Disable line numbers and cursorline",
	group = BWTerminalTweaks,
})
vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "*",
	command = "startinsert",
	desc = "Start terminal in Insert mode",
	group = BWTerminalTweaks,
})
vim.api.nvim_create_autocmd("BufLeave", {
	pattern = "term://*",
	command = "stopinsert",
	desc = "Stop Insert mode when leaving a terminal",
	group = BWTerminalTweaks,
})
