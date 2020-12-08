packadd nvim-treesitter
packadd nvim-treesitter-textobjects
packadd nvim-treesitter-refactor
" packadd nvim-treesitter-context

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldcolumn=3
set foldopen-=block
set foldlevelstart=1
lua require('treesitter')
