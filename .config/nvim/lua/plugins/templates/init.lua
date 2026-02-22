local M = {}

local template_dir = vim.fn.expand("~/.config/nvim/templates")

-- Map directory names to filetypes
local filetype_map = {
  js = "javascript",
  ts = "typescript",
  py = "python",
  rb = "ruby",
  md = "markdown",
  -- Add more mappings as needed
}

local function get_available_templates(filter_filetype)
  local templates = {}
  local files = vim.fn.glob(template_dir .. "/**/*.tpl", false, true)

  for _, file in ipairs(files) do
    local relative_path = file:sub(#template_dir + 2) -- Remove template_dir + "/"
    local dir_name = vim.fn.fnamemodify(relative_path, ":h")
    local filename = vim.fn.fnamemodify(relative_path, ":t:r")

    -- Skip if file is directly in templates dir (no subdirectory)
    if dir_name == "." then
      goto continue
    end

    -- Map directory name to filetype
    local template_filetype = filetype_map[dir_name] or dir_name

    -- Filter by filetype if requested
    if filter_filetype and template_filetype ~= filter_filetype then
      goto continue
    end

    -- Use just the filename as the key for cleaner completion
    templates[filename] = {
      file = file,
      filetype = template_filetype,
      full_name = dir_name .. "/" .. filename
    }

    ::continue::
  end

  return templates
end

local function extract_template_variables(content_lines)
  local variables = {}
  local seen = {}

  for _, line in ipairs(content_lines) do
    for var_name in line:gmatch("{{_([%w_]+)_}}") do
      if not seen[var_name] and var_name ~= "cursor" and var_name ~= "date" and not var_name:match("^lua:") then
        seen[var_name] = true
        table.insert(variables, var_name)
      end
    end
  end

  return variables
end

local function parse_template_file(file_path)
  local lines = vim.fn.readfile(file_path)
  if #lines == 0 then
    return nil, {}, {}
  end

  local filetype_line = lines[1]
  local filetype = filetype_line:match("^;; (.+)$")

  local content_lines = {}
  for i = 2, #lines do
    table.insert(content_lines, lines[i])
  end

  local variables = extract_template_variables(content_lines)

  return filetype, content_lines, variables
end

local function replace_placeholders(lines, variable_values)
  local result = {}
  local cursor_pos = nil
  variable_values = variable_values or {}

  for line_num, line in ipairs(lines) do
    local new_line = line

    new_line = new_line:gsub("{{_date_}}", function()
      return os.date("%Y-%m-%d")
    end)

    new_line = new_line:gsub("{{_lua:(.-)_}}", function(code)
      local func, err = load("return " .. code)
      if func then
        local success, result = pcall(func)
        if success then
          return tostring(result)
        end
      end
      return "{{_lua:" .. code .. "_}}"
    end)

    -- Replace custom variables
    for var_name, var_value in pairs(variable_values) do
      local pattern = "{{_" .. var_name:gsub("([%(%)%.%+%-%*%?%[%]%^%$%%])", "%%%1") .. "_}}"
      new_line = new_line:gsub(pattern, var_value)
    end

    local cursor_match = new_line:find("{{_cursor_}}")
    if cursor_match then
      cursor_pos = { line_num, cursor_match - 1 }
      new_line = new_line:gsub("{{_cursor_}}", "")
    end

    table.insert(result, new_line)
  end

  return result, cursor_pos
end

local function apply_template(template_name, target_file, variable_values)
  local target_filetype = nil
  if target_file then
    -- Get filetype from target file extension
    target_filetype = vim.filetype.match({ filename = target_file })
  else
    -- Use current buffer's filetype
    target_filetype = vim.bo.filetype
  end

  local templates = get_available_templates(target_filetype)
  local template_data = templates[template_name]

  if not template_data then
    vim.notify('Template "' .. template_name .. '" not found', vim.log.levels.ERROR)
    return
  end

  local filetype, content_lines, variables = parse_template_file(template_data.file)
  if not filetype then
    vim.notify("Invalid template file: " .. template_data.file, vim.log.levels.ERROR)
    return
  end

  local processed_lines, cursor_pos = replace_placeholders(content_lines, variable_values)

  local start_line
  if target_file then
    local expanded_path = vim.fn.expand(target_file)
    vim.cmd("edit " .. vim.fn.fnameescape(expanded_path))
    start_line = 1
  else
    start_line = vim.api.nvim_win_get_cursor(0)[1]
  end

  local buf = vim.api.nvim_get_current_buf()
  if filetype then
    vim.bo[buf].filetype = filetype
  end

  if target_file then
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, processed_lines)
  else
    local current_line = start_line - 1
    vim.api.nvim_buf_set_lines(buf, current_line, current_line, false, processed_lines)
  end

  if cursor_pos then
    local final_line = start_line + cursor_pos[1] - 1
    local final_col = cursor_pos[2]
    vim.api.nvim_win_set_cursor(0, { final_line, final_col })
    vim.cmd("startinsert!")
  end
