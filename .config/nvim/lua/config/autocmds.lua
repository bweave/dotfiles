-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Reset cursor style and color on exit so terminal/tmux isn't left with nvim's colorscheme cursor
vim.api.nvim_create_autocmd("VimLeave", {
  callback = function()
    io.write("\27]112\7") -- OSC 112: reset cursor color to terminal default
    io.write("\27[2 q") -- DECSCUSR: reset to block cursor
  end,
})

-- gitcommit buffers have no conform formatter configured, but LazyVim's global
-- formatexpr always routes through conform.formatexpr(), which reports success
-- even when no formatter ran. That silences Vim's fallback to its built-in
-- textwidth-based formatter, so `gq` does nothing on commit messages. Clear it
-- here so gq wraps at 'textwidth' as expected.
vim.api.nvim_create_autocmd("FileType", {
  pattern = "gitcommit",
  callback = function()
    vim.bo.formatexpr = ""
  end,
})

-- Ruby-specific refactoring keymaps (buffer-local; override any global <leader>re binding).
vim.api.nvim_create_autocmd("FileType", {
  pattern = "ruby",
  callback = function(ev)
    vim.keymap.set("x", "<leader>re", function()
      -- Capture extent while still in visual mode; '< and '> may not be updated yet.
      local anchor = vim.fn.getpos("v")
      local cursor = vim.fn.getpos(".")
      local start_line = math.min(anchor[2], cursor[2]) - 1  -- 0-indexed
      local end_line   = math.max(anchor[2], cursor[2]) - 1  -- 0-indexed
      require("ruby_refactor").extract_method(start_line, end_line)
    end, { buffer = ev.buf, desc = "Ruby: extract method" })

    vim.keymap.set("n", "<leader>rn", function()
      require("ruby_refactor").rename_local()
    end, { buffer = ev.buf, desc = "Ruby: rename local variable" })

    vim.keymap.set("n", "<leader>rg", function()
      require("ruby_refactor").guard_clause()
    end, { buffer = ev.buf, desc = "Ruby: if..else → guard clause" })
  end,
})
