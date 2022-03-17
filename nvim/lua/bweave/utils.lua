local M = {}

M.table_contains = function (table, value)
  for k, v in ipairs(table) do
    if v == value then
      return true
    end
  end

  return false
end

M.send_to_all_nvims = function(cmd)
  local nvims = vim.fn.systemlist("nvr --serverlist")
  for _, servername in pairs(nvims) do
    vim.fn.system("nvr --remote-send '" .. cmd .. "' --servername " .. servername)
  end
end

return M
