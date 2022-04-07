-- Settings

local g = vim.g      -- a table to access global variables
local opt = vim.opt  -- to set options

-- Global settings
g.markdown_enable_spell_checking = false
g.markdown_fenced_languages = {
  'bash=sh',
  'css',
  'html',
  'javascript',
  'typescript=javascript',
  'json',
  'php',
  'python',
  'ruby',
  'sql',
  'vim',
  'yaml',
  'zsh=sh'
}
g.nobackup = true                                   -- disable backup
g.noswapfile = true                                 -- disable swap files
g.nowrap = true                                     -- disable soft wrap for lines
g.nowritebackup = true                              -- disable backup

-- Settings
opt.autoindent = true                               -- Enable autoindenting
opt.autoread = true                                 -- Auto read files when they change
opt.background = 'dark'                             -- Dark background
opt.backspace = {'indent', 'eol', 'start'}          -- make Backspace behave as expected
if jit.os == "Linux" then
  opt.clipboard = 'unnamed'                        -- use system clipboard; requires has('unnamedplus') to be 1
end
opt.colorcolumn = '121'                             -- display text width column
opt.completeopt = {'longest', 'menuone', 'preview'} -- better insert mode completions
opt.cursorline = true                               -- highlight current line
opt.encoding = 'UTF-8'                              -- Set encoding
opt.expandtab = true                                -- Use spaces instead of tabs
opt.hidden = true                                   -- Enable background buffers
opt.hlsearch = true                                 -- highlight search matches
opt.ignorecase = true                               -- searches are case insensitive...
opt.inccommand = 'nosplit'                          -- Shows the effects of a command incrementally, as you type
opt.incsearch = true                                -- incremental search highlight
opt.joinspaces = false                              -- No double spaces with join
opt.laststatus = 2                                  -- always display the status bar
opt.lazyredraw = true                               -- lazily redraw screen while executing macros, and other commands
opt.mouse = 'a'                                     -- Enable the mouse, cuz pairing
opt.number = true                                   -- Show line numbers
opt.relativenumber = true                           -- Relative line numbers
opt.scrolloff = 0                                   -- Lines of context
opt.shiftround = true                               -- Round indent
opt.shiftwidth = 2                                  -- Size of an indent
opt.showcmd = true                                  -- don't display incomplete commands
opt.showtabline = 2                                 -- always show the tabline
opt.sidescrolloff = 8                               -- Columns of context
opt.smartcase = true                                -- Do not ignore case with capitals
opt.smartindent = true                              -- Insert indents automatically
opt.softtabstop=2                                   -- Soft tab size
opt.splitbelow = true                               -- Put new windows below current
opt.splitright = true                               -- Put new windows right of current
opt.tabstop = 2                                     -- Number of spaces tabs count for
opt.termguicolors = true                            -- True color support
opt.timeout = true                                  -- time waited for key press(es) to complete...
opt.timeoutlen = 500                               --  ...makes for a faster key response
opt.ttyfast = true                                  -- more characters will be sent to the screen for redrawing
opt.wildmenu = true                                 -- better menu with completion in command mode
opt.wildmode = {'list', 'longest'}                  -- Command-line completion mode
opt.wrap = false                                    -- Disable line wrap
