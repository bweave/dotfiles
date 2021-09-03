require('bweave.settings')
require 'bweave.plugins'
require 'bweave.plugin_settings'
require('bweave.mappings')
require('bweave.autocommands')
require('bweave.functions') -- TODO: not sure how to do this, yet

-- TODO: maybe move this to style.lua or functions.lua?
local darkTheme = 'bweave'
local lightTheme = 'nord-light'
function OsDarkModeTheme()
  if (vim.fn.system("defaults read -g AppleInterfaceStyle"):find('^Dark' ) ~= nil) then
    vim.cmd('colorscheme ' .. darkTheme)
    vim.cmd 'set background=dark'
  else
    vim.cmd('colorscheme ' .. lightTheme)
    vim.cmd 'set background=light'
  end
end

if (vim.fn.has('macunix') == 1) then
  print('dark')
  OsDarkModeTheme()
else
  print('light')
  vim.cmd('colorscheme ' .. darkTheme)
  vim.cmd 'set background=dark'
end
