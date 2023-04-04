require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
	},

	indent = {
		enable = true,
	},

	textobjects = {
		select = {
			enable = true,
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
				["aa"] = "@parameter.outer",
				["ia"] = "@parameter.inner",
				["is"] = "@statement.outer",
				["as"] = "@statement.outer",
			},
		},
	},

	rainbow = {
		enable = true,
		extended_mode = true,
	},

	context_commentstring = {
		enable = true,
	},

	autotag = {
		enable = true,
	},

	matchup = {
		enable = true,
	},
	endwise = {
		enable = true,
	},
})

-- vim: ts=2 sts=2 sw=2 et
