-- ruby_refactor/extract.lua
-- Extract selected lines into a new Ruby method via treesitter analysis.

local M = {}

-- Return the shiftwidth for the current buffer.
local function shiftwidth()
  local sw = vim.bo.shiftwidth
  return (sw == 0) and vim.bo.tabstop or sw
end

-- Walk a treesitter node tree, calling `fn(node)` for every node.
local function walk(node, fn)
  fn(node)
  for child in node:iter_children() do
    walk(child, fn)
  end
end

-- Find the enclosing `method` or `singleton_method` node for a given row.
local function find_enclosing_method(root, row)
  local node = root:named_descendant_for_range(row, 0, row, 0)
  while node do
    local t = node:type()
    if t == "method" or t == "singleton_method" then
      return node
    end
    node = node:parent()
  end
  return nil
end

-- Determine the role of an identifier node within a method.
-- Returns: "skip" | "param" | "write" | "read"
local function identifier_role(node)
  local parent = node:parent()
  if not parent then
    return "read"
  end

  local pt = parent:type()

  -- Skip: this node is the method's own name.
  if pt == "method" or pt == "singleton_method" then
    local name_field = parent:field("name")
    if name_field and #name_field > 0 and name_field[1]:id() == node:id() then
      return "skip"
    end
  end

  -- Param: declared as a parameter.
  local param_parent_types = {
    method_parameters = true,
    block_parameters = true,
    lambda_parameters = true,
  }
  if param_parent_types[pt] then
    return "param"
  end

  local param_node_types = {
    optional_parameter = true,
    keyword_parameter = true,
    splat_parameter = true,
    hash_splat_parameter = true,
    block_parameter = true,
  }
  if param_node_types[pt] then
    local name_field = parent:field("name")
    if name_field and #name_field > 0 and name_field[1]:id() == node:id() then
      return "param"
    end
  end

  -- Write: left-hand side of assignment or for-loop pattern.
  if pt == "assignment" or pt == "operator_assignment" then
    local left_field = parent:field("left")
    if left_field and #left_field > 0 and left_field[1]:id() == node:id() then
      return "write"
    end
  end

  if pt == "left_assignment_list" then
    return "write"
  end

  if pt == "for" then
    local pattern_field = parent:field("pattern")
    if pattern_field and #pattern_field > 0 and pattern_field[1]:id() == node:id() then
      return "write"
    end
  end

  return "read"
end

-- Collect all identifier nodes within `method_node`, keyed by name.
-- Each entry: list of { name, role, row, col }
local function collect_identifiers(method_node, bufnr)
  local refs = {} -- name -> list of {role, row, col}
  walk(method_node, function(node)
    if node:type() ~= "identifier" then
      return
    end
    local role = identifier_role(node)
    if role == "skip" then
      return
    end
    local name = vim.treesitter.get_node_text(node, bufnr)
    local row, col = node:start()
    refs[name] = refs[name] or {}
    table.insert(refs[name], { role = role, row = row, col = col })
  end)
  return refs
end

-- Classify references by zone relative to selection.
-- Returns { params = [...], returns = [...] } (sorted lists of names).
local function classify_variables(refs, sel_start, sel_end)
  local declared_before = {}
  local read_in = {}
  local written_in = {}
  local read_after = {}

  for name, occurrences in pairs(refs) do
    for _, occ in ipairs(occurrences) do
      local role, row = occ.role, occ.row
      if role == "param" and row < sel_start then
        -- Only method-level params (on the def line, before the selection) count as
        -- declared-before. Block params declared inside or at the selection boundary
        -- are block-local and must not be passed as arguments to the extracted method.
        declared_before[name] = true
      elseif role == "write" and row < sel_start then
        declared_before[name] = true
      elseif row >= sel_start and row <= sel_end then
        if role == "read" then
          read_in[name] = true
        elseif role == "write" then
          written_in[name] = true
        end
      elseif row > sel_end then
        if role == "read" or role == "write" then
          read_after[name] = true
        end
      end
    end
  end

  -- params: variables read inside selection that were declared before it.
  local params = {}
  for name in pairs(read_in) do
    if declared_before[name] then
      table.insert(params, name)
    end
  end

  -- returns: variables written inside selection that are read after it.
  local returns = {}
  for name in pairs(written_in) do
    if read_after[name] then
      table.insert(returns, name)
    end
  end

  table.sort(params)
  table.sort(returns)
  return { params = params, returns = returns }
end

-- Return the minimum leading-space count across non-blank lines.
local function min_indent(lines)
  local min = math.huge
  for _, line in ipairs(lines) do
    if line:match("%S") then
      local spaces = #line:match("^(%s*)")
      if spaces < min then
        min = spaces
      end
    end
  end
  return min == math.huge and 0 or min
end

