--------------------------------------------------------------------------
-- Treesitter
--------------------------------------------------------------------------

local status_ok, nvim_treesitter = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
  return
end

-- See: https://github.com/nvim-treesitter/nvim-treesitter#quickstart
nvim_treesitter.setup {
  ensure_installed = {
    'bash',
    'comment',
    'css',
    'dockerfile',
    'go',
    'html',
    'javascript',
    'jsdoc',
    'json',
    'lua',
    'markdown',
    'markdown_inline',
    'python',
    'query',
    'regex',
    'ruby',
    'rust',
    'scheme',
    'scss',
    'sql',
    'toml',
    'tsx',
    'typescript',
    'vim',
    'yaml',
  },
  autotag = { enable = true }, -- nvim-ts-autotag
  endwise = { enable = true }, -- nvim-treesitter-endwise
  highlight = { enable = true, additional_vim_regex_highlighting = false },
  incremental_selection = { enable = true },
  indent = { enable = false },
  matchup = { enable = true }, -- vim-matchup
  playground = { enable = true }, -- nvim-treesitter/playground
  query_linter = { enable = true }, -- nvim-treesitter/playground
}

-- nvim-autopairs - not a treesitter module but uses it
require('nvim-autopairs').setup({ check_ts = true, map_cr = true })
