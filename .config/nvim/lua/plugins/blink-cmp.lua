-- Completion: manual trigger only (no auto-popup)
-- LazyVim v8+ uses blink.cmp as the default completion engine
return {
  "saghen/blink.cmp",
  opts = {
    completion = {
      -- Only show completions when manually triggered (Tab or <C-Space>)
      trigger = {
        show_on_keyword = false,
        show_on_trigger_character = false,
        show_on_insert_on_trigger_character = false,
      },
    },
    keymap = {
      ["<Tab>"] = { "select_next", "snippet_forward", "show", "fallback" },
      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
  },
}
