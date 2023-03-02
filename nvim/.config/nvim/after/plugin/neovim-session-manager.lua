--
-- after/plugin/neovim-session-manager.lua
--

local ok, session_manager = pcall(require, "session_manager")
if not ok then
  return
end

local config = require("session_manager.config")

session_manager.setup({
  autoload_mode = config.AutoloadMode.CurrentDir,
})
