--
-- after/ftplugin/gitcommit.lua
--

local cmd = vim.cmd
cmd("iabbrev <buffer> co Co-authored-by: SOMEONE <HANDLE@users.noreply.github.com><Esc>^fSviw")
