paq {'junegunn/fzf', run = vim.fn['fzf#install']}
paq {'junegunn/fzf.vim'}

vim.g.fzf_layout = {
  up = '~90%',
  window = {
    width = 0.8,
    height = 0.8,
    xoffset = 0.5,
    yoffset = 0.5,
  }
}
vim.g.fzf_preview_window = ''
vim.g.fzf_buffers_jump = 1
vim.g.preferred_searcher = 'ag'

map('n', '<C-P>', ':FZF<cr>')
map('n', '<leader>b', ':Buffers<cr>')
map('n', '<leader>c', ':Commits<cr>')
