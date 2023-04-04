local augend = require("dial.augend")

require("dial.config").augends:register_group({
	default = {
		augend.integer.alias.decimal,
		augend.integer.alias.hex,
		augend.date.alias["%Y/%m/%d"],
		augend.date.alias["%Y-%m-%d"],
	},
	-- https://github.com/RobertAudi/.dotfiles/blob/0b7af82066f09a72f2dcddc6026dda14a008250a/vim/.config/nvim/lua/0x2a/plugins/dial/init.lua
	switch = {
		augend.case.new({
			types = { "camelCase", "snake_case", "kebab-case", "PascalCase", "SCREAMING_SNAKE_CASE" },
			cyclic = true,
		}),
		augend.constant.new({ elements = { "true", "false" }, word = true, cyclic = true }),
		augend.constant.new({ elements = { "TRUE", "FALSE" }, word = true, cyclic = true }),
		augend.constant.new({ elements = { "and", "or" }, word = true, cyclic = true }),
		augend.constant.new({ elements = { "AND", "OR" }, word = true, cyclic = true }),
		augend.constant.new({ elements = { "yes", "no" }, word = true, cyclic = true }),
		augend.constant.new({ elements = { "YES", "NO" }, word = true, cyclic = true }),
		augend.constant.new({ elements = { "show", "hide" }, word = true, cyclic = true }),
		augend.constant.new({ elements = { "minimum", "maximum" }, word = false, cyclic = true }),
		augend.constant.new({ elements = { "min", "max" }, word = false, cyclic = true }),
		augend.constant.new({ elements = { "asc", "desc" }, word = true, cyclic = true }),
		augend.constant.new({ elements = { "ASC", "DESC" }, word = true, cyclic = true }),
		augend.constant.new({ elements = { "ascending", "descending" }, word = true, cyclic = true }),
		augend.constant.new({ elements = { "horizontal", "vertical" }, word = true, cyclic = true }),
		augend.constant.new({ elements = { "&&", "||" }, word = false, cyclic = true }),
		augend.constant.new({ elements = { "!=", "==" }, word = false, cyclic = true }),
		augend.constant.new({ elements = { "!==", "===" }, word = false, cyclic = true }),
	},
})

local dial_map = require("dial.map")

n.map("n", "<C-a>", dial_map.inc_normal(), "Add")
n.map("n", "<C-x>", dial_map.dec_normal(), "Subtract")
n.map("v", "<C-a>", dial_map.inc_visual(), "Add")
n.map("v", "<C-x>", dial_map.dec_visual(), "Subtract")
n.map("v", "g<C-a>", dial_map.inc_gvisual(), "Add - creating incrementing sequence")
n.map("v", "g<C-x>", dial_map.dec_gvisual(), "Subtract - creating decrementing sequence")
n.map("v", "g<C-x>", dial_map.dec_gvisual(), "Subtract - creating decrementing sequence")
n.map("n", "-", dial_map.inc_normal("switch"), "Switch")
n.map("n", "_", dial_map.dec_normal("switch"), "Switch (back)")
