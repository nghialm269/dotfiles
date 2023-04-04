local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local l = require("luasnip.extras").lambda
local r = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.expand_conditions")

-- Every unspecified option will be set to the default.
ls.config.set_config({
	history = true,
	-- Update more often, :h events for more info.
	updateevents = "TextChanged,TextChangedI",
	delete_check_events = "TextChanged,InsertLeave",
	store_selection_keys = "<Tab>",
	ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = { { "● <C-u> to select, <C-l>/<C-h> to cycle", "Orange" } },
			},
		},
		[types.insertNode] = {
			active = {
				virt_text = { { "●", "Blue" } },
			},
			passive = {
				hl_group = "Green",
			},
		},
	},
	-- treesitter-hl has 100, use something higher (default is 200).
	ext_base_prio = 300,
	-- minimal increase in priority.
	ext_prio_increase = 1,
	enable_autosnippets = true,
})

local upperFirst = function(str)
	return str:gsub("^%l", string.upper)
end

local toCamel = function(str)
	return str:gsub("_(.)", string.upper)
end

local toPascal = function(str)
	return upperFirst(toCamel(str))
end

ls.snippets = {
	dart = {
		s({
			trig = "class",
			name = "Class",
			dscr = "Creates class which shares the name of the file",
		}, {
			t("class "),
			d(1, function(args, snip)
				local base = snip.env.TM_FILENAME_BASE
				return sn(
					nil,
					c(1, {
						i(nil, toPascal(base)),
						i(nil),
						i(nil, toCamel(base)),
						i(nil, base),
					})
				)
			end, {}),
			t(" "),
			c(2, {
				t("{"),
				sn(nil, {
					t("implements "),
					i(1),
					t(" {"),
				}),
				sn(nil, {
					t("extends "),
					i(1),
					t(" {"),
				}),
				sn(nil, {
					t("with "),
					i(1),
					t(" {"),
				}),
			}),
			t({ "", "\t" }),
			i(0),
			t({ "", "}" }),
		}),
	},
}

-- autotriggered snippets have to be defined in a separate table, luasnip.autosnippets.
ls.autosnippets = {
	all = {
		s("autotrigger", {
			t("autosnippet"),
		}),
	},
}

-- autotriggered snippets have to be defined in a separate table, luasnip.autosnippets.
ls.autosnippets = {}

-- in a cpp file: search cpp-, then c-, then all-snippets.
ls.filetype_extend("cpp", { "c" })

local vscodeLoader = require("luasnip/loaders/from_vscode")
-- vscodeLoader.load({
-- 	paths = vim.fn.globpath("~/.vscode/extensions", "*", 0, 1),
-- })
-- vscodeLoader.load({
-- 	paths = vim.fn.globpath("/opt/visual-studio-code/resources/app/extensions", "*", 0, 1),
-- })
vscodeLoader.lazy_load()
