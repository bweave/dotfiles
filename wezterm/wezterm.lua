local wezterm = require("wezterm")
local colors, _ = wezterm.color.load_scheme(wezterm.home_dir .. "/.config/wezterm/base16.toml")

wezterm.on("update", function(window, _)
	local new_colors, _ = wezterm.color.load_scheme(wezterm.home_dir .. "/.config/wezterm/base16.toml")
	window:set_config_overrides({
		colors = new_colors,
	})
end)

return {
	colors = colors,
	font_size = 14.0,
	keys = {
		-- Splits
		{ key = "d", mods = "CMD|SHIFT", action = wezterm.action.SplitVertical },
		{ key = "d", mods = "CMD", action = wezterm.action.SplitHorizontal },
		-- Nav
		{ key = "]", mods = "CMD", action = wezterm.action.ActivatePaneDirection("Next") },
		{ key = "[", mods = "CMD", action = wezterm.action.ActivatePaneDirection("Prev") },
		-- Resizing
		{ key = "h", mods = "CTRL|SHIFT|OPT", action = wezterm.action.AdjustPaneSize({ "Left", 5 }) },
		{ key = "j", mods = "CTRL|SHIFT|OPT", action = wezterm.action.AdjustPaneSize({ "Down", 5 }) },
		{ key = "k", mods = "CTRL|SHIFT|OPT", action = wezterm.action.AdjustPaneSize({ "Up", 5 }) },
		{ key = "l", mods = "CTRL|SHIFT|OPT", action = wezterm.action.AdjustPaneSize({ "Right", 5 }) },
		-- Clears the scrollback and viewport, and then sends CTRL-L to ask the
		-- shell to redraw its prompt
		{
			key = "k",
			mods = "CMD",
			action = wezterm.action.Multiple({
				wezterm.action.ClearScrollback("ScrollbackAndViewport"),
				wezterm.action.SendKey({ key = "L", mods = "CTRL" }),
			}),
		},
	},
	line_height = 1.3,
	window_frame = {
		font_size = 14.0,
	},
}
