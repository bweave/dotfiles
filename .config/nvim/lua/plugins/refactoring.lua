return {
  "ThePrimeagen/refactoring.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "lewis6991/async.nvim",
  },
  config = function()
    require("refactoring").setup({
      refactor = {
        extract_func = {
          code_generation = {
            -- upstream bug: Ruby template was copied from Python and kept the trailing `:` on def
            function_declaration = {
              ruby = function(opts)
                local name = opts.singleton and "self." .. opts.name or opts.name
                local arg_names = {}
                for _, v in ipairs(opts.args) do
                  table.insert(arg_names, v.identifier)
                end
                local args = table.concat(arg_names, ", ")
                local sig = #opts.args > 0
                  and ("def %s(%s)"):format(name, args)
                  or ("def %s"):format(name)
                return ("%s\n%s\nend"):format(sig, opts.body)
              end,
            },
          },
        },
      },
    })
  end,
  keys = {
    -- extract selection to a new function (operator: follow with motion or use in visual mode)
    { "<leader>re", function() return require("refactoring").extract_func() end, mode = { "n", "x" }, expr = true, desc = "Extract Function" },
    -- extract selection to a new variable
    { "<leader>rv", function() return require("refactoring").extract_var() end, mode = { "n", "x" }, expr = true, desc = "Extract Variable" },
    -- inline: replace variable with its value
    { "<leader>ri", function() return require("refactoring").inline_var() end, mode = { "n", "x" }, expr = true, desc = "Inline Variable" },
    -- inline: replace function call with body
    { "<leader>rI", function() return require("refactoring").inline_func() end, mode = { "n", "x" }, expr = true, desc = "Inline Function" },
    -- picker: choose from all available refactors for context
    { "<leader>rr", function() return require("refactoring").select_refactor() end, mode = { "n", "x" }, desc = "Refactor (select)" },
  },
}
