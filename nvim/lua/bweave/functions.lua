-- Functions

local fn = vim.fn

vim.fn.synGroup = function()
  local s = fn.synID(fn.line('.'), fn.col('.'), 1)
  print(fn.synIDattr(s, 'name') .. ' -> ' .. fn.synIDattr(fn.synIDtrans(s), 'name'))
end
