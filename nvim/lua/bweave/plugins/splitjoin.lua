paq {"AndrewRadev/splitjoin.vim"}

vim.g.splitjoin_split_mapping = ''
vim.g.splitjoin_join_mapping = ''
vim.g.splitjoin_trailing_comma = 1

map('n', '<leader>j', ':SplitjoinSplit<cr>')
map('n', '<leader>k', ':SplitjoinJoin<cr>')
