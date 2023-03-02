--@diagnostic disable: undefined-global

local has_luasnip, _ = pcall(require, "luasnip")

if not has_luasnip then
	return
end

return {
	s(
		{
			trig = "wiplog",
			name = "WIPLOG",
			dscr = "Write to the built-in Rails logger",
		},
		fmt(
			[[
        Rails.logger.info "=" * 80
        Rails.logger.info "#{{self.class.name}}##{{__method__}}"
        Rails.logger.info {}
        Rails.logger.info "=" * 80
      ]],
			{ i(0, "data_to_log") }
		)
	),
	s(
		{
			trig = "class",
			name = "Class",
			dscr = "A Ruby Class",
		},
		fmt(
			[[
        class {}
          def initialize({})
            @{} = {}
          end{}

          private

          attr_reader :{}
        end
      ]],
			{ i(1, "MyClass"), i(2, "arg"), rep(2), rep(2), i(0), rep(2) }
		)
	),
	s(
		{
			trig = "def",
			name = "def",
			dscr = "A Ruby method",
		},
		fmt(
			[[
        def {}
          {}
        end
      ]],
			{ i(1, "method_name"), i(2, "some_code") }
		)
	),
	s(
		{
			trig = "do",
			name = "do_end",
			dscr = "A Ruby do..end block",
		},
		fmt(
			[[
        do
          {}
        end
      ]],
			{ i(1, "some_code") }
		)
	),
	s(
		{
			trig = "struct",
			name = "Struct",
			dscr = "A Ruby Struct",
		},
		fmt(
			[[
        {} = Struct.new({}){}
      ]],
			{ i(1, "MyStruct"), i(2, "arg"), i(0) }
		)
	),
}
