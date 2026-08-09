-- ruby_refactor/rename.lua
-- Rename a local variable/parameter within its enclosing method scope.

local M = {}

-- Walk a treesitter node tree, calling `fn(node)` for every node.
local function walk(node, fn)
  fn(node)
  for child in node:iter_children() do
    walk(child, fn)
  end
end

-- Find the enclosing `method` or `singleton_method` node for a given row.
local function find_enclosing_method(root, row, col)
  local node = root:named_descendant_for_range(row, col, row, col)
  while node do
    local t = node:type()
    if t == "method" or t == "singleton_method" then
      return node
    end
    node = node:parent()
  end
  return nil
end

-- Return the method's own name node id, to avoid renaming it.
local function method_name_id(method_node)
  local name_field = method_node:field("name")
  if name_field and #name_field > 0 then
    return name_field[1]:id()
  end
  return nil
end

-- Collect all identifier nodes within `method_node` whose text matches `target`.
-- Excludes the method name itself.
-- Returns a list of { sr, sc, er, ec } (all 0-indexed).
local function collect_occurrences(method_node, bufnr, target)
  local exclude_id = method_name_id(method_node)
  local occurrences = {}

  walk(method_node, function(node)
    if node:type() ~= "identifier" then
      return
    end
    if exclude_id and node:id() == exclude_id then
      return
    end
    local text = vim.treesitter.get_node_text(node, bufnr)
    if text == target then
      local sr, sc, er, ec = node:range()
      table.insert(occurrences, { sr = sr, sc = sc, er = er, ec = ec })
    end
  end)

  -- Sort bottom-to-top so edits don't shift positions of earlier occurrences.
  table.sort(occurrences, function(a, b)
    if a.sr ~= b.sr then
      return a.sr > b.sr
    end
    return a.sc > b.sc
  end)

  return occurrences
end

-- Public entry point — called from normal mode keymap.
function M.rename_local()
  local bufnr = vim.api.nvim_get_current_buf()

  -- Cursor position (nvim_win_get_cursor is 1-indexed; convert to 0-indexed).
  local cursor = vim.api.nvim_win_get_cursor(0)
  local row = cursor[1] - 1
  local col = cursor[2]

  -- Obtain treesitter parser.
  local ok, parser = pcall(vim.treesitter.get_parser, bufnr, "ruby")
  if not ok or not parser then
    vim.notify("No Ruby treesitter parser available", vim.log.levels.ERROR, { title = "ruby-refactor" })
    return
  end

  local tree = parser:parse()[1]
  if not tree then
    vim.notify("Could not parse buffer", vim.log.levels.ERROR, { title = "ruby-refactor" })
    return
  end

  local root = tree:root()

  -- Get node under cursor.
  local node = root:named_descendant_for_range(row, col, row, col)
  if not node or node:type() ~= "identifier" then
    vim.notify("Cursor is not on an identifier", vim.log.levels.WARN, { title = "ruby-refactor" })
    return
  end

  local target = vim.treesitter.get_node_text(node, bufnr)

  -- Find enclosing method.
  local method_node = find_enclosing_method(root, row, col)
  if not method_node then
    vim.notify("Cursor is not inside a method", vim.log.levels.WARN, { title = "ruby-refactor" })
    return
  end

  local occurrences = collect_occurrences(method_node, bufnr, target)
  if #occurrences == 0 then
    vim.notify("No occurrences of '" .. target .. "' found", vim.log.levels.WARN, { title = "ruby-refactor" })
    return
  end

  vim.ui.input({ prompt = "Rename '" .. target .. "' to: " }, function(new_name)
    if not new_name or new_name == "" then
      return
    end

    -- Apply edits bottom-to-top so row/col positions stay valid.
    for _, occ in ipairs(occurrences) do
      vim.api.nvim_buf_set_text(bufnr, occ.sr, occ.sc, occ.er, occ.ec, { new_name })
    end

    vim.notify(
      "Renamed " .. #occurrences .. " occurrence(s) of '" .. target .. "' → '" .. new_name .. "'",
      vim.log.levels.INFO,
      { title = "ruby-refactor" }
    )
  end)
end

return M
