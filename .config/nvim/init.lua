-- Guard nil buf_state crash in vim.lsp._changetracking.send_changes
-- Race condition when LSP servers attach/detach from the same buffer.
-- The old patch silently dropped the change notification, causing LSP servers
-- to hold stale document content (ruby-lsp InvalidLocationError).
-- This version catches the crash AND forces a full document resync.
-- Safe to remove once fixed in a nightly build (current: v0.13.0-dev-167)
do
  local ct = require("vim.lsp._changetracking")
  local orig_send_changes = ct.send_changes

  ct.send_changes = function(bufnr, firstline, lastline, new_lastline)
    local ok, err = pcall(orig_send_changes, bufnr, firstline, lastline, new_lastline)
    if ok then
      return
    end

    -- Only handle the known buf_state race condition; re-raise everything else
    if type(err) ~= "string" or not err:find("buf_state") then
      error(err)
    end

    -- Force a full document resync so LSP servers don't end up with stale content
    vim.schedule(function()
      if not vim.api.nvim_buf_is_valid(bufnr) then
        return
      end
      local uri = vim.uri_from_bufnr(bufnr)
      local full_text = table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, -1, true), "\n") .. "\n"
      for _, client in pairs(vim.lsp.get_clients({ bufnr = bufnr })) do
        if not client:is_stopped() and vim.lsp.buf_is_attached(bufnr, client.id) then
          client:notify("textDocument/didChange", {
            textDocument = {
              uri = uri,
              version = require("vim.lsp.util").buf_versions[bufnr] or 0,
            },
            contentChanges = { { text = full_text } },
          })
        end
      end
    end)
  end
end

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
