local api = vim.api
local cmd = vim.cmd
local fzf = require("fzf").fzf
local M = {}

local function get_buffers()
  local buffers = {}
  for _, buf_handle in ipairs(api.nvim_list_bufs()) do
    -- TODO: skip non-regular buffers
    if api.nvim_buf_get_option(buf_handle, "buflisted") == 0 then
		elseif api.nvim_buf_get_option(buf_handle, "buftype") == "terminal" then
		elseif api.nvim_buf_get_option(buf_handle, "buftype") == "nofile" then
    else
      local name = vim.fn.bufname(buf_handle)
      table.insert(buffers, name)
    end
  end

  return buffers
end

-- M.delete_buffers = function()
  coroutine.wrap(function ()
    local chosen = fzf(get_buffers(), "--multi --bind ctrl-a:select-all+accept", { height = 20, width = 100 })

    if not chosen then
      return
    end

    for _, bufname in ipairs(chosen) do
      cmd("bd " .. bufname)
    end
  end)()
-- end

return M
