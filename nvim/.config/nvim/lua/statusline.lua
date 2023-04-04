local package = require("package-info")
-- local palette = vim.fn["gruvbox_material#get_palette"]("medium", "material", { [vim.type_idx] = vim.types.dictionary })

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "catppuccin",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {},
		-- diagnostics_color = {
		-- 	hint = { fg = palette["green"][1] },
		-- 	info = { fg = palette["blue"][1] },
		-- 	warn = { fg = palette["yellow"][1] },
		-- 	error = { fg = palette["red"][1] },
		-- },
		always_divide_middle = true,
		globalstatus = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = {
			"branch",
			"diff",
			"diagnostics",
		},
		lualine_c = {
			-- "filename",
			-- {
			-- 	"lsp_progress",
			-- 	spinner_symbols = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" },
			-- },
			-- {
			-- 	gps.get_location,
			-- 	cond = gps.is_available,
			-- },
			{
				package.get_status,
			},
		},
		lualine_x = {
			{
				require("noice").api.status.command.get,
				cond = require("noice").api.status.command.has,
				color = { fg = "#ff9e64" },
			},
			{
				require("noice").api.status.mode.get,
				cond = require("noice").api.status.mode.has,
				color = { fg = "#ff9e64" },
			},
			{
				require("noice").api.status.search.get,
				cond = require("noice").api.status.search.has,
				color = { fg = "#ff9e64" },
			},
			"encoding",
			"fileformat",
			"filetype",
		},
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},

	winbar = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {
			"filename",
			"aerial",
		},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},

	inactive_winbar = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {
			"filename",
			"aerial",
		},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	extensions = {
		"fugitive",
		"nvim-dap-ui",
		"nvim-tree",
		"quickfix",
		"toggleterm",
		"aerial",
	},
})
