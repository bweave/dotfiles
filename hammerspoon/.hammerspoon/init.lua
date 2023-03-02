-- Modifier shortcuts
local hyper = { "⌘", "⌥", "⌃", "⇧" }
local meh = { "⌥", "⌃", "⇧" }

-- Animations are annoying
hs.window.animationDuration = 0

-- Always find the right app id
local function appID(app)
	return hs.application.infoForBundlePath(app)["CFBundleIdentifier"]
end

-- Spoons
hs.loadSpoon("SpoonInstall")
spoon.SpoonInstall.use_syncinstall = true
Install = spoon.SpoonInstall

-- Auto reload config
Install:andUse("ReloadConfiguration", { start = true })

-- Open URLs in specific apps
local browser = appID("/Applications/Google Chrome.app")
local spotify = appID("/Applications/Spotify.app")
-- local asana = appID("/Applications/Asana.app")

Install:andUse("URLDispatcher", {
	config = {
		default_handler = browser,
		url_patterns = {
			{ "spotify:", spotify },
			-- { "asana:", asana },
		},
		url_redir_decoders = {
			{ "Spotify URLs", "https://open.spotify.com/(.*)/(.*)", "spotify:%1:%2" },
			-- { "Asana URLs", "https://app.asana.com/0/%d+/(.*)", "asana://0/0/%1" },
		},
	},
	start = true,
	loglevel = "debug",
})

-- Window Management
Install:andUse("MiroWindowsManager", {
	hotkeys = {
		left = { hyper, "h" },
		down = { hyper, "j" },
		up = { hyper, "k" },
		right = { hyper, "l" },
		fullscreen = { hyper, "f" },
	},
})

-- A little margin around/between things is nice
hs.grid.setMargins({ x = 10, y = 10 })

local function moveToNextMonitor()
	local cur_window = hs.window.focusedWindow()
	cur_window:moveToScreen(cur_window:screen():next(), true, true, 0)
end
hs.hotkey.bind(hyper, "n", moveToNextMonitor)

local function centerOnScreen()
	local cur_window = hs.window.focusedWindow()
	cur_window:centerOnScreen()
	cur_window:move({ 0, 10 }) -- account for our margin between windows
end
hs.hotkey.bind(hyper, "c", centerOnScreen)

-- Application shortcuts
hs.hotkey.bind(hyper, "a", function()
	hs.application.launchOrFocus("Authy Desktop")
end)
hs.hotkey.bind(hyper, "b", function()
	hs.application.launchOrFocus("Google Chrome")
end)
hs.hotkey.bind(hyper, "1", function()
	hs.application.launchOrFocus("1Password 7")
end)
hs.hotkey.bind(hyper, "i", function()
	hs.application.launchOrFocus("Spotify")
end)
hs.hotkey.bind(hyper, "m", function()
	hs.application.launchOrFocus("Messages")
end)
hs.hotkey.bind(hyper, "o", function()
	hs.application.launchOrFocus("OBS")
end)
hs.hotkey.bind(hyper, "p", function()
	hs.application.launchOrFocus("Paw")
end)
hs.hotkey.bind(hyper, "q", function()
	hs.application.launchOrFocus("Tableplus")
end)
hs.hotkey.bind(hyper, "s", function()
	hs.application.launchOrFocus("Slack")
end)
hs.hotkey.bind(hyper, "t", function()
	hs.application.launchOrFocus("iterm")
end)
hs.hotkey.bind(hyper, "v", function()
	hs.application.launchOrFocus("Visual Studio Code")
end)
hs.hotkey.bind(hyper, "z", function()
	hs.application.launchOrFocus("zoom.us")
end)

-- Spotify
hs.hotkey.bind(meh, "k", function()
	hs.spotify.volumeUp()
end)
hs.hotkey.bind(meh, "j", function()
	hs.spotify.volumeDown()
end)
