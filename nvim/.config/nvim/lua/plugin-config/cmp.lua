local cmp = require("cmp")
local compare = require("cmp.config.compare")
local cmp_buffer = require("cmp_buffer")
local compare_locality = function(...)
	return cmp_buffer:compare_locality(...)
end

local luasnip = require("luasnip")

local t = function(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local luasnipExpandOrJump = function()
	return cmp.mapping(function(fallback)
		if luasnip.expand_or_jumpable() then
			vim.fn.feedkeys(t("<Plug>luasnip-expand-or-jump"), "")
		else
			fallback()
		end
	end, {
		"i",
		"s",
	})
end

local luasnipJumpNext = function()
	return cmp.mapping(function(fallback)
		if luasnip.jumpable() then
			vim.fn.feedkeys(t("<Plug>luasnip-jump-next"), "")
		else
			fallback()
		end
	end, {
		"i",
		"s",
	})
end

local luasnipJumpPrev = function()
	return cmp.mapping(function(fallback)
		if luasnip.jumpable(-1) then
			vim.fn.feedkeys(t("<Plug>luasnip-jump-prev"), "")
		else
			fallback()
		end
	end, {
		"i",
		"s",
	})
end

local luasnipNextChoice = function()
	return cmp.mapping(function(fallback)
		if luasnip.choice_active() then
			vim.fn.feedkeys(t("<Plug>luasnip-next-choice"), "")
		else
			fallback()
		end
	end, {
		"i",
		"s",
	})
end

local luasnipPrevChoice = function()
	return cmp.mapping(function(fallback)
		if luasnip.choice_active() then
			vim.fn.feedkeys(t("<Plug>luasnip-prev-choice"), "")
		else
			fallback()
		end
	end, {
		"i",
		"s",
	})
end

local luasnipSelectChoice = function()
	return cmp.mapping(function(fallback)
		if luasnip.choice_active() then
			vim.fn.feedkeys(t('<ESC><cmd>lua require("luasnip.extras.select_choice")()<CR>'), "")
		else
			fallback()
		end
	end, {
		"i",
		"s",
	})
end

local preselectComparator = function(entry1, entry2)
	local preselect1 = entry1.completion_item.preselect or false
	local preselect2 = entry2.completion_item.preselect or false
	if preselect1 ~= preselect2 then
		return preselect1
	end
end

local clangdScoreComparator = function(entry1, entry2)
	local score1 = entry1.completion_item.score
	local score2 = entry2.completion_item.score
	if score1 and score2 then
		local diff = score1 - score2
		if diff < 0 then
			return true
		elseif diff > 0 then
			return false
		end
	end
end

cmp.setup({
	enabled = function()
		return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt" or require("cmp_dap").is_dap_buffer()
	end,

	completion = {
		autocomplete = { cmp.TriggerEvent.TextChanged },
		thin_scrollbar = true,
	},

	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},

	mapping = cmp.mapping.preset.insert({
		["<Down>"] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select })),
		["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select })),
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({
			select = false,
			behavior = cmp.ConfirmBehavior.Replace,
		}), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		["<C-y>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = false,
		}),
		["<C-j>"] = luasnipExpandOrJump(),
		["<C-S-j>"] = luasnipJumpNext(),
		["<C-k>"] = luasnipJumpPrev(),
		["<C-l>"] = luasnipNextChoice(),
		["<C-h>"] = luasnipPrevChoice(),
		["<C-u>"] = luasnipSelectChoice(),
	}),

	sorting = {
		priority_weight = 2,
		-- comparators = {
		-- 	preselectComparator,
		-- 	clangdScoreComparator,
		-- 	compare_locality,
		-- 	compare.offset,
		-- 	compare.exact,
		-- 	compare.score,
		-- 	compare.kind,
		-- 	compare.sort_text,
		-- 	compare.length,
		-- 	compare.order,
		-- },
	},

	sources = {
		{ name = "luasnip", max_item_count = 4 },
		{ name = "nvim_lsp" },
		{ name = "treesitter" },
		{ name = "nvim_lua" },
		{
			name = "buffer",
			option = {
				get_bufnrs = vim.api.nvim_list_bufs,
			},
		},
		{
			name = "tmux",
			option = {
				all_panes = true,
			},
		},
		{ name = "path" },
		{
			name = "dictionary",
			keyword_length = 2,
		},
	},

	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = require("lspkind").cmp_format({
			mode = "symbol",
			preset = "codicons",
			maxwidth = 50,
			menu = {
				luasnip = "[LuaSnip]",
				nvim_lsp = "[LSP]",
				treesitter = "[TS]",
				nvim_lua = "[Lua]",
				buffer = "[Buffer]",
				path = "[Path]",
				fuzzy_buffer = "[FBuffer]",
				fuzzy_path = "[FPath]",
				latex_symbols = "[Latex]",
				cmdline = "[CMD]",
				cmdline_history = "[History]",
				nvim_lsp_document_symbol = "[LSP]",
				dictionary = "[Dict]",
				copilot = "[AI]",
				rg = "[RG]",
				tmux = "[tmux]",
			},
		}),
	},

	window = {
		completion = cmp.config.window.bordered({
			winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
		}),
		documentation = cmp.config.window.bordered({
			winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
		}),
	},

	experimental = {
		ghost_text = true,
	},
})

cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "cmdline_history" },
	}, {
		{ name = "buffer" },
	}, {
		{ name = "nvim_lsp_document_symbol" },
	}),
})

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "cmdline" },
	}, {
		{ name = "cmdline_history" },
	}, {
		{ name = "path" },
		{
			name = "buffer",
			option = {
				get_bufnrs = vim.api.nvim_list_bufs,
			},
		},
	}),
})

require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
	sources = {
		{ name = "dap" },
	},
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
