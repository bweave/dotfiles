paq {'junegunn/fzf', run = vim.fn['fzf#install']}
paq {'junegunn/fzf.vim'}
paq {'vijaymarupudi/nvim-fzf'}

vim.g.fzf_layout = { down = '40%' }

vim.g.fzf_buffers_jump = 1
vim.g.preferred_searcher = 'rg'

map('n', '<c-p>', ':Files<cr>')
-- map('n', '<leader>b', ':Buffers<cr>')
-- map('n', '<leader>c', ':Commits<cr>')
