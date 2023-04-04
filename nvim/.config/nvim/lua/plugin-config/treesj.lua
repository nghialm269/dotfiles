require("treesj").setup({--[[ your config ]]
	use_default_keymaps = false,
})
local langs = require("treesj.langs")["presets"]

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = "*",
	callback = function()
		if langs[vim.bo.filetype] then
			n.bufmap(0, "n", "gS", "<cmd>TSJSplit<CR>", "Split (treesj)")
			n.bufmap(0, "n", "gJ", "<cmd>TSJJoin<CR>", "Join (treesj)")
		else
			n.bufmap(0, "n", "gS", "<cmd>SplitjoinSplit<CR>", "Split (splitjoin)")
			n.bufmap(0, "n", "gJ", "<cmd>SplitjoinJoin<CR>", "Join (splitjoin)")
		end
	end,
})
