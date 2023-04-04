return require("packer").startup({
	function(use)
		use("wbthomason/packer.nvim")

		use("lewis6991/impatient.nvim")

		-- Fix neovim CursorHold: https://github.com/neovim/neovim/issues/12587
		-- use("antoinemadec/FixCursorHold.nvim")

		use({
			"folke/which-key.nvim",
			config = function()
				local wk = require("which-key")
				wk.setup({})
				wk.register({
					["<leader>"] = {
						d = {
							name = "+diagnostics",
						},
						g = {
							name = "+git",
						},
						f = {
							name = "+finder",
						},
						l = {
							name = "+leap",
						},
					},
					["<localleader>"] = {
						l = {
							name = "+lsp",
						},
						t = {
							name = "+test",
						},
						d = {
							name = "+dap",
						},
					},
				}, { mode = "n" })
			end,
		})

		use({
			"ggandor/leap.nvim",
			config = function()
				require("leap").set_default_keymaps()
				-- n.map({ "n", "x", "o" }, "<leader>ls", "<Plug>(leap-forward-to)")
				-- n.map({ "n", "x", "o" }, "<leader>lS", "<Plug>(leap-backward-to)")
				-- n.map({ "n", "x", "o" }, "<leader>lx", "<Plug>(leap-forward-till)")
				-- n.map({ "n", "x", "o" }, "<leader>lX", "<Plug>(leap-backward-till)")
				-- n.map({ "n", "x", "o" }, "<leader>lw", "<Plug>(leap-cross-window)")
			end,
		})

		use({
			"gbprod/substitute.nvim",
			config = function()
				local s = require("substitute")

				s.setup({
					-- range = {
					-- 	prefix = "S",
					-- },
				})
				-- Lua
				local opts = { noremap = true }

				n.map("n", "<leader>s", s.operator, opts)
				n.map("n", "<leader>ss", s.line, opts)
				n.map("n", "<leader>S", s.eol, opts)
				n.map("x", "<leader>s", s.visual, opts)

				local sx = require("substitute.exchange")
				n.map("n", "<leader>sx", sx.operator, opts)
				n.map("n", "<leader>sxx", sx.line, opts)
				n.map("x", "X", sx.visual, opts)
				n.map("n", "<leader>sxc", sx.cancel, opts)
			end,
		})

		--------------------------------
		-- UI {{{1
		--------------------------------
		-- use({
		-- 	"sainnhe/gruvbox-material",
		-- 	config = function()
		-- 		require("gruvbox-material")
		-- 	end,
		-- })

		use({
			"catppuccin/nvim",
			as = "catppuccin",
			config = function()
				require("plugin-config/catppuccin")
			end,
		})

		-- dim inactive windows
		-- catppuccin already have this
		-- use({
		-- 	"levouh/tint.nvim",
		-- 	config = function()
		-- 		require("tint").setup({
		-- 			tint = -15,
		-- 		})
		-- 	end,
		-- })

		use({
			"folke/noice.nvim",
			requires = {
				"MunifTanjim/nui.nvim",
			},
			config = function()
				require("plugin-config/noice")
			end,
		})
		--
		-- auto resize windows when active
		use({
			"anuvyklack/windows.nvim",
			requires = {
				"anuvyklack/middleclass",
				"anuvyklack/animation.nvim",
			},
			config = function()
				vim.o.winwidth = 10
				vim.o.winminwidth = 10
				require("windows").setup({
					ignore = { --			  |windows.ignore|
						buftype = { "quickfix" },
						filetype = { "NvimTree", "neo-tree", "undotree", "gundo", "aerial" },
					},
					animation = {
						duration = 100,
					},
				})
			end,
		})

		-- use character for colorcolumn
		use({
			"lukas-reineke/virt-column.nvim",
			config = function()
				require("virt-column").setup()
				vim.cmd([[autocmd ColorScheme * highlight clear ColorColumn]])
			end,
		})

		-- fold
		use({
			"kevinhwang91/nvim-ufo",
			requires = "kevinhwang91/promise-async",
			disable = true,
			config = function()
				require("ufo-config")
			end,
		})

		--------------------------------
		-- Quickfix {{{2
		--------------------------------
		use({
			"https://gitlab.com/yorickpeterse/nvim-pqf",
			event = "BufReadPre",
			config = function()
				require("pqf").setup({})
			end,
		})

		use({
			"kevinhwang91/nvim-bqf",
			ft = "qf",
		})
		--}}}

		--}}}

		--------------------------------
		-- Git {{{1
		--------------------------------

		use({
			"ruifm/gitlinker.nvim",
			requires = "nvim-lua/plenary.nvim",
			keys = { "<leader>gy", "<leader>go" },
			setup = function()
				local wk = require("which-key")
				wk.register({
					y = "gitlinker: copy url",
					o = "gitlinker: open url",
				}, { mode = "n", prefix = "<leader>g" })
			end,
			config = function()
				require("gitlinker").setup({
					mappings = "<leader>gy",
				})
				n.map(
					"n",
					"<leader>go",
					'<cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".open_in_browser})<cr>',
					"gitlinker: open url"
				)
				n.map(
					"v",
					"<leader>go",
					'<cmd>lua require"gitlinker".get_buf_range_url("v", {action_callback = require"gitlinker.actions".open_in_browser})<cr>',
					"gitlinker: open url"
				)
			end,
		})

		use({
			"sindrets/diffview.nvim",
			requires = "nvim-lua/plenary.nvim",
			cmd = { "DiffviewOpen", "DiffviewFileHistory" },
			module = "diffview",
			setup = function()
				n.map("n", "<leader>gd", "<Cmd>DiffviewOpen<CR>", "diffview: diff HEAD")
			end,
			config = function()
				require("diffview").setup({
					enhanced_diff_hl = true,
					key_bindings = {
						file_panel = { q = "<Cmd>DiffviewClose<CR>" },
						view = { q = "<Cmd>DiffviewClose<CR>" },
					},
					view = {
						merge_tool = {
							layout = "diff3_mixed",
							disable_diagnostics = true, -- Temporarily disable diagnostics for conflict buffers while in the view.
						},
					},
				})
			end,
		})

		use({
			"akinsho/git-conflict.nvim",
			tag = "*",
			config = function()
				require("git-conflict").setup({
					disable_diagnostics = true,
				})
				vim.api.nvim_create_autocmd("User", {
					pattern = "GitConflictDetected",
					callback = function()
						-- vim.api.nvim_command([[GitConflictListQf]])
						-- vim.notify("Conflicts detected!")
					end,
				})
				vim.api.nvim_create_autocmd("User", {
					pattern = "GitConflictResolved",
					callback = function()
						vim.notify("All conflicts resolved!")
					end,
				})
			end,
		})

		use({
			"lewis6991/gitsigns.nvim",
			config = function()
				require("gitsigns").setup()
			end,
		})

		use({
			"TimUntersberger/neogit",
			cmd = "Neogit",
			requires = "nvim-lua/plenary.nvim",
			config = function()
				require("plugin-config/neogit")
			end,
		})
		---}}}

		use({
			"christoomey/vim-tmux-navigator",
			setup = function()
				vim.g.tmux_navigator_no_mappings = 1
			end,
			config = function()
				n.map("n", "<M-h>", "<cmd>TmuxNavigateLeft<CR>", "Move to left window / tmux pane")
				n.map("n", "<M-j>", "<cmd>TmuxNavigateDown<CR>", "Move to below window / tmux pane")
				n.map("n", "<M-k>", "<cmd>TmuxNavigateUp<CR>", "Move to above window / tmux pane")
				n.map("n", "<M-l>", "<cmd>TmuxNavigateRight<CR>", "Move to right window / tmux pane")
				n.map("n", "<M-\\>", "<cmd>TmuxNavigatePrevious<CR>", "Move to previous window / tmux pane")
			end,
		})

		use({
			{
				"nvim-treesitter/nvim-treesitter",
				run = ":TSUpdate",
				config = function()
					require("treesitter")
				end,
			},
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
				after = "nvim-treesitter",
			},
			{
				"nvim-treesitter/nvim-treesitter-refactor",
				after = "nvim-treesitter",
			},
			{
				"nvim-treesitter/playground",
				cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor" },
				after = "nvim-treesitter",
			},
			{
				"p00f/nvim-ts-rainbow",
				after = "nvim-treesitter",
			},
			{
				"JoosepAlviste/nvim-ts-context-commentstring",
				after = "nvim-treesitter",
			},
			{
				"windwp/nvim-ts-autotag",
				after = "nvim-treesitter",
			},
			{
				"andymass/vim-matchup",
				after = "nvim-treesitter",
				setup = function()
					vim.g.matchup_matchparen_offscreen = {}
				end,
			},
			-- treesitter-powered interactive swap
			{
				"mizlan/iswap.nvim",
				after = "nvim-treesitter",
				config = function()
					require("iswap").setup({
						autoswap = true,
						move_cursor = true,
					})
					n.map("n", "gs", "<cmd>ISwapNodeWith<CR>")
					n.map("n", "g<", "<cmd>ISwapNodeWithLeft<CR>")
					n.map("n", "g>", "<cmd>ISwapNodeWithRight<CR>")
				end,
			},
			{
				"neovim/nvim-lspconfig",
				opt = true,
			},
			{ "rafamadriz/friendly-snippets" },
			{
				"L3MON4D3/LuaSnip",
				config = function()
					require("snippets")
				end,
			},
			{
				"windwp/nvim-autopairs",
				config = function()
					require("nvim-autopairs").setup({
						fast_wrap = {},
					})
				end,
			},
			{
				"hrsh7th/nvim-cmp",
				config = function()
					require("plugin-config/cmp")
				end,
			},
			{
				"andersevenrud/cmp-tmux",
				after = "nvim-cmp",
			},
			{
				"rcarriga/cmp-dap",
				after = "nvim-cmp",
			},
			{
				"hrsh7th/cmp-cmdline",
				after = "nvim-cmp",
			},
			{
				"dmitmel/cmp-cmdline-history",
				after = "nvim-cmp",
			},
			{
				"ray-x/cmp-treesitter",
				after = "nvim-cmp",
			},
			{
				"hrsh7th/cmp-buffer",
				after = "nvim-cmp",
			},
			{
				"hrsh7th/cmp-path",
				after = "nvim-cmp",
			},
			{
				"hrsh7th/cmp-nvim-lsp",
				after = "nvim-cmp",
			},
			{
				"hrsh7th/cmp-nvim-lsp-document-symbol",
				after = "nvim-cmp",
			},
			{
				"hrsh7th/cmp-nvim-lua",
				after = "nvim-cmp",
			},
			{
				"saadparwaiz1/cmp_luasnip",
				after = "nvim-cmp",
			},
			{
				"uga-rosa/cmp-dictionary",
				after = "nvim-cmp",
				config = function()
					require("cmp_dictionary").setup({
						dic = {
							["*"] = { "/usr/share/dict/words" },
						},
					})
				end,
			},
			{
				"onsails/lspkind-nvim",
				opt = true,
			},
			{
				"mfussenegger/nvim-lint",
				disable = true,
				opt = true,
			},
			{
				"mfussenegger/nvim-dap",
			},
			{
				"rcarriga/nvim-dap-ui",
				after = { "nvim-dap" },
				config = function()
					local dap, dapui = require("dap"), require("dapui")

					dapui.setup()

					-- catppuccin integration
					local sign = vim.fn.sign_define
					sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
					sign(
						"DapBreakpointCondition",
						{ text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" }
					)
					sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })

					n.map("n", "<localleader>duo", dapui.open, "dapui: open")
					n.map("n", "<localleader>duc", dapui.close, "dapui: close")
					n.map("n", "<localleader>dut", dapui.toggle, "dapui: toggle")

					dap.listeners.after.event_initialized["dapui_config"] = function()
						dapui.open()
					end

					dap.listeners.before.event_terminated["dapui_config"] = function()
						dapui.close()
					end

					dap.listeners.before.event_exited["dapui_config"] = function()
						dapui.close()
					end
				end,
			},
			{
				"theHamsta/nvim-dap-virtual-text",
				after = {
					"nvim-dap",
					"nvim-treesitter",
				},
				config = function()
					require("nvim-dap-virtual-text").setup()
				end,
			},
			{
				"mfussenegger/nvim-dap-python",
				after = { "nvim-dap" },
			},
			{
				"leoluz/nvim-dap-go",
				after = { "nvim-dap" },
				config = function()
					require("dap-go").setup()
				end,
			},
		})
		-- use({
		-- 	"rcarriga/nvim-notify",
		-- 	config = function()
		-- 		vim.notify = require("notify")
		-- 	end,
		-- })
		-- use({
		-- 	"vigoux/notifier.nvim",
		-- 	config = function()
		-- 		require("notifier").setup({
		-- 			-- You configuration here
		-- 		})
		-- 	end,
		-- })

		use({ "RRethy/nvim-treesitter-endwise" })
		use({
			"m-demare/hlargs.nvim",
			requires = { "nvim-treesitter/nvim-treesitter" },
			config = function()
				require("hlargs").setup()
			end,
		})

		use({
			"stevearc/overseer.nvim",
			config = function()
				require("overseer").setup()
			end,
		})

		use({
			"ThePrimeagen/refactoring.nvim",
			requires = {
				{ "nvim-lua/plenary.nvim" },
				{ "nvim-treesitter/nvim-treesitter" },
			},
			config = function()
				require("refactoring").setup({
					-- prompt for return type
					prompt_func_return_type = {
						go = true,
					},
					-- prompt for function parameters
					prompt_func_param_type = {
						go = true,
					},
				})

				-- remap to open the Telescope refactoring menu in visual mode
				vim.api.nvim_set_keymap(
					"v",
					"<leader>rr",
					"<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
					{ noremap = true }
				)

				-- You can also use below = true here to to change the position of the printf
				-- statement (or set two remaps for either one). This remap must be made in normal mode.
				vim.api.nvim_set_keymap(
					"n",
					"<leader>rp",
					":lua require('refactoring').debug.printf({below = false})<CR>",
					{ noremap = true }
				)

				-- Print var: this remap should be made in visual mode
				vim.api.nvim_set_keymap(
					"v",
					"<leader>rv",
					":lua require('refactoring').debug.print_var({})<CR>",
					{ noremap = true }
				)

				-- Cleanup function: this remap should be made in normal mode
				vim.api.nvim_set_keymap(
					"n",
					"<leader>rc",
					":lua require('refactoring').debug.cleanup({})<CR>",
					{ noremap = true }
				)
			end,
		})

		use({
			"pwntester/octo.nvim",
			requires = {
				"nvim-lua/plenary.nvim",
				"nvim-telescope/telescope.nvim",
				"kyazdani42/nvim-web-devicons",
			},
			config = function()
				require("octo").setup()
			end,
		})

		use({
			"zhimsel/vim-stay",
			setup = function()
				vim.cmd([[set viewoptions=cursor,folds,slash,unix]])
			end,
		})

		use({ "uga-rosa/ccc.nvim" })

		use({
			{
				"nvim-telescope/telescope.nvim",
				requires = "nvim-lua/plenary.nvim",
				config = function()
					require("plugin-config/telescope")
				end,
			},
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				requires = "telescope.nvim",
				run = "make",
			},
			{
				"gbrlsnchs/telescope-lsp-handlers.nvim",
				requires = "telescope.nvim",
			},
		})

		--------------------------------
		-- Filetypes {{{1
		--------------------------------

		use({
			"ray-x/go.nvim",
			requires = "ray-x/guihua.lua",
			ft = { "go", "gomod" },
			config = function()
				require("go").setup({
					goimport = "gopls", -- if set to 'gopls' will use golsp format
					gofmt = "gopls", -- if set to gopls will use golsp format
				})

				local go_format = require("go.format")

				-- Run gofmt + goimport on save
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = vim.api.nvim_create_augroup("LspFormat", {}),
					pattern = "*.go",
					callback = function()
						go_format.goimport()
					end,
				})

				vim.api.nvim_create_user_command("Format", function()
					go_format.goimport()
				end, {})
			end,
		})

		use({
			"yasudanaoya/gotests-nvim",
			ft = "go",
			disable = true,
			config = function()
				require("gotests").setup()
			end,
		})

		use({
			"fatih/vim-go",
			disable = true,
			ft = { "go", "gomod" },
			setup = function()
				vim.g.go_gopls_enabled = 1

				-- vim.g.go_fmt_autosave = 1
				-- vim.g.go_fmt_command = "gopls"
				-- vim.g.go_gopls_gofumpt = 1

				-- vim.g.go_imports_autosave = 1
				-- vim.g.go_imports_mode = "gopls"

				vim.g.go_fillstruct_mode = "gopls"

				vim.g.go_term_mode = "split"
				vim.g.go_term_enabled = 1
				vim.g.go_term_reuse = 1
				vim.g.go_term_close_on_exit = 0

				vim.g.go_code_completion_enabled = 0
				vim.g.go_doc_keywordprg_enabled = 0
				vim.g.go_def_mapping_enabled = 0
				vim.g.go_echo_go_info = 0

				vim.g.go_fold_enable = {}
			end,
		})
		--}}}

		-- Better increment/decrement
		use({
			"monaqa/dial.nvim",
			config = function()
				require("plugin-config/dial")
			end,
		})

		use("tpope/vim-repeat")
		use("tpope/vim-sleuth")
		use("tpope/vim-apathy")
		use("tpope/vim-unimpaired")
		-- use("tpope/vim-fugitive")
		use("tpope/vim-abolish")

		use({
			"kylechui/nvim-surround",
			config = function()
				require("nvim-surround").setup({})
			end,
		})

		use({
			"mbbill/undotree",
			cmd = "UndotreeToggle",
			config = [[vim.g.undotree_SetFocusWhenToggle = 1]],
		})

		use({
			"romainl/vim-qf",
		})

		use({
			"lukas-reineke/indent-blankline.nvim",
			config = function()
				require("indent_blankline").setup({
					char = "┊", --"│"
					show_first_indent_level = true,
					show_trailing_blankline_indent = false,
					show_current_context = true,
					show_current_context_start = true,
					space_char_blankline = " ",
					char_highlight_list = {
						"IndentBlanklineIndent1",
						"IndentBlanklineIndent2",
						"IndentBlanklineIndent3",
						"IndentBlanklineIndent4",
						"IndentBlanklineIndent5",
						"IndentBlanklineIndent6",
					},
					filetype_exclude = {
						"startify",
						"dashboard",
						"dotooagenda",
						"log",
						"fugitive",
						"gitcommit",
						"packer",
						"vimwiki",
						"markdown",
						"json",
						"txt",
						"vista",
						"help",
						"todoist",
						"NvimTree",
						"peekaboo",
						"git",
						"TelescopePrompt",
						"undotree",
						"flutterToolsOutline",
						"", -- for all buffers without a file type
					},
					buftype_exclude = { "terminal", "nofile" },
				})
			end,
		})

		use({
			"akinsho/nvim-toggleterm.lua",
			config = function()
				require("toggleterm").setup({
					size = 20,
					open_mapping = [[<c-\>]],
					shade_filetypes = {},
					shade_terminals = false,
					shading_factor = 1,
					start_in_insert = true,
					persist_size = true,
					direction = "horizontal",
				})
			end,
		})

		use({
			"kyazdani42/nvim-tree.lua",
			requires = { "kyazdani42/nvim-web-devicons" },
			config = function()
				require("nvim-tree").setup({
					hijack_cursor = true,
					select_prompts = true,
				})

				local nt_api = require("nvim-tree.api")
				n.map("n", "<M-e>", function()
					nt_api.tree.toggle(true)
				end, "Toggle file tree")
			end,
		})

		use({
			"nvim-lualine/lualine.nvim",
			requires = { "kyazdani42/nvim-web-devicons" },
			-- after = "gruvbox-material",
			config = function()
				require("statusline")
			end,
		})

		-- use({
		-- 	"j-hui/fidget.nvim",
		-- 	config = function()
		-- 		require("fidget").setup({
		-- 			window = {
		-- 				blend = 0,
		-- 			},
		-- 			text = {
		-- 				spinner = "dots",
		-- 			},
		-- 		})
		-- 	end,
		-- })

		use({
			"nvim-neotest/neotest",
			requires = {
				"nvim-lua/plenary.nvim",
				"nvim-treesitter/nvim-treesitter",
				"nvim-neotest/neotest-go",
			},
			config = function()
				require("plugin-config/neotest")
			end,
		})

		use({
			"stevearc/aerial.nvim",
			config = function()
				require("aerial").setup()
			end,
		})

		use("b0o/schemastore.nvim")

		use({
			"folke/trouble.nvim",
			requires = "kyazdani42/nvim-web-devicons",
			opt = true,
		})

		use({
			"folke/todo-comments.nvim",
			requires = "nvim-lua/plenary.nvim",
			config = function()
				require("todo-comments").setup({})
			end,
		})

		use({
			"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
			config = function()
				require("lsp_lines").setup()
			end,
		})

		-- use({
		-- 	"b0o/incline.nvim",
		-- 	config = function()
		-- 		require("incline").setup({
		-- 			hide = {
		-- 				cursorline = false,
		-- 				focused_win = true,
		-- 				only_win = true,
		-- 			},
		-- 		})
		-- 	end,
		-- })

		-- Languages
		use({
			"dart-lang/dart-vim-plugin",
			-- disable=true,
			ft = { "dart" },
		})

		use({
			"akinsho/flutter-tools.nvim",
			-- ft = {'dart'},
			-- commit = "464a919",
			opt = true,
			requires = {
				"nvim-lua/plenary.nvim",
				"mfussenegger/nvim-dap",
				-- 'dart-lang/dart-vim-plugin',
			},
		})

		use({
			"simrat39/rust-tools.nvim",
			requires = {
				"nvim-lua/plenary.nvim",
				"neovim/nvim-lspconfig",
				"mfussenegger/nvim-dap",
			},
		})

		use({
			"jose-elias-alvarez/nvim-lsp-ts-utils",
			opt = true,
			requires = {
				"neovim/nvim-lspconfig",
				"nvim-lua/plenary.nvim",
				"jose-elias-alvarez/null-ls.nvim",
			},
		})

		use({
			"chrisbra/csv.vim",
			ft = { "csv" },
		})

		use("lilydjwg/fcitx.vim")

		use({
			"drzel/vim-gui-zoom",
			config = function()
				vim.api.nvim_set_keymap("n", "<C-+>", ":ZoomIn<CR>", {})
				vim.api.nvim_set_keymap("n", "<C-=>", ":ZoomIn<CR>", {})
				vim.api.nvim_set_keymap("n", "<C-->", ":ZoomOut<CR>", {})
			end,
		})

		use({
			"gabrielpoca/replacer.nvim",
			config = function()
				vim.api.nvim_set_keymap(
					"n",
					"<leader>h",
					':lua require("replacer").run()<cr>',
					{ nowait = true, noremap = true, silent = true }
				)
			end,
		})

		use({
			"stevearc/dressing.nvim",
			config = function()
				require("dressing").setup({
					select = {
						get_config = function(opts)
							if opts.kind == "codeaction" then
								return {
									backend = "telescope", --"nui",
									telescope = require("telescope.themes").get_cursor({}),
									nui = {
										relative = "cursor",
										max_width = 40,
									},
								}
							end
						end,
					},
				})
			end,
		})

		use({
			"vuki656/package-info.nvim",
			requires = "MunifTanjim/nui.nvim",
			config = function()
				require("package-info").setup({
					package_manager = "npm",
				})
			end,
		})

		use({ "AndrewRadev/splitjoin.vim" })

		use({
			"Wansmer/treesj",
			requires = { "nvim-treesitter" },
			config = function()
				require("plugin-config/treesj")
			end,
		})

		use({ "gpanders/editorconfig.nvim" })

		use({
			"cshuaimin/ssr.nvim",
			module = "ssr",
			config = function()
				require("plugin-config.ssr")
			end,
		})

		use({
			"numToStr/Comment.nvim",
			config = function()
				require("plugin-config/comment")
			end,
		})
	end,
	config = {
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "single" })
			end,
		},
	},
})

-- vim: ts=2 sts=2 sw=2 et
