vim.o.foldcolumn = "1"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

n.map("n", "zR", require("ufo").openAllFolds, "Folds: Open all")
n.map("n", "zM", require("ufo").closeAllFolds, "Folds: Close all")

require("ufo").setup({})
