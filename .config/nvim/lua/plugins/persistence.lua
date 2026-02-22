return {
  "folke/persistence.nvim",
  opts = {},
  init = function()
    vim.api.nvim_create_autocmd("VimEnter", {
      group = vim.api.nvim_create_augroup("restore_session", { clear = true }),
      callback = function()
        if vim.fn.argc() == 0 and not vim.g.started_with_stdin then
          require("persistence").load({ last = true })
        end
      end,
      nested = true,
    })
  end,
}
