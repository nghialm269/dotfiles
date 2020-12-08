packadd popup.nvim
packadd plenary.nvim
packadd telescope.nvim
" packadd telescope-floaterm.nvim

nnoremap <C-p> :<C-u>lua require'telescope.builtin'.find_files{}<CR>
nnoremap <M-g> :<C-u>lua require'telescope.builtin'.grep_string{}<CR>
nnoremap <M-G> :<C-u>lua require'telescope.builtin'.live_grep{}<CR>
" nnoremap <C-t> :<C-u>lua require'telescope'.extensions.floaterm.terms()<CR>

lua require('telescope-nvim')
