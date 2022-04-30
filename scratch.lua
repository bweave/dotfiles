local M = {}
local Job = require"plenary.job"
local fzf = require("fzf")
local helpers = require("fzf.helpers")

local function debug(msg)
  print(vim.inspect(msg))
end

local function handle_stash(action, stash)
  local job = Job:new({
    command = "git",
    args = { "stash", action, stash },
  })
  job:sync()

  return job:result()
end

M.stashes = function()
  coroutine.wrap(function()
    local cmd = "git stash list"
    local preview = helpers.choices_to_shell_cmd_previewer(function(items)
      local stash = string.gsub(items[1], ":.*", "")
      return "git show --patience --stat --pretty=oneline --color=always -p " .. vim.fn.shellescape(tostring(stash))
    end)

    cli_args = table.concat({
      '--bind="ctrl-f:preview-page-down"',
      '--bind="ctrl-b:preview-page-up"',
      '--bind="ctrl-k:preview-up"',
      '--bind="ctrl-j:preview-down"',
      '--expect=ctrl-a,ctrl-p,del',
      '--preview ' .. preview,
    }, " ")

    local result = fzf.fzf(cmd, cli_args)
    if result then
      if result[1] == "ctrl-a" then
        debug("Gonna apply stash: " .. result[2])
        handle_stash("apply", result[2])
      elseif result[1] == "ctrl-p" then
        debug("Gonna pop stash: " .. result[2])
        handle_stash("pop", result[2])
      elseif result[1] == "del" then
        debug("Gonna drop stash: " .. result[2])
        handle_stash("drop", result[2])
      else
        debug("Gonna handle stash: " .. result[1])
        handle_stash("apply", result[1])
      end
    end
  end)()
end