end

local function template_complete(arg_lead, cmd_line, cursor_pos)
  -- Parse the command line to extract all parts
  local full_line = cmd_line:sub(1, cursor_pos)
  local parts = vim.split(full_line, "%s+", { trimempty = true })

  -- Remove the command itself
  if parts[1] == "Template" then
    table.remove(parts, 1)
  end

  -- Determine target filetype
  local target_filetype = nil
  local template_arg_index = 1

  -- Check if first arg looks like a filename
  if #parts >= 1 and parts[1]:find("%.") then
    target_filetype = vim.filetype.match({ filename = parts[1] })
    template_arg_index = 2
  else
    target_filetype = vim.bo.filetype
  end

  local templates = get_available_templates(target_filetype)
  local completions = {}

  -- If we're completing the template name
  if #parts < template_arg_index or (#parts == template_arg_index and arg_lead ~= "") then
    for name, template_data in pairs(templates) do
      if name:sub(1, #arg_lead) == arg_lead then
        -- Get template variables
        local filetype, content_lines, variables = parse_template_file(template_data.file)

        if #variables > 0 then
          -- Show template with variable placeholders
          local var_placeholders = {}
          for _, var in ipairs(variables) do
            table.insert(var_placeholders, "<" .. var .. ">")
          end
          table.insert(completions, name .. " " .. table.concat(var_placeholders, " "))
        else
          table.insert(completions, name)
        end
      end
    end
  end

  return completions
end

function M.setup()
  vim.api.nvim_create_user_command("Template", function(opts)
    local args = opts.fargs

    if #args == 0 then
      vim.notify("Usage: Template [file] <template_name> [variables...]", vim.log.levels.ERROR)
      return
    end

    local target_file = nil
    local template_name = nil
    local variable_values = {}
    local start_index = 1

    -- Check if first argument is a filename
    if args[1]:find("%.") then
      target_file = args[1]
      start_index = 2
    end

    if #args < start_index then
      vim.notify("Template name required", vim.log.levels.ERROR)
      return
    end

    template_name = args[start_index]

    -- Get template to find its variables
    local target_filetype = nil
    if target_file then
      target_filetype = vim.filetype.match({ filename = target_file })
    else
      target_filetype = vim.bo.filetype
    end

    local templates = get_available_templates(target_filetype)
    local template_data = templates[template_name]

    if not template_data then
      vim.notify('Template "' .. template_name .. '" not found', vim.log.levels.ERROR)
      return
    end

    local filetype, content_lines, variables = parse_template_file(template_data.file)

    -- Map remaining arguments to variables
    for i, var_name in ipairs(variables) do
      local value_index = start_index + i
      if args[value_index] then
        variable_values[var_name] = args[value_index]
      end
    end

    apply_template(template_name, target_file, variable_values)
  end, {
    nargs = "+",
    complete = template_complete,
  })
end

M.apply_template = apply_template
M.get_available_templates = get_available_templates

return {
  name = "templates",
  dir = vim.fn.stdpath("config") .. "/lua/plugins/templates",
  config = function()
    M.setup()
  end,
}
