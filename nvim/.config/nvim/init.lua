vim.opt.exrc = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.opt.title = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = 'split'

vim.opt.scrolloff = 9
vim.opt.sidescrolloff = 10
vim.opt.sidescroll = 1

vim.opt.list = true -- invisible chars
vim.opt.listchars = {
  eol = '¬',
  tab = '  ', --"  ▸", -- Alternatives: '▷▷',
  extends = '›', -- Alternatives: … »
  precedes = '‹', -- Alternatives: … «
  trail = '•', -- BULLET (U+2022, UTF-8: E2 80 A2), Alternatives: ·
  lead = '⋅',
  multispace = '⋅',
}

vim.opt.fillchars:append({
  diff = '╱',
  fold = ' ',
  foldopen = '',
  foldclose = '',
  foldsep = '│',
})

vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.eadirection = 'hor'

vim.opt.mouse = 'a'
vim.opt.mousefocus = true
vim.opt.mousemodel = 'extend'
-- vim.opt.mousemoveevent = true

-- vim.opt.signcolumn = "yes:3"

vim.opt.showmode = false

vim.opt.virtualedit = 'block' -- allow cursor to move where there is no text in visual block mode

vim.opt.termguicolors = true

vim.opt.undofile = true

vim.opt.breakindent = true

vim.opt.updatetime = 300
vim.opt.timeoutlen = 400
vim.opt.ttimeoutlen = 20

vim.opt.cursorline = true
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.diffopt = {
  'internal',
  'filler',
  'closeoff',
  'vertical',
  'indent-heuristic',
  'algorithm:histogram',
  'linematch:60',
}

vim.opt.foldcolumn = '1'
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldtext = require('foldtext')

vim.g.clipboard = {
  name = 'OSC 52',
  copy = {
    ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
    ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
  },
  paste = {
    ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
    ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
  },
}

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ','
vim.g.maplocalleader = ' '

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- Fuzzy Finder (files, lsp, etc)
  { 'nvim-telescope/telescope.nvim', dependencies = { 'nvim-lua/plenary.nvim' } },

  {
    'nvim-telescope/telescope-fzf-native.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    build = 'make',
    cond = function()
      return vim.fn.executable('make') == 1
    end,
  },

  {
    'otavioschwanck/telescope-alternate',
    dependencies = { 'nvim-telescope/telescope.nvim' },
  },

  {
    'debugloop/telescope-undo.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
  },
  {
    'christoomey/vim-tmux-navigator',
    init = function()
      vim.g.tmux_navigator_no_mappings = 1
      vim.g.tmux_navigator_no_wrap = 1
    end,
    config = function()
      vim.keymap.set(
        'n',
        '<C-h>',
        '<cmd>TmuxNavigateLeft<CR>',
        { desc = 'Move to left window / tmux pane' }
      )
      vim.keymap.set(
        'n',
        '<C-j>',
        '<cmd>TmuxNavigateDown<CR>',
        { desc = 'Move to below window / tmux pane' }
      )
      vim.keymap.set(
        'n',
        '<C-k>',
        '<cmd>TmuxNavigateUp<CR>',
        { desc = 'Move to above window / tmux pane' }
      )
      vim.keymap.set(
        'n',
        '<C-l>',
        '<cmd>TmuxNavigateRight<CR>',
        { desc = 'Move to right window / tmux pane' }
      )
      vim.keymap.set(
        'n',
        '<C-S-l>',
        '<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>',
        { desc = 'Clear search highlight' }
      )
      --
      vim.keymap.set(
        'n',
        '<C-\\>',
        '<cmd>TmuxNavigatePrevious<CR>',
        { desc = 'Move to previous window / tmux pane' }
      )
    end,
  },

  {
    'ThePrimeagen/refactoring.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-treesitter/nvim-treesitter' },
    },
    keys = {
      {
        mode = { 'v' },
        '<leader>rr',
        "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
        desc = 'Refactor: List refactors',
      },
    },
    opts = {},
  },

  { import = 'plugins' },
  { import = 'plugins.lang' },
}, {
  ui = {
    custom_keys = {
      ['<localleader>d'] = function(plugin)
        vim.notify(vim.inspect(plugin), vim.log.levels.INFO, {
          title = 'Inspect ' .. plugin.name,
        })
      end,
      ['<localleader>i'] = {
        function(plugin)
          vim.notify(vim.inspect(plugin), vim.log.levels.INFO, {
            title = 'Inspect ' .. plugin.name,
            lang = 'lua',
          })
        end,
        desc = 'Inspect Plugin',
      },
    },
  },
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true, -- reset the package path to improve startup time
    rtp = {
      reset = true, -- reset the runtime path to $VIMRUNTIME and your config directory
      ---@type string[]
      paths = {}, -- add any custom paths here that you want to includes in the rtp
      ---@type string[] list any plugins you want to disable here
      disabled_plugins = {
        'gzip',
        'matchit',
        'matchparen',
        'netrwPlugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
})

-- [[ Setting options ]]
-- See `:help vim.o`

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Center cursor after moving down half-page' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Center cursor after moving up half-page' })
vim.keymap.set('n', '<C-f>', '<C-f>zz', { desc = 'Center cursor after moving down full-page' })
vim.keymap.set('n', '<C-b>', '<C-b>zz', { desc = 'Center cursor after moving up full-page' })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- [[ Configure Telescope ]]
local actions = require('telescope.actions')
-- local trouble = require("trouble.providers.telescope")

