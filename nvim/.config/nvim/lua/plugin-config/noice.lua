require("noice").setup({
	lsp = {
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true,
		},
		documentation = {
			opts = {
				border = { style = "rounded" },
				relative = "cursor",
				position = {
					row = 2,
				},
				win_options = {
					concealcursor = "n",
					conceallevel = 3,
					winhighlight = {
						Normal = "NormalFloat",
						FloatBorder = "FloatBorder",
					},
				},
			},
		},
	},
})

n.map("n", "<c-f>", function()
	if not require("noice.lsp").scroll(4) then
		return "<c-f>"
	end
end, { expr = true })

n.map("n", "<c-b>", function()
	if not require("noice.lsp").scroll(-4) then
		return "<c-b>"
	end
end, { expr = true })
