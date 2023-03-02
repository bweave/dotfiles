--
-- /after/plugin/which-key.nvim
--

local wc = require("which-key")
wc.setup({
	window = {
		border = "single",
	},
})

wc.register({
	["<leader>"] = {
		a = { name = "[A]ppearance" },
		e = { name = "[E]dit" },
		g = { name = "[G]it" },
		l = { name = "[L]sp" },
		t = { name = "[T]esting" },
	},
})
