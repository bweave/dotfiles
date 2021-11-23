paq {'vim-test/vim-test'}

vim.g['test#strategy'] = "neovim"
vim.g['test#preserve_screen'] = true
vim.g['test#neovim#term_position'] = "vert botright 80"
vim.g['test#vim#term_position'] = "vert botright 80"

map('n', '<leader>t', ':TestFile<CR>')
map('n', '<leader>T', ':TestNearest<CR>')
