--
-- init.lua
--

-- local opt = vim.opt
-- local isolated_path = vim.env.HOME .. "/src/nvim-from-scratch"

-- -- remove default config dirs from rtp so we can work with isolated configs
-- opt.runtimepath:remove(os.getenv("HOME") .. "/.config/nvim")
-- opt.runtimepath:remove(os.getenv("HOME") .. "/.local/share/nvim/site")
-- opt.runtimepath:remove(os.getenv("HOME") .. "/.local/share/nvim/site/after")
-- opt.runtimepath:remove(os.getenv("HOME") .. "/.config/nvim/after")

-- -- Setup require-ing from our isolated config dirs
-- opt.runtimepath:append(isolated_path .. "/lua")
-- opt.runtimepath:append(isolated_path .. "/after")
-- opt.runtimepath:append(isolated_path .. "/after/ftplugin")
-- package.path = table.concat({
-- 	isolated_path .. "/lua/?.lua;",
-- 	package.path,
-- })

require("plugins")
require("bweave")
