nnoremap <C-p> :<C-u>lua require'telescope.builtin'.find_files{}<CR>

" grep string under cursor
nnoremap <M-w> :<C-u>lua require'telescope.builtin'.grep_string{}<CR>

nnoremap <M-g> :<C-u>lua require'telescope.builtin'.live_grep{}<CR>
" nnoremap <C-t> :<C-u>lua require'telescope'.extensions.floaterm.terms()<CR>


lua require('telescope-config')
