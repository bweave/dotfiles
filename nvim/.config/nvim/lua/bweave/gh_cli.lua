-- ---------------------------------------------------------
-- bweave/gh_cli.lua
-- NOTE: most of this is a curated copy/pasta from octo.nvim
-- ---------------------------------------------------------

local function pp(stuff)
	vim.pretty_print(stuff)
end

local utils = require("bweave.utils")
local job_ok, Job = pcall(require, "plenary.job")
if not job_ok then
	return
end

local M = { cache = {}, queries = {} }

M.queries.org_teams_with_members = [[
query ($endCursor: String) {
  organization(login: "%s") {
    teams(first: 100, after: $endCursor) {
      nodes {
        name
        members {
          nodes {
            name
            login
            email
          }
        }
      }
    }
  }
}
]]

function M.planningcenter_members_with_teams()
	local bufnr = vim.api.nvim_get_current_buf()

	if M.cache[bufnr] then
		return M.cache[bufnr]
	else
		local users = {}
		local query = M.graphql("org_teams_with_members", "planningcenter")
		local output, stderr = M.gh({
			args = {
				"api",
				"graphql",
				"--paginate",
				"-f",
				string.format("query=%s", query),
			},
			mode = "sync",
		})

		if utils.present(stderr) then
			utils.error(stderr)
			return
		end

		local responses = M.get_pages(output)
		if utils.present(responses.errors) then
			utils.error(responses.errors)
			return
		end

		for _, resp in ipairs(responses) do
			for _, team in ipairs(resp.data.organization.teams.nodes) do
				for _, user_data in ipairs(team.members.nodes) do
					local user = users[user_data.login]
					if user then
						table.insert(user.teams, team.name)
					else
						users[user_data.login] = {
							email = utils.present(user_data.email) and user_data.email or "",
							login = "@" .. user_data.login,
							name = utils.present(user_data.name) and user_data.name or "",
							teams = { team.name },
						}
					end
				end
			end
		end

		M.cache[bufnr] = users
		return users
	end
end

function M.graphql(query, ...)
	local opts = { escape = true }
	for _, v in ipairs({ ... }) do
		if type(v) == "table" then
			opts = vim.tbl_deep_extend("force", opts, v)
			break
		end
	end
	local escaped = {}
	for _, v in ipairs({ ... }) do
		if type(v) == "string" and opts.escape then
			local encoded = M.escape_char(v)
			table.insert(escaped, encoded)
		else
			table.insert(escaped, v)
		end
	end
	return string.format(M.queries[query], unpack(escaped))
end

function M.gh(opts)
	opts = opts or {}
	local mode = opts.mode or "async"
	if opts.args[1] == "api" then
		table.insert(opts.args, "-H")
		table.insert(opts.args, "Accept: " .. table.concat(M.headers, ";"))
	end
	if opts.headers then
		for _, header in ipairs(opts.headers) do
			table.insert(opts.args, "-H")
			table.insert(opts.args, header)
		end
	end
	local job = Job:new({
		enable_recording = true,
		command = "gh",
		args = opts.args,
		on_exit = vim.schedule_wrap(function(j_self, _, _)
			if mode == "async" and opts.cb then
				local output = table.concat(j_self:result(), "\n")
				local stderr = table.concat(j_self:stderr_result(), "\n")
				opts.cb(output, stderr)
			end
		end),
		env = M.env_vars,
	})
	if mode == "sync" then
		job:sync()
		return table.concat(job:result(), "\n"), table.concat(job:stderr_result(), "\n")
	else
		job:start()
	end
end

M.env_vars = {
	PATH = vim.env["PATH"],
	GH_CONFIG_DIR = vim.env["GH_CONFIG_DIR"],
	GITHUB_TOKEN = vim.env["GITHUB_TOKEN"],
	XDG_CONFIG_HOME = vim.env["XDG_CONFIG_HOME"],
	XDG_DATA_HOME = vim.env["XDG_DATA_HOME"],
	XDG_STATE_HOME = vim.env["XDG_STATE_HOME"],
	AppData = vim.env["AppData"],
	LocalAppData = vim.env["LocalAppData"],
	HOME = vim.env["HOME"],
	NO_COLOR = 1,
	http_proxy = vim.env["http_proxy"],
	https_proxy = vim.env["https_proxy"],
}

M.headers = {
	"application/vnd.github.v3+json",
	"application/vnd.github.squirrel-girl-preview+json",
	"application/vnd.github.comfort-fade-preview+json",
	"application/vnd.github.bane-preview+json",
}

function M.escape_char(string)
	local escaped, _ = string.gsub(string, '["\\]', {
		['"'] = '\\"',
		["\\"] = "\\\\",
	})
	return escaped
end

---Helper method to aggregate an API paginated response
function M.get_pages(text)
	local results = {}
	local page_outputs = vim.split(text, "\n")
	for _, page in ipairs(page_outputs) do
		local decoded_page = vim.fn.json_decode(page)
		table.insert(results, decoded_page)
	end
	return results
end

return M