local telescope = require('telescope')
local fzf_opts = {
  fuzzy = true, -- false will only do exact matching
  override_generic_sorter = true, -- override the generic sorter
  override_file_sorter = true, -- override the file sorter
  case_mode = 'smart_case', -- or "ignore_case" or "respect_case" the default case_mode is "smart_case"
}

telescope.setup({
  defaults = {
    dynamic_preview_title = true,
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
        ['<C-b>'] = actions.preview_scrolling_up,
        ['<C-f>'] = actions.preview_scrolling_down,
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
        -- ["<C-q>"] = trouble.open_with_trouble,
      },
      n = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
        ['<C-b>'] = actions.preview_scrolling_up,
        ['<C-f>'] = actions.preview_scrolling_down,
        -- ["<C-q>"] = trouble.open_with_trouble,
      },
    },
  },
  pickers = {
    lsp_dynamic_workspace_symbols = {
      sorter = telescope.extensions.fzf.native_fzf_sorter(fzf_opts),
    },
  },
  extensions = {
    fzf = fzf_opts,
    undo = {
      side_by_side = true,
      layout_strategy = 'vertical',
      layout_config = {
        preview_height = 0.8,
      },
    },
  },
})

-- Enable telescope fzf native, if installed
pcall(telescope.load_extension, 'fzf')
pcall(telescope.load_extension, 'refactoring')
pcall(telescope.load_extension, 'telescope-alternate')
pcall(telescope.load_extension, 'undo')

-- See `:help telescope.builtin`
vim.keymap.set(
  'n',
  '<leader>f?',
  require('telescope.builtin').oldfiles,
  { desc = '[?] Find recently opened files' }
)
vim.keymap.set(
  'n',
  '<leader><space>',
  require('telescope.builtin').buffers,
  { desc = '[ ] Find existing buffers' }
)
vim.keymap.set('n', '<leader>f/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
    winblend = 10,
    previewer = false,
  }))
end, { desc = '[/] Fuzzily search in current buffer' })

