-- Seeing is Believing
-- gem install seeing_is_believing
local function without_changing_cursor(fn)
  local cursor_position = vim.fn.getpos(".")
  local wintop_position = vim.fn.getpos("w0")
  local original_lazyredraw = vim.o.lazyredraw
  local original_scrolloff  = vim.o.scrolloff
  vim.o.lazyredraw = true
  fn()
  vim.fn.setpos('.', wintop_position)
  vim.fn.setpos('.', cursor_position)
  vim.api.nvim_exec([[redraw]], false)
  vim.o.lazyredraw = original_lazyredraw
  vim.o.scrolloff = original_scrolloff
end

function sib_annotate_all()
  local fn = function()
    vim.cmd("% !seeing_is_believing --timeout 12 --line-length 500 --number-of-captures 300 --alignment-strategy chunk")
  end
  without_changing_cursor(fn)
end

function sib_annotate_marked()
  local fn = function()
    vim.cmd("% !seeing_is_believing --xmpfilter-style --timeout 12 --line-length 500 --number-of-captures 300 --alignment-strategy chunk")
  end
  without_changing_cursor(fn)
end

local function sib_clear_annotations()
  local fn = function()
    vim.cmd("% !seeing_is_believing --clean")
  end
  without_changing_cursor(fn)
end

function sib_toggle_mark()
  local position = vim.fn.getpos('.')
  local line = vim.fn.getline(".")
  if string.match(line, "^%s*$") then
    line = '# => '
  elseif string.match(line, "# =>") then
    line = string.gsub(line, " *# =>.*", "")
  else
    line = line .. "  # => "
  end
  vim.fn.setline('.', line)
  vim.fn.setpos('.', position)
end
