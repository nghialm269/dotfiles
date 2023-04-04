local M = {}

---Convert string to table of characters
---@param s string
---@return table
M.string2table = function(s)
	local t = {}
	s:gsub(".", function(c)
		table.insert(t, c)
	end)

	return t
end

return M
