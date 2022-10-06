local M = {}
local Job = require("plenary.job")
local fzf = require("fzf")
local helpers = require("fzf.helpers")

local function debug(msg)
  print(vim.inspect(msg))
end

local function handle_result(args)
  Job:new({
    command = "git",
    args = args,
    on_exit = function(j, return_val)
      -- debug(return_val)
      -- debug(j:result())
    end,
  }):start()
end

M.stashes = function()
  coroutine.wrap(function()
    local cmd = "git stash list"
    local preview = helpers.choices_to_shell_cmd_previewer(function(items)
      local stash = string.gsub(items[1], ":.*", "")
      return "git show --patience --stat --pretty=oneline --color=always -p " .. vim.fn.shellescape(tostring(stash))
    end)
    local cli_args = table.concat({
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
        handle_result({ "stash", "apply", result[2] })
      elseif result[1] == "ctrl-p" then
        handle_result({ "stash", "pop", result[2] })
      elseif result[1] == "del" then
        handle_result({ "stash", "drop", result[2] })
      else
        handle_result({ "stash", "apply", result[1] })
      end
    end
  end)()
end

M.branches = function()
  coroutine.wrap(function()
    local cmd = "git branch"
    -- TODO: handle not being in a git repo
    local current_branch = vim.b.gitsigns_status_dict.head
    local preview = helpers.choices_to_shell_cmd_previewer(function(items)
      local other_branch = string.gsub(items[1], "[%s*]+", "")
      return "git diff --color=always " .. current_branch .. ".." .. other_branch
    end)
    local cli_args = table.concat({
      '--bind="ctrl-f:preview-page-down"',
      '--bind="ctrl-b:preview-page-up"',
      '--bind="ctrl-k:preview-up"',
      '--bind="ctrl-j:preview-down"',
      '--preview ' .. preview,
    }, " ")
    local result = fzf.fzf(cmd, cli_args)

    if result then
      local branch = string.gsub(result[1], "%s+", "")
      handle_result({ "checkout", branch })
    end
  end)()
end

return M
