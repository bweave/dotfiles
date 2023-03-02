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
	s(
		{
			trig = "us",
			name = "useState",
			dscr = "React hooks useState()",
		},
		fmt(
			[[
        const [{}, set{}] = useState({}){}
      ]],
			{
				i(1, "state"),
				f(function(arg)
					return string.gsub(arg[1][1], "^%l", string.upper)
				end, { 1 }),
				i(2, "default_value"),
				i(0),
			}
		)
	),
	s(
		{
			trig = "ue",
			name = "useEffect",
			dscr = "React hooks useEffect()",
		},
		fmt(
			[[
        useEffect(() => {{
          {}
        }}, [{}])
      ]],
			{ i(1, "your_code"), i(0, "dependencies") }
		)
	),
}
