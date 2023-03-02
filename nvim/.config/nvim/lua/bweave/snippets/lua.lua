--@diagnostic disable: undefined-global

local has_luasnip, _ = pcall(require, "luasnip")

if not has_luasnip then
	return
end

return {
	s({
		trig = "wiplog",
		name = "WIPLOG",
		dscr = "Write to :messages",
	}, fmt("vim.pretty_print('WIPLOG: {}')", { i(0, "data_to_log") })),
}
