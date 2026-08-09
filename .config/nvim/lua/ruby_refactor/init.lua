-- ruby_refactor/init.lua
-- Public API for Ruby-specific refactoring operations.

local M = {}

--- Extract visually selected lines into a new method.
--- sel_start/sel_end are 0-indexed row numbers captured before mode transition.
function M.extract_method(sel_start, sel_end)
  require("ruby_refactor.extract").extract_method(sel_start, sel_end)
end

--- Rename the local variable/parameter under the cursor within its method scope.
--- Call from a normal-mode keymap; prompts for the new name.
function M.rename_local()
  require("ruby_refactor.rename").rename_local()
end

--- Convert the if..else block at cursor into guard clause form.
function M.guard_clause()
  require("ruby_refactor.guard").guard_clause()
end

return M
