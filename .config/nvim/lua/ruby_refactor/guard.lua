-- ruby_refactor/guard.lua
-- Convert an if..else block into guard clause form.

local M = {}

local function find_if_node(root, row, col)
  local node = root:named_descendant_for_range(row, col, row, col)
  while node do
    if node:type() == "if" then
      return node
    end
    node = node:parent()
  end
  return nil
end

local function min_indent(lines)
  local min = math.huge
  for _, line in ipairs(lines) do
    if line:match("%S") then
      local spaces = #line:match("^(%s*)")
      if spaces < min then min = spaces end
    end
  end
  return min == math.huge and 0 or min
end

local function dedent(lines)
  local amount = min_indent(lines)
  if amount == 0 then return lines end
  local result = {}
  for _, line in ipairs(lines) do
    result[#result + 1] = line:match("%S") and line:sub(amount + 1) or ""
  end
  return result
end

local function strip_trailing_blank(lines)
  local i = #lines
  while i > 0 and not lines[i]:match("%S") do
    i = i - 1
  end
  local result = {}
  for j = 1, i do result[j] = lines[j] end
  return result
end

local function non_blank_count(lines)
  local n = 0
  for _, line in ipairs(lines) do
    if line:match("%S") then n = n + 1 end
  end
  return n
end

function M.guard_clause()
  local bufnr = vim.api.nvim_get_current_buf()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local row = cursor[1] - 1
  local col = cursor[2]

  local ok, parser = pcall(vim.treesitter.get_parser, bufnr, "ruby")
  if not ok or not parser then
    vim.notify("No Ruby treesitter parser available", vim.log.levels.ERROR, { title = "ruby-refactor" })
    return
  end

  parser:invalidate(true)
  local tree = parser:parse()[1]
  if not tree then
    vim.notify("Could not parse buffer", vim.log.levels.ERROR, { title = "ruby-refactor" })
    return
  end

  local root = tree:root()

  local if_node = find_if_node(root, row, col)
  if not if_node then
    vim.notify("No `if` statement at cursor", vim.log.levels.WARN, { title = "ruby-refactor" })
    return
  end

  -- Reject elsif — ambiguous which branch becomes the guard.
  local else_node = nil
  for child in if_node:iter_children() do
    local t = child:type()
    if t == "elsif" then
      vim.notify("`elsif` branches are not supported", vim.log.levels.WARN, { title = "ruby-refactor" })
      return
    elseif t == "else" then
      else_node = child
    end
  end

  if not else_node then
    vim.notify("No `else` branch found", vim.log.levels.WARN, { title = "ruby-refactor" })
    return
  end

  local if_start_row, _, if_end_row, _ = if_node:range()
  local else_row = else_node:start()  -- 0-indexed row of `else` keyword

  -- Condition text via treesitter.
  local cond_nodes = if_node:field("condition")
  if not cond_nodes or #cond_nodes == 0 then
    vim.notify("Could not find condition", vim.log.levels.ERROR, { title = "ruby-refactor" })
    return
  end
  local cond_node = cond_nodes[1]
  local condition_text = vim.treesitter.get_node_text(cond_node, bufnr)

  -- Body starts on the line after the condition ends (handles multi-line conditions).
  local _, _, cond_end_row, _ = cond_node:range()
  local body_start_row = cond_end_row + 1

  local if_line = vim.api.nvim_buf_get_lines(bufnr, if_start_row, if_start_row + 1, false)[1] or ""
  local indent = if_line:match("^(%s*)") or ""

  -- If-body: rows from after-condition to before-else.
  local if_body = strip_trailing_blank(
    vim.api.nvim_buf_get_lines(bufnr, body_start_row, else_row, false)
  )
  -- Else-body: rows from after-else to before-end.
  local else_body = strip_trailing_blank(
    dedent(vim.api.nvim_buf_get_lines(bufnr, else_row + 1, if_end_row, false))
  )

  local result = {}

  local nb = non_blank_count(if_body)
  local condition_multiline = condition_text:find("\n") ~= nil

  if nb == 1 and not condition_multiline then
    -- Single expression in if-body → postfix guard: `return expr if condition`
    local expr
    for _, line in ipairs(if_body) do
      if line:match("%S") then
        expr = line:match("^%s*(.-)%s*$")
        break
      end
    end
    result[#result + 1] = indent .. "return " .. expr .. " if " .. condition_text
    result[#result + 1] = ""
    for _, line in ipairs(else_body) do
      result[#result + 1] = line ~= "" and (indent .. line) or ""
    end
  else
    -- Multi-line if-body → keep block, add `return` to last expression.
    local last_idx
    for i, line in ipairs(if_body) do
      if line:match("%S") then last_idx = i end
    end
    result[#result + 1] = indent .. "if " .. condition_text
    for i, line in ipairs(if_body) do
      if i == last_idx and not line:match("^%s*return%s") then
        local line_indent = line:match("^(%s*)")
        local expr = line:match("^%s*(.-)%s*$")
        result[#result + 1] = line_indent .. "return " .. expr
      else
        result[#result + 1] = line
      end
    end
    result[#result + 1] = indent .. "end"
    result[#result + 1] = ""
    for _, line in ipairs(else_body) do
      result[#result + 1] = line ~= "" and (indent .. line) or ""
    end
  end

  vim.api.nvim_buf_set_lines(bufnr, if_start_row, if_end_row + 1, false, result)
end

return M
