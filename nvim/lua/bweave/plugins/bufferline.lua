paq {'akinsho/bufferline.nvim'}

local bufferline = require 'bufferline'
bufferline.setup {
  options = {
    diagnostics = "nvim_lsp",
    --- count is an integer representing total count of errors
    ----- level is a string "error" | "warning"
    ----- diagnostics_dict is a dictionary from error level ("error", "warning" or "info")to number of errors for each level.
    ----- this should return a string
    ----- Don't get too fancy as this function will be executed a lot
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local icon = level:match("error") and " " or " "
      return " " .. icon .. count
    end,
    numbers = "ordinal",
    offsets = {
      {
        filetype = "NvimTree",
        text = "Files",
        text_align = "left",
      },
    },
  }
}

map('n', '<leader>1', '<Cmd>BufferLineGoToBuffer 1<CR>')
map('n', '<leader>2', '<Cmd>BufferLineGoToBuffer 2<CR>')
map('n', '<leader>3', '<Cmd>BufferLineGoToBuffer 3<CR>')
map('n', '<leader>4', '<Cmd>BufferLineGoToBuffer 4<CR>')
map('n', '<leader>5', '<Cmd>BufferLineGoToBuffer 5<CR>')
map('n', '<leader>6', '<Cmd>BufferLineGoToBuffer 6<CR>')
map('n', '<leader>7', '<Cmd>BufferLineGoToBuffer 7<CR>')
map('n', '<leader>8', '<Cmd>BufferLineGoToBuffer 8<CR>')
map('n', '<leader>9', '<Cmd>BufferLineGoToBuffer 9<CR>')
