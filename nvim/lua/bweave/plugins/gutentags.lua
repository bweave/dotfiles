paq {'ludovicchabant/vim-gutentags'}

vim.g.gutentags_file_list_command = 'rg --files'
vim.g.gutentags_ctags_exclude = {
  '*.md', '*.markdown', '*.css', '*.scss', '*.html', '*.erb', '*.json', '*.xml',
  'yarn.lock', 'package.json', 'Gemfile.lock', 'Gemfile', 'Procfile', 'Guardfile', 'vendor/assets/*',
  'public', 'log', 'node_modules', 'tmp'
}
