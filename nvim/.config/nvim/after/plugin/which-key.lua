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
		l = {
			name = "[L]sp",
			e = { name = "[E]rrors" },
      F = { name = "[F]inders" },
			g = { name = "[G]o to" },
		},
		r = { name = "[R]uby & [R]ails" },
		t = { name = "[T]esting" },
		T = {
			name = "[T]erminal",
			r = { name = "[R]epl" },
		},
		W = {
			name = "[W]indow",
			t = { name = "[W]indow [T]ab" },
		},
	},
})
