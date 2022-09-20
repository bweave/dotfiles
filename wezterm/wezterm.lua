local wezterm = require("wezterm")
local act = wezterm.action
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
		{ key = "d", mods = "CMD|SHIFT", action = act.SplitVertical },
		{ key = "d", mods = "CMD", action = act.SplitHorizontal },
		-- Panes
		{ key = "s", mods = "LEADER", action = act.PaneSelect },
		{ key = "S", mods = "LEADER", action = act.PaneSelect({ mode = "SwapWithActive" }) },
		-- Nav
		{ key = "]", mods = "CMD", action = act.ActivatePaneDirection("Next") },
		{ key = "[", mods = "CMD", action = act.ActivatePaneDirection("Prev") },
		{ key = "{", mods = "SHIFT|OPT", action = act.MoveTabRelative(-1) },
		{ key = "}", mods = "SHIFT|OPT", action = act.MoveTabRelative(1) },
		-- Resizing
		{ key = "h", mods = "CTRL|SHIFT|OPT", action = act.AdjustPaneSize({ "Left", 5 }) },
		{ key = "j", mods = "CTRL|SHIFT|OPT", action = act.AdjustPaneSize({ "Down", 5 }) },
		{ key = "k", mods = "CTRL|SHIFT|OPT", action = act.AdjustPaneSize({ "Up", 5 }) },
		{ key = "l", mods = "CTRL|SHIFT|OPT", action = act.AdjustPaneSize({ "Right", 5 }) },
		-- Clears the scrollback and viewport, and then sends CTRL-L to ask the
		-- shell to redraw its prompt
		{
			key = "k",
			mods = "CMD",
			action = act.Multiple({
				act.ClearScrollback("ScrollbackAndViewport"),
				act.SendKey({ key = "L", mods = "CTRL" }),
			}),
		},
		-- Windows
		-- { key = "`", mods = "CMD", action = act.SwitchWorkspaceRelative(1) },
		-- { key = "`", mods = "SHIFT|CMD", action = act.SwitchWorkspaceRelative(-1) },
	},
	leader = { key = "a", mods = "CTRL|SHIFT|OPT", timeout_milliseconds = 1000 },
	line_height = 1.3,
	window_frame = {
		font_size = 14.0,
	},
}
