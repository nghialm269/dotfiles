finish
packadd snippets.nvim

lua require('snippets-nvim')

inoremap <c-j> <cmd>lua return require'snippets'.expand_or_advance()<CR>

