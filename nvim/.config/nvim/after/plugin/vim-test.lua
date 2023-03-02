--
-- after/plugin/vim-test.lua
--

local g = vim.g

g["test#strategy"] = "neovim"
g["test#preserve_screen"] = true
g["test#neovim#term_position"] = "vert botright 80"
g["test#vim#term_position"] = "vert botright 80"
