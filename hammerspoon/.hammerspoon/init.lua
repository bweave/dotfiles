-- Modifier shortcuts
local hyper = { "⌘", "⌥", "⌃", "⇧" }
local meh = { "⌥", "⌃", "⇧" }

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

Install:andUse("URLDispatcher", {
	config = {
		default_handler = browser,
		url_patterns = {
			{ "spotify:", spotify },
		},
		url_redir_decoders = {
			{ "Spotify URLs", "https://open.spotify.com/(.*)/(.*)", "spotify:%1:%2" },
		},
	},
	start = true,
	-- loglevel = "debug",
})