-- vim.keymap.set(
--   'n',
--   '<leader>ff',
--   require('telescope.builtin').find_files,
--   { desc = 'Fuzzy search Files' }
-- )
vim.keymap.set(
  'n',
  '<leader>fb',
  require('telescope.builtin').buffers,
  { desc = 'Fuzzy search Buffers' }
)
vim.keymap.set(
  'n',
  '<leader>fc',
  require('telescope.builtin').commands,
  { desc = 'Fuzzy search Commands' }
)
vim.keymap.set(
  'n',
  '<leader>fh',
  require('telescope.builtin').help_tags,
  { desc = 'Fuzzy search Help' }
)
-- vim.keymap.set(
--   'n',
--   '<leader>fw',
--   require('telescope.builtin').grep_string,
--   { desc = 'Fuzzy search current Word' }
-- )
-- vim.keymap.set(
--   'n',
--   '<leader>fg',
--   require('telescope.builtin').live_grep,
--   { desc = 'Fuzzy search by Grep' }
-- )
vim.keymap.set(
  'n',
  '<leader>fd',
  require('telescope.builtin').diagnostics,
  { desc = 'Fuzzy search Diagnostics' }
)
-- vim.keymap.set(
--   'n',
--   '<leader>fs',
--   require('telescope.builtin').lsp_document_symbols,
--   { desc = 'Fuzzy search document Symbols' }
-- )
-- vim.keymap.set('n', '<leader>fS', require('telescope.builtin').lsp_workspace_symbols,
--   { desc = 'Fuzzy search workspace Symbols' })
-- vim.keymap.set(
--   'n',
--   '<leader>fS',
--   require('telescope.builtin').lsp_dynamic_workspace_symbols,
--   { desc = 'Fuzzy search workspace Symbols' }
-- )

-- extensions
vim.keymap.set(
  'n',
  '<leader>fa',
  '<cmd>:Telescope telescope-alternate alternate_file<CR>',
  { desc = 'Fuzzy search Alternate files' }
)
vim.keymap.set('n', '<leader>fu', '<cmd>:Telescope undo<CR>', { desc = 'Fuzzy search undo tree' })

vim.keymap.set('n', '<BS>', ':b#<CR>', { silent = true })

-- Diagnostic config
vim.diagnostic.config({
  float = {
    source = true,
  },
  severity_sort = true,
})

vim.fn.sign_define(
  'DiagnosticSignError',
  { text = '', texthl = 'DiagnosticSignError', linehl = '', numhl = '' }
)
vim.fn.sign_define(
  'DiagnosticSignWarn',
  { text = '', texthl = 'DiagnosticSignWarn', linehl = '', numhl = '' }
)
vim.fn.sign_define(
  'DiagnosticSignInfo',
  { text = '', texthl = 'DiagnosticSignInfo', linehl = '', numhl = '' }
)
vim.fn.sign_define(
  'DiagnosticSignHint',
  { text = '', texthl = 'DiagnosticSignHint', linehl = '', numhl = '' }
)

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set(
  'n',
  '<leader>do',
  vim.diagnostic.open_float,
  { desc = 'Open floating diagnostic message' }
)
vim.keymap.set('n', '<leader>dq', vim.diagnostic.setqflist, { desc = 'Open diagnostics list' })

local qf_loclist_group = vim.api.nvim_create_augroup('QFLocListGroup', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'qf', 'location' },
  group = qf_loclist_group,
  callback = function(ev)
    vim.keymap.set('n', '<M-CR>', function()
      require('pickers.selectwin').toggle(function(origin_win, picked_win, new_win)
        -- origin_win should be either quickfix or loclist since this keymap is only set for those
        local origin_buf = vim.api.nvim_win_get_buf(origin_win)
        local buftype = vim.api.nvim_get_option_value('buftype', { buf = origin_buf })

        local cmd
        local line_nr = vim.fn.line('.', origin_win)
        if buftype == 'quickfix' then
          vim.cmd('cc ' .. line_nr)
        elseif buftype == 'loclist' then
          vim.cmd('ll ' .. line_nr)
        else -- should never happen
          vim.notify('Unknown buftype: ' .. buftype, 'warn')
        end
      end)
    end, { silent = true, buffer = ev.buf })
  end,
})

-- vim: ts=2 sts=2 sw=2 et
