_G.n = {}
local utils = require("n.utils")

---Create a global mapping
---@param mode string|table[string]
---@param lhs string|table[string]
---@param rhs string|function
---@param opts nil|table|string
function n.map(mode, lhs, rhs, opts)
	n.bufmap(nil, mode, lhs, rhs, opts)
end

---Create a buffer-local mapping
---@param bufnr nil|number
---@param mode string|table[string]
---@param lhs string|table[string]
---@param rhs string|function
---@param opts nil|table|string
function n.bufmap(bufnr, mode, lhs, rhs, opts)
	local default_opts = { buffer = bufnr, silent = true }

	mode = type(mode) == "string" and utils.string2table(mode) or mode

	lhs = type(lhs) == "string" and { lhs } or lhs

	opts = type(opts) == "string" and { desc = opts } or opts
	opts = opts or {}

	for _, v in ipairs(lhs) do
		vim.keymap.set(mode, v, rhs, vim.tbl_extend("keep", opts, default_opts))
	end
end
