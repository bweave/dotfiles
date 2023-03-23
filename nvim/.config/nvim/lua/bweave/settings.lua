--
-- lua/bweave/settings.lua
--

local options = {
	backup = false, -- creates a backup file
	clipboard = "unnamedplus", -- allows neovim to access the system clipboard
	colorcolumn = "101", -- Line lenght marker at 100 columns
	completeopt = { "menuone", "noselect" }, -- mostly just for cmp
	conceallevel = 0, -- so that `` is visible in markdown files
	cursorline = true, -- highlight the current line
	expandtab = true, -- convert tabs to spaces
	fileencoding = "utf-8", -- the encoding written to a file
	history = 100, -- Remember N lines in history
	hlsearch = true, -- highlight all matches on previous search pattern
	ignorecase = true, -- ignore case in search patterns
	joinspaces = false, -- Don't add 2 spaces when joining lines
	laststatus = 3, -- show global statusline
	lazyredraw = true, -- Faster scrolling
	linebreak = true, -- Wrap on word boundary
	mouse = "a", -- allow the mouse to be used in neovim
	number = true, -- set numbered lines
	numberwidth = 4, -- set number column width to 2 {default 4}
	pumheight = 10, -- pop up menu height
	scrolloff = 8, -- minimal number of screen lines to keep above and below the cursor
	shiftwidth = 2, -- the number of spaces inserted for each indentation
	showmatch = true, -- Highlight matching parenthesis
	showmode = false, -- we don't need to see things like -- INSERT -- anymore
	showtabline = 2, -- always show the tabline
	sidescrolloff = 8, -- minimal number of screen columns either side of cursor if wrap is `false`
	signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
	smartcase = true, -- smart case
	smartindent = true, -- make indenting smarter again
	splitbelow = true, -- force all horizontal splits to go below current window
	splitright = true, -- force all vertical splits to go to the right of current window
	swapfile = false, -- creates a swapfile
	tabstop = 2, -- insert 2 spaces for a tab
	termguicolors = true, -- set term gui colors (most terminals support this)
	title = true, -- Allow setting the terminal title
	titlestring = vim.fn.fnamemodify(vim.fn.getcwd(), ":t"), -- Set the terminal title to the current directory
	timeoutlen = 300, -- time to wait for a mapped sequence to complete (in milliseconds)
	undofile = true, -- enable persistent undo
	updatetime = 300, -- faster completion (4000ms default)
	wrap = false, -- don't wrap lines
	writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

require("base16-colorscheme").with_config({ telescope = false })
vim.cmd("colorscheme base16-onedark")
