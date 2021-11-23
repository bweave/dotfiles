paq {'kyazdani42/nvim-tree.lua'}
paq {'kyazdani42/nvim-web-devicons'}

require 'nvim-tree'.setup{}

map('n', '<leader>E', ':NvimTreeToggle<CR>')
map('n', '<leader>r', ':NvimTreeRefresh<CR>')
map('n', '<leader>f', ':NvimTreeFindFile<CR>')
