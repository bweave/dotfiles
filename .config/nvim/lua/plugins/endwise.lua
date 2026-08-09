return {
  "RRethy/nvim-treesitter-endwise",
  config = function()
    -- Upstream bug: vim.fn.searchpos returns {0,0} when no non-whitespace
    -- character exists before the cursor (empty buffer, cursor at top).
    -- Subtracting 1 produces row=-1/col=-1, which fails get_node's assert.
    -- Guard here until a fix lands upstream.
    local orig = vim.treesitter.get_node
    vim.treesitter.get_node = function(opts, ...)
      if opts and opts.pos and (opts.pos[1] < 0 or opts.pos[2] < 0) then
        return nil
      end
      return orig(opts, ...)
    end
  end,
}
