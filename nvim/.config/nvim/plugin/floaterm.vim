packadd vim-floaterm

nnoremap   <silent>   <F7>    :FloatermNew<CR>
tnoremap   <silent>   <F7>    <C-\><C-n>:FloatermNew<CR>

nnoremap   <silent>   <M-e>    :FloatermNew nnn<CR>

tnoremap   <silent>   <C-j>    <C-\><C-n>:FloatermPrev<CR>
tnoremap   <silent>   <C-k>    <C-\><C-n>:FloatermNext<CR>

nnoremap   <silent>   <C-t>   :FloatermToggle<CR>
tnoremap   <silent>   <C-t>   <C-\><C-n>:FloatermToggle<CR>
