" set guifont=BlexMono\ Nerd\ Font\ Mono:h15
" set guifont=BlexMono\ Nerd\ Font\ Mono,DejaVu\ Sans\ Mono:h15

let g:neovide_cursor_vfx_mode = "railgun"

nnoremap <silent> <C-6> <C-^>

if exists('g:fvim_loaded')
    set guifont=IBM\ Plex\ Mono:h15
    FVimCursorSmoothMove v:true
    FVimCursorSmoothBlink v:true
    " FVimFontNoBuiltinSymbols v:true
endif
