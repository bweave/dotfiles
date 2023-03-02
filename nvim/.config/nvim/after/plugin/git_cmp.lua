local utils = require("bweave.utils")
local gh = require("bweave.gh_cli")

local Source = {}

Source.new = function(opts)
	opts.cache = {}
	local self = setmetatable(opts, { __index = Source })
	return self
end

Source.complete = function(self, _, callback)
	local bufnr = vim.api.nvim_get_current_buf()

	if not self.cache[bufnr] then
		local items = self.build_items()
		callback({ items = items, isIncomplete = false })
		self.cache[bufnr] = items
	else
		callback({ items = self.cache[bufnr], isIncomplete = false })
	end
end

Source.get_trigger_characters = function(self)
	return self.trigger_characters
end

Source.is_available = function()
	return vim.bo.filetype == "gitcommit"
	-- return true
end

local function build_mentions()
	local mentions = {}
	local users = gh.planningcenter_members_with_teams() or {}
	for _, user in pairs(users) do
		local teams = table.concat(user.teams, ", ")
		local docs = user.login .. "\n**" .. teams .. "**"
		if utils.present(user.name) then
			docs = "# " .. user.name .. "\n\n" .. docs
		end

		table.insert(mentions, {
			filterText = user.login .. " " .. user.name .. " " .. teams,
			label = user.login,
			documentation = {
				kind = "markdown",
				value = docs,
			},
		})
	end

	return mentions
end

local gh_mentions = Source.new({ build_items = build_mentions, trigger_characters = { "@" } })
require("cmp").register_source("gh_mentions", gh_mentions)