-- Build the extracted method text (list of lines, no trailing newline line).
local function build_method(name, params, returns, body_lines, method_indent, sw)
  local body_indent = method_indent .. string.rep(" ", sw)
  local lines = {}

  -- Signature
  local sig
  if #params > 0 then
    sig = method_indent .. "def " .. name .. "(" .. table.concat(params, ", ") .. ")"
  else
    sig = method_indent .. "def " .. name
  end
  table.insert(lines, "")
  table.insert(lines, sig)

  -- Dedent body lines (strip common leading whitespace, keep relative indentation).
  local dedent = min_indent(body_lines)
  local rebuilt = {}
  for _, line in ipairs(body_lines) do
    rebuilt[#rebuilt + 1] = line:match("%S") and line:sub(dedent + 1) or ""
  end

  -- When there is exactly one return value and the body assigns it, strip that
  -- assignment and rely on Ruby's implicit return. Handles three forms:
  --   single-line at start:  `x = expr`         → keep `expr` on that line
  --   multi-line at start:   `x =\n  if…\n  end` → drop `x =` line, re-dedent rest
  --   single-line at end:    `a=1\n x = expr`    → keep `expr` on last line
  local explicit_returns = returns
  if #returns == 1 then
    local pat = "^" .. vim.pesc(returns[1]) .. "%s*=%s*"
    local first_idx, last_idx
    for i, line in ipairs(rebuilt) do
      if line:match("%S") then
        if not first_idx then first_idx = i end
        last_idx = i
      end
    end
    if first_idx then
      local rhs = rebuilt[first_idx]:match(pat .. "(.-)%s*$")
      if rhs ~= nil then
        -- Assignment is the first statement in the body.
        explicit_returns = {}
        if rhs ~= "" then
          rebuilt[first_idx] = rhs                   -- single-line: keep rhs
        else
          -- Multi-line (`x =\n  expr...`): drop the `x =` line then re-dedent
          -- the expression that follows (which was indented relative to `x =`).
          table.remove(rebuilt, first_idx)
          local extra = min_indent(rebuilt)
          if extra > 0 then
            for i, line in ipairs(rebuilt) do
              rebuilt[i] = line ~= "" and line:sub(extra + 1) or ""
            end
          end
        end
      elseif last_idx ~= first_idx then
        -- Assignment is the last statement; check only for single-line form.
        local last_rhs = rebuilt[last_idx]:match(pat .. "(.+)$")
        if last_rhs then
          rebuilt[last_idx] = last_rhs
          explicit_returns = {}
        end
      end
    end
  end

  -- Re-indent and append body lines.
  for _, line in ipairs(rebuilt) do
    table.insert(lines, line ~= "" and (body_indent .. line) or "")
  end

  -- Explicit return statement (only when assignment-stripping did not apply).
  if #explicit_returns > 0 then
    table.insert(lines, "")
    table.insert(lines, body_indent .. table.concat(explicit_returns, ", "))
  end

  table.insert(lines, method_indent .. "end")

  return lines
end

-- Build the call-site replacement lines.
local function build_call(name, params, returns, call_indent)
  local call
  if #params > 0 then
    call = name .. "(" .. table.concat(params, ", ") .. ")"
  else
    call = name
  end

  if #returns > 0 then
    return { call_indent .. table.concat(returns, ", ") .. " = " .. call }
  else
    return { call_indent .. call }
  end
end

-- Public entry point — called from visual mode keymap with 0-indexed selection rows.
function M.extract_method(sel_start, sel_end)
  local bufnr = vim.api.nvim_get_current_buf()

  -- Obtain treesitter parser.
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

  -- Find enclosing method.
  local method_node = find_enclosing_method(root, sel_start)
  if not method_node then
    vim.notify("Selection is not inside a method", vim.log.levels.WARN, { title = "ruby-refactor" })
    return
  end

  -- Capture method end row BEFORE any edits.
  local method_start_row, _, method_end_row, _ = method_node:range()

  -- Detect method indentation from method's start line.
  local method_start_line = vim.api.nvim_buf_get_lines(bufnr, method_start_row, method_start_row + 1, false)[1] or ""
  local method_indent = method_start_line:match("^(%s*)") or ""

  -- Detect call-site indentation from first selected line.
  local sel_lines = vim.api.nvim_buf_get_lines(bufnr, sel_start, sel_end + 1, false)
  local call_indent = sel_lines[1] and (sel_lines[1]:match("^(%s*)") or "") or ""

  -- Variable analysis.
  local refs = collect_identifiers(method_node, bufnr)
  local vars = classify_variables(refs, sel_start, sel_end)
  local sw = shiftwidth()

  -- Prompt for the new method name, then apply edits in the callback.
  vim.ui.input({ prompt = "Method name: " }, function(name)
    if not name or name == "" then
      return
    end

    -- Build new method lines.
    local new_method_lines = build_method(name, vars.params, vars.returns, sel_lines, method_indent, sw)

    -- Build call-site lines.
    local call_lines = build_call(name, vars.params, vars.returns, call_indent)

    -- Edit 1: Insert new method AFTER enclosing method's end (doesn't shift selection rows).
    vim.api.nvim_buf_set_lines(bufnr, method_end_row + 1, method_end_row + 1, false, new_method_lines)

    -- Edit 2: Replace selection with call.
    vim.api.nvim_buf_set_lines(bufnr, sel_start, sel_end + 1, false, call_lines)
  end)
end

return M
