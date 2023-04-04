" This disables the fairly slow loading of server installation 
" commands, which we don't really use anyway
let g:nvim_lsp = 1

packadd plenary.nvim
packadd nvim-lspconfig
packadd lspkind-nvim
packadd flutter-tools.nvim
packadd trouble.nvim
packadd nvim-lsp-ts-utils
packadd null-ls.nvim
packadd cmp-nvim-lsp
" packadd lsp_signature.nvim



" nvim-dap mapping
" vscode mapping
nnoremap <silent> <F5> :lua require'dap'.continue()<CR>
nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>
nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>
nnoremap <silent> <F9> :lua require'dap'.toggle_breakpoint()<CR>
" mnemonic mapping
nnoremap <silent> <leader>dc :lua require'dap'.continue()<CR>
nnoremap <silent> <leader>dS :lua require'dap'.step_over()<CR>
nnoremap <silent> <leader>ds :lua require'dap'.step_into()<CR>
nnoremap <silent> <leader>dj :lua require'dap'.step_out()<CR>
nnoremap <silent> <leader>db :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <leader>dB :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
" nnoremap <silent> <leader>dlb :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>
" nnoremap <silent> <leader>dl :lua require'dap'.run_last()<CR>

set shortmess+=c " Avoid showing message extra message when using completion

lua require('lsp')
