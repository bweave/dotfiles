local output = vim.fn.system("defaults read -g AppleInterfaceStyle 2>/dev/null")
local is_dark_mode = string.match(output, "Dark")
if is_dark_mode then
	print("dark")
else
	print("light")
end
