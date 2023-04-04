require("catppuccin").setup({
	flavour = "mocha", -- mocha, macchiato, frappe, latte
	dim_inactive = {
		enabled = true,
		shade = "dark",
		percentage = 0.15,
	},
	integrations = {
		aerial = true,
		-- fidget = true,
		gitsigns = true,
		indent_blankline = {
			enabled = true,
			colored_indent_levels = true,
		},
		leap = true,
		markdown = true,
		neogit = true,
		neotest = true,
		noice = true,
		cmp = true,
		dap = {
			enabled = true,
			enable_ui = true, -- enable nvim-dap-ui
		},
		native_lsp = {
			enabled = true,
			virtual_text = {
				errors = { "italic" },
				hints = { "italic" },
				warnings = { "italic" },
				information = { "italic" },
			},
			underlines = {
				errors = { "underline" },
				hints = { "underline" },
				warnings = { "underline" },
				information = { "underline" },
			},
		},
		-- notify = true,
		semantic_tokens = true,
		nvimtree = true,
		treesitter = true,
		ts_rainbow = true,
		overseer = true,
		telescope = true,
		lsp_trouble = true,
		which_key = true,
	},
})
vim.api.nvim_command([[colorscheme catppuccin]])

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
