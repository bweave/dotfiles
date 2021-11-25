paq {'nvim-lua/plenary.nvim'}
paq {'lewis6991/gitsigns.nvim'}

require('gitsigns').setup {
  keymaps = {
    -- Default keymap options
    noremap = true,

    ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'"},
    ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'"},

    ['n <leader>sh'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
    ['v <leader>sh'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    ['n <leader>uh'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
    ['n <leader>rh'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
    ['v <leader>rh'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    ['n <leader>Rh'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
    ['n <leader>ph'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
    ['n <leader>gb'] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',
    ['n <leader>Sh'] = '<cmd>lua require"gitsigns".stage_buffer()<CR>',
    ['n <leader>Uh'] = '<cmd>lua require"gitsigns".reset_buffer_index()<CR>',

    -- Text objects
    ['o ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
    ['x ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>'
  },
}
