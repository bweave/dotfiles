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
local asana = appID("/Applications/Asana.app")
local browser = appID("/Applications/Google Chrome.app")
local notion = appID("/Applications/Notion.app")
local spotify = appID("/Applications/Spotify.app")

Install:andUse("URLDispatcher", {
  config = {
    default_handler = browser,
    url_patterns = {
      { "asanadesktop:", asana },
      { "notion:", notion },
      { "spotify:", spotify },
    },
    url_redir_decoders = {
      { "Asana URLs", "https://app.asana.com/(.*)", "asanadesktop:///app/%1" },
      { "Notion URLs", "https://(www.notion.so/.*)", "notion://%1" },
      { "Spotify URLs", "https://open.spotify.com/(.*)/(.*)", "spotify:%1:%2" },
    },
  },
  start = true,
  loglevel = "debug",
})
