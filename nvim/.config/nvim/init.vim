set scrolloff=3
set sidescrolloff=5
set lazyredraw
set ignorecase
set smartcase

set diffopt=internal,filler,closeoff,vertical,indent-heuristic,algorithm:patience

set mouse=a

set termguicolors

set number
set relativenumber
set signcolumn=yes

set splitright
set splitbelow

set hidden

set tabstop=4
set softtabstop=4
set shiftwidth=4

set colorcolumn=80

set inccommand=nosplit " live substitution

set title

set list
set listchars=tab:▸\ ,eol:¬,trail:·

set wildoptions=pum
set pumblend=20
set winblend=20
set updatetime=300

syntax enable

autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=150, on_visual=false}

autocmd BufWritePost plugins.lua PackerCompile
lua require('plugins')

packadd vim-signify

" vim: ts=2 sts=2 sw=2 et
