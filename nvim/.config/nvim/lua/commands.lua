local create_cmd = vim.api.nvim_create_user_command

create_cmd("Branches", "lua require('fzf-git').branches()", {})
create_cmd("Stashes", "lua require('fzf-git').stashes()", {})
create_cmd(
  "GutentagsClearCache",
  function()
    vim.fn.system("rm " .. vim.g.gutentags_cache_dir .. "/*")
  end,
  {}
)
create_cmd("HashRocket", '<line1>,<line2>:norm ^csw"f:r a=>', { range = true })
create_cmd("HashColon", '<line1>,<line2>:norm ^ds"f xxr:', { range = true })

local fzf = require("fzf").fzf
local helpers = require("fzf.helpers")

-- coroutine.wrap(function()
--   local buffers = {}
--
--   local buffer_handles = vim.api.nvim_list_bufs()
--   for _, handle in pairs(buffer_handles) do
--     if vim.api.nvim_buf_is_loaded(handle) then
--       local buffer_name = vim.api.nvim_buf_get_name(handle)
--       table.insert(buffers, buffer_name)
--     end
--   end
--
--   local preview = helpers.choices_to_shell_cmd_previewer(function(items)
--     local current_buffer = items[1]
--     return "bat --style=numbers --color=always --pager=never -- " .. vim.fn.shellescape(current_buffer)
--   end)
--
--   local result = fzf(buffers, "--preview=" .. preview .. " --preview-window right:50% --multi")
--   if result then
--     vim.cmd("bdelete " .. table.concat(result, " "))
--   end
-- end)()

-- create_cmd(
--   "FzfBufDelete",
--   function()
--     buffer_numbers = vim.api.nvim_list_bufs()
--   end,
--   {}
-- )
