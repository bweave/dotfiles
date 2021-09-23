local cmd = vim.cmd
local fn = vim.fn
local opt = vim.opt

opt.runtimepath:append("~/src/bweave-nvim") -- my dark theme built with Lush
opt.runtimepath:append("~/src/nord-light")  -- Nord light theme built with Lush

local darkTheme = 'bweave'
local lightTheme = 'nord-light'

function OsDarkModeTheme()
  if (fn.system("defaults read -g AppleInterfaceStyle"):find('^Dark' ) ~= nil) then
    cmd('colorscheme ' .. darkTheme)
    cmd 'set background=dark'
  else
    cmd('colorscheme ' .. lightTheme)
    cmd 'set background=light'
  end
end

if (fn.has('macunix') == 1) then
  print('dark')
  OsDarkModeTheme()
else
  print('light')
  cmd('colorscheme ' .. darkTheme)
  cmd 'set background=dark'
end
