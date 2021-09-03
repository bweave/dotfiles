-- Mappings

vim.g.mapleader = ' '

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- quick window switching
map('', '<c-j>', '<c-w>j')
map('', '<c-k>', '<c-w>k')
map('', '<c-l>', '<c-w>l')
map('', '<c-h>', '<c-w>h')

-- Quickly edit/reload the init.lua file
map('n', '<leader>ei', ':e ~/.config/nvim/init.lua<CR>')
map('n', '<leader>ri', ':so ~/.config/nvim/init.lua<CR>')

-- Quickly edit/reload the vimrc file
map('n', '<leader>ev', ':e ~/.vimrc<CR>')
map('n', '<leader>rv', ':so ~/.vimrc<CR>')

-- Toggle hlsearch with <leader>hs
map('n', '<leader>hs', ':set hlsearch! hlsearch?<CR>')

-- Esc to normal mode in terminal
map('t', '<leader><Esc>', '<C-\\><C-n>')

-- toggle paste mode
map('n', '<leader>p', ':set invpaste<CR>')

-- delete buffer
map('n', '<leader>w', ':bd<CR>')

-- keep visual selection after indenting
map('v', '<', '<gv')
map('v', '>', '>gv')


map('n', '<C-P>', ':FZF<cr>')
map('n', '<leader>b', ':Buffers<cr>')
map('n', '<leader>c', ':Commits<cr>')
map('n', '<leader>C', ':Colors<cr>')

map('n', '<leader>/', ':Commentary<CR>')
map('v', '<leader>/', ':Commentary<CR>')

map('n', '<leader>BD', ':BD<cr>')

map('n', '<leader>S', ':tab drop .vscode/scratchpad_local.md<CR>')
map('n', '<leader>O', ':vs ~/Desktop/Onboarding.md<CR>')

map('n', '<leader>gs', ':vertical Git<CR>')

map('n', '<leader>j', ':SplitjoinSplit<cr>')
map('n', '<leader>k', ':SplitjoinJoin<cr>')

map('n', '<leader>s', ':Ag <C-R><C-W><CR>')

map('n', '<leader>t', ':TestFile<CR>')
map('n', '<leader>T', ':TestNearest<CR>')

map('n', '<leader>E', ':NvimTreeToggle<CR>')
map('n', '<leader>r', ':NvimTreeRefresh<CR>')
map('n', '<leader>f', ':NvimTreeFindFile<CR>')

map('n', '<leader>1', '<Cmd>BufferLineGoToBuffer 1<CR>')
map('n', '<leader>2', '<Cmd>BufferLineGoToBuffer 2<CR>')
map('n', '<leader>3', '<Cmd>BufferLineGoToBuffer 3<CR>')
map('n', '<leader>4', '<Cmd>BufferLineGoToBuffer 4<CR>')
map('n', '<leader>5', '<Cmd>BufferLineGoToBuffer 5<CR>')
map('n', '<leader>6', '<Cmd>BufferLineGoToBuffer 6<CR>')
map('n', '<leader>7', '<Cmd>BufferLineGoToBuffer 7<CR>')
map('n', '<leader>8', '<Cmd>BufferLineGoToBuffer 8<CR>')
map('n', '<leader>9', '<Cmd>BufferLineGoToBuffer 9<CR>')

-- lsp
-- See `:help vim.lsp.*` for documentation on any of the below funcs
map("n", "<leader>F", "<cmd>lua vim.lsp.buf.formatting()<CR>")
map('n', '<A-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
map('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
map('n', '<leader>K', '<cmd>lua vim.lsp.buf.hover()<CR>')
map('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
map('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
map('n', '<leader>gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
map('n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
map('n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
map('n', '<leader>gn', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
map('n', '<leader>gp', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
map('n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>')
map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
map('n', '<leader>sl', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>')
-- map('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workleader_folder()<CR>')
-- map('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workleader_folders()))<CR>')
-- map('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workleader_folder()<CR>')
