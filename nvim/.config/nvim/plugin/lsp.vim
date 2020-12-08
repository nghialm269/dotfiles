" This disables the fairly slow loading of server installation 
" commands, which we don't really use anyway
let g:nvim_lsp = 1

packadd nvim-lspconfig
packadd completion-nvim
packadd lsp-status.nvim
packadd completion-buffers
packadd vim-vsnip
packadd vim-vsnip-integ
packadd lexima.vim
packadd lspsaga.nvim
packadd nvim-lightbulb

highlight link LspReferenceText CursorColumn
highlight link LspReferenceRead CursorColumn
highlight link LspReferenceWrite CursorColumn

" vim-vsnip
let g:vsnip_snippet_dirs = globpath(expand('~/.vscode/extensions'), '*/snippets', 0, 1) + globpath('/opt/visual-studio-code/resources/app/extensions', '*/snippets', 0, 1)
let g:vsnip_filetypes.dart = ['flutter']

" Expand
" imap <expr> <CR>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<CR>'
" smap <expr> <CR>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<CR>'
" Expand or jump
imap <expr> <C-j>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-j>'
smap <expr> <C-j>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-j>'

" Jump forward or backward
" imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
" smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <C-k> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<C-k>'
smap <expr> <C-k> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<C-k>'

" Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
" See https://github.com/hrsh7th/vim-vsnip/pull/50
nmap        s   <Plug>(vsnip-select-text)
xmap        s   <Plug>(vsnip-select-text)
nmap        S   <Plug>(vsnip-cut-text)
xmap        S   <Plug>(vsnip-cut-text)

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

" map <c-space> to manually trigger completion
inoremap <silent><expr> <c-space> completion#trigger_completion() 
let g:lexima_no_default_rules = 1
call lexima#set_default_rules()

" inoremap <expr><silent> <CR> lexima#expand('<LT>CR>', 'i')
imap <expr> <cr>  pumvisible() ? complete_info()["selected"] != "-1" ?
			\ "\<Plug>(completion_confirm_completion)" :
			\ "\<c-e>" . lexima#expand('<LT>CR>', 'i') : lexima#expand('<LT>CR>', 'i')

" imap <expr> <cr>  pumvisible() ? complete_info()["selected"] != "-1" ?
" 			\ "\<Plug>(completion_confirm_completion)"  :
" 			\ "\<c-e>\<CR>" : "\<CR>"

" let g:completion_enable_snippet = 'snippets.nvim'
let g:completion_enable_snippet = 'vim-vsnip'

let g:completion_confirm_key = "\<C-y>"
let g:completion_enable_auto_popup = 1
let g:completion_enable_auto_hover = 1
let g:completion_enable_auto_signature = 1

" possible value: "length", "alphabet" (default), "none"
let g:completion_sorting = "none"

let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
let g:completion_matching_ignore_case = 1

" Respect language server's trigger character by default
" let g:completion_trigger_character = ['.', '::']  

let g:completion_trigger_keyword_length = 1
let g:completion_trigger_on_delete = 1

let g:completion_timer_cycle = 100 " default = 80

let g:completion_chain_complete_list = [
    \      {'complete_items': ['lsp', 'snippet']},
    \      {'complete_items': ['path'], 'triggered_only': ['/']},
    \      {'complete_items': ['buffers']},
    \      {'mode': '<c-p>'},
    \      {'mode': '<c-n>'}
    \]

let g:completion_auto_change_source = 1

imap <expr> <Tab>   pumvisible() ? "<Plug>(completion_next_source)" : "\<Tab>"
imap <expr> <S-Tab> pumvisible() ? "<Plug>(completion_prev_source)" : "\<S-Tab>"

autocmd BufEnter * lua require'completion'.on_attach()

sign define LspDiagnosticsSignError text=✘ texthl=LspDiagnosticsSignError linehl= numhl=
sign define LspDiagnosticsSignWarning text= texthl=LspDiagnosticsSignWarning linehl= numhl=
sign define LspDiagnosticsSignInformation text= texthl=LspDiagnosticsSignInformation linehl= numhl=
sign define LspDiagnosticsSignHint text=ﯧ texthl=LspDiagnosticsSignHint linehl= numhl=
sign define LightBulbSign text=ﯧ texthl=GruvboxYellow linehl= numhl=
" au ColorScheme * highlight LightBulbFloatWin ctermfg= ctermbg= guifg= guibg=
highlight link LightBulbFloatWin GruvboxYellow

" gopls organize imports and format
lua <<EOF
  function goimports(timeoutms)
    local context = { source = { organizeImports = true } }
    vim.validate { context = { context, "t", true } }

    local params = vim.lsp.util.make_range_params()
    params.context = context

    local method = "textDocument/codeAction"
    local resp = vim.lsp.buf_request_sync(0, method, params, timeoutms)
    if resp and resp[1] then
      local result = resp[1].result
      if result and result[1] then
        local edit = result[1].edit
        vim.lsp.util.apply_workspace_edit(edit)
      end
    end

    vim.lsp.buf.formatting_sync({}, timeoutms)
  end
EOF
" autocmd BufWritePre *.go lua goimports(1000)

autocmd BufWritePre *.dart lua vim.lsp.buf.formatting_sync()


" nnoremap <m-R> :<C-u>echo 'Restarting LSP...'<CR>:lua vim.lsp.stop_client(vim.lsp.get_active_clients())<CR>:edit<CR>

lua require('lsp')
