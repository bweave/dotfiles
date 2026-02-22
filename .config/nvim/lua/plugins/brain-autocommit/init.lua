-- Auto-commit and push for brain repository
-- Automatically commits and pushes changes on save with intelligent grouping

local M = {}

function M.setup()
  local brain_path = vim.fn.expand("~/brain")
  local main_branch = "main"

  -- State management
  local S = {
    is_pulling = false,
    is_pushing = false,
  }

  -- Helper: Check if current file is in brain repo
  local function is_brain_file(filepath)
    local expanded = vim.fn.expand(filepath)
    return string.find(expanded, brain_path, 1, true) == 1
  end

  -- Helper: Get relative path from brain root
  local function get_relative_path(filepath)
    local expanded = vim.fn.expand(filepath)
    return expanded:gsub(brain_path .. "/", "")
  end

  -- Helper: Get directory grouping for smart commits
  local function get_commit_context(filepath)
    local rel_path = get_relative_path(filepath)
    local parts = vim.split(rel_path, "/")

    -- If in a subdirectory, use that as context
    if #parts > 1 then
      return parts[1]
    end

    -- If at root, use filename without extension
    local filename = parts[1]
    return filename:match("(.+)%..+$") or filename
  end

  -- Helper: Generate commit message
  local function generate_commit_message(filepath)
    local timestamp = os.date("%Y-%m-%d %H:%M:%S")
    local context = get_commit_context(filepath)
    local rel_path = get_relative_path(filepath)

    -- Title: timestamp with context (lowercase)
    local title = string.format("update %s @ %s", context, timestamp)

    -- Body: what changed
    local body = string.format("Changes to `%s`\n\nAuto-committed on save from Neovim.", rel_path)

    return title .. "\n\n" .. body
  end

  -- Git pull with conflict detection
  local function git_pull()
    if S.is_pulling then
      return
    end

    S.is_pulling = true

    vim.fn.jobstart({ "git", "-C", brain_path, "pull", "origin", main_branch }, {
      cwd = brain_path,
      on_exit = function(_, exit_code)
        S.is_pulling = false

        if exit_code == 0 then
          vim.notify("Brain: Pulled latest changes", vim.log.levels.INFO)
        else
          vim.notify("Brain: Pull failed - you may have conflicts", vim.log.levels.WARN)
        end
      end,
      on_stdout = function(_, data)
        if data then
          for _, line in ipairs(data) do
            if line:match("CONFLICT") or line:match("Merge conflict") then
              vim.notify("Brain: MERGE CONFLICT detected! Please resolve manually.", vim.log.levels.ERROR)
              S.is_pulling = false
            end
          end
        end
      end,
    })
  end

  -- Git commit and push
  local function git_commit_and_push(filepath)
    if S.is_pushing then
      return
    end

    -- Check if there are actually changes to commit
    vim.fn.jobstart({ "git", "-C", brain_path, "status", "--porcelain" }, {
      cwd = brain_path,
      stdout_buffered = true,
      on_stdout = function(_, data)
        if not data or #data == 0 or (data[1] == "" and #data == 1) then
          -- No changes to commit
          return
        end

        S.is_pushing = true

        local commit_msg = generate_commit_message(filepath)

        -- Stage all changes (git add -A)
        vim.fn.jobstart({ "git", "-C", brain_path, "add", "-A" }, {
          cwd = brain_path,
          on_exit = function(_, add_exit_code)
            if add_exit_code ~= 0 then
              vim.notify("Brain: Failed to stage changes", vim.log.levels.ERROR)
              S.is_pushing = false
              return
            end

            -- Commit with generated message
            vim.fn.jobstart({ "git", "-C", brain_path, "commit", "-m", commit_msg }, {
              cwd = brain_path,
              on_exit = function(_, commit_exit_code)
                if commit_exit_code ~= 0 then
                  vim.notify("Brain: Commit failed", vim.log.levels.ERROR)
                  S.is_pushing = false
                  return
                end

                -- Push to remote
                vim.fn.jobstart({ "git", "-C", brain_path, "push", "origin", main_branch }, {
                  cwd = brain_path,
                  on_exit = function(_, push_exit_code)
                    S.is_pushing = false

                    if push_exit_code == 0 then
                      vim.notify("Brain: Committed and pushed ✓", vim.log.levels.INFO)
                    else
                      vim.notify("Brain: Push failed - check git status", vim.log.levels.ERROR)
                    end
                  end,
                })
              end,
            })
          end,
        })
      end,
    })
  end

  -- Setup autocommands
  local augroup = vim.api.nvim_create_augroup("BrainAutocommit", { clear = true })

  -- Pull before reading
  vim.api.nvim_create_autocmd("BufReadPre", {
    group = augroup,
    callback = function(ev)
      if is_brain_file(ev.file) then
        git_pull()
      end
    end,
  })

  -- Commit and push after writing
  vim.api.nvim_create_autocmd("BufWritePost", {
    group = augroup,
    callback = function(ev)
      if is_brain_file(ev.file) then
        git_commit_and_push(ev.file)
      end
    end,
  })
end

return {
  name = "brain-autocommit",
  dir = vim.fn.stdpath("config") .. "/lua/plugins/brain-autocommit",
  config = function()
    M.setup()
  end,
}
