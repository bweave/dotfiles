paq {'w0rp/ale'}

vim.g.ale_fix_on_save = 1
vim.g.ale_ruby_rubocop_executable = 'bundle'
vim.g.ale_ruby_ruby_executable = '~/.rbenv/shims/ruby'
vim.g.ale_linters = {
   ruby = {'rubocop', 'solargraph'},
   javascript = {'eslint'},
   javascriptreact = {'eslint'},
   css = {'eslint'},
   sql = {'sqlint'},
   mysql = {'sqlint'},
}
vim.g.ale_fixers = {
   ruby = {'rubocop'},
   javascript = {'eslint'},
   javascriptreact = {'eslint'},
   css = {'eslint'},
}
