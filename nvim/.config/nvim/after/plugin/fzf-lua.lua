--
-- after/plugin/fzf-lua.lua
--

local fzf_ok, fzf = pcall(require, "fzf-lua")
if not fzf_ok then
	print("!! fzf couldn't be required !!")
	return
end

fzf.setup()
