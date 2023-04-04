local telescope = require("telescope")
local themes = require("telescope.themes")
local builtin = require("telescope.builtin")

local augroup_flutter_commands = vim.api.nvim_create_augroup("FlutterCommands", {})
vim.api.nvim_create_autocmd("FileType", {
	group = augroup_flutter_commands,
	pattern = { "dart" },
	callback = telescope.extensions.flutter.commands,
})

vim.api.nvim_create_autocmd("User", {
	pattern = "TelescopePreviewerLoaded",
	callback = function()
		vim.opt_local.wrap = true
	end,
})

n.map("n", "<leader>ff", builtin.find_files, "Files")
n.map("n", "<leader>fg", builtin.live_grep, "Live grep")
n.map("n", "<leader>fw", builtin.grep_string, "Find word")

telescope.setup({
	defaults = {
		layout_strategy = "flex",
		mappings = {
			i = {
				["<C-w>"] = function()
					vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-S-w>", true, true, true), "m", true)
				end,
			},
		},
	},
	pickers = {
		lsp_code_actions = {
			theme = "cursor",
		},
	},
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},

		lsp_handlers = {
			disable = {
				["textDocument/codeAction"] = true,
			},
			code_action = {
				telescope = themes.get_cursor({}),
			},
		},
	},
})

telescope.load_extension("fzf")
telescope.load_extension("flutter")
telescope.load_extension("lsp_handlers")
telescope.load_extension("refactoring")

-- vim: ts=2 sts=2 sw=2 et
