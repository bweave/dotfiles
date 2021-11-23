-- Mappings
vim.g.mapleader = ' '

map = function(mode, lhs, rhs, opts)
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
map('n', '<leader>ep', ':e ~/.config/nvim/lua/bweave/plugins.lua<CR>')
map('n', '<leader>eps', ':e ~/.config/nvim/lua/bweave/plugin_settings.lua<CR>')
map('n', '<leader>em', ':e ~/.config/nvim/lua/bweave/mappings.lua<CR>')

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

-- search
map('n', '<leader>s', ':Ag <C-R><C-W><CR>')

-- keep visual selection after indenting
map('v', '<', '<gv')
map('v', '>', '>gv')

-- misc
map('n', '<leader>C', ':lua require("bweave.functions.colors").colors()<CR>')
map('n', '<leader>BD', ':lua require("bweave.functions.delete_buffers").delete_buffers()<CR>')
map('n', '<leader>S', ':tab drop .vscode/scratchpad_local.md<CR>')
map('n', '<leader>O', ':vs ~/Desktop/Onboarding.md<CR>')
