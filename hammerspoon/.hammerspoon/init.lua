-- Modifier shortcuts
hyper = { "⌘", "⌥", "⌃", "⇧" }
meh = { "⌥", "⌃", "⇧" }

-- Animations are annoying
hs.window.animationDuration = 0

-- Always find the right app id
function appID(app)
	return hs.application.infoForBundlePath(app)["CFBundleIdentifier"]
end

-- Spoons
hs.loadSpoon("SpoonInstall")
spoon.SpoonInstall.use_syncinstall = true
Install = spoon.SpoonInstall

-- Auto reload config
Install:andUse("ReloadConfiguration", { start = true })

-- Unsplash wallpapers
-- Install:andUse("UnsplashZ")

-- Open URLs in specific apps
-- browser = appID('/Applications/Brave Browser.app')
browser = appID("/Applications/Safari.app")
spotify = appID("/Applications/Spotify.app")
-- trello = appID('/Applications/Trello.app')

Install:andUse("URLDispatcher", {
	config = {
		default_handler = browser,
		url_patterns = {
			{ "spotify:", spotify },
			-- { "trello:", trello },
		},
		url_redir_decoders = {
			{ "Spotify URLs", "https?://open.spotify.com/(.*)/(.*)", "spotify:%1:%2" },
			-- { "Trello URLs", "https?://(trello.com/.*)", "trello://%1" },
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

function moveToNextMonitor()
	cur_window = hs.window.focusedWindow()
	cur_window:moveToScreen(cur_window:screen():next(), true, true, 0)
end
hs.hotkey.bind(hyper, "n", moveToNextMonitor)

function centerOnScreen()
	cur_window = hs.window.focusedWindow()
	cur_window:centerOnScreen()
	cur_window:move({ 0, 10 }) -- account for our margin between windows
end
hs.hotkey.bind(hyper, "c", centerOnScreen)

hs.hotkey.bind(meh, "t", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()
	local rect_with_margins = {
		x = max.x + 10,
		y = max.y + 10,
		w = max.w - 20,
		h = max.h - 20,
	}

	hs.window.tiling.tileWindows(hs.window.allWindows(), rect_with_margins)
end)

-- App layouts
-- local mainScreen = hs.screen{x=0, y=0}
-- local sideScreen = hs.screen{x=-1, y=0}
-- local pcoLayout = {
--   {"Brave Browser", nil, mainScreen, {x=0, y=0, w=0.5, h=1}, nil, nil},
--   {"iTerm2", nil, mainScreen, {x=0.5, y=0, w=0.5, h=1}, nil, nil},
-- }
-- pcoLayout = {
--   {"Brave Browser", nil, mainScreen, {x=0,y=0,w=0.5,h=1}, nil, nil},
--   {"iTerm2", nil, mainScreen, {x=0.5,y=0,w=0.5,h=1}, nil, nil},
-- }

-- Application shortcuts
hs.hotkey.bind(hyper, "a", function()
	hs.application.launchOrFocus("Authy Desktop")
end)
hs.hotkey.bind(hyper, "b", function()
	hs.application.launchOrFocus("Brave Browser")
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
local function SpotifyVolUp()
	hs.spotify.volumeUp()
end
hs.hotkey.bind(meh, "k", SpotifyVolUp, nil, SpotifyVolUp)
local function SpotifyVolDown()
	hs.spotify.volumeDown()
end
hs.hotkey.bind(meh, "j", SpotifyVolDown, nil, SpotifyVolDown)