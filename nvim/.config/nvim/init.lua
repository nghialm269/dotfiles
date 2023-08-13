vim.opt.exrc = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.opt.title = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

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

vim.opt.fillchars:append({ diff = '╱' })

vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.eadirection = 'hor'

vim.opt.mouse = 'a'
vim.opt.mousefocus = true
vim.opt.mousemodel = 'extend'

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

vim.opt.diffopt = {
  'internal',
  'filler',
  'closeoff',
  'vertical',
  'indent-heuristic',
  'algorithm:histogram',
  'linematch:60',
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
  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
  },

  { 'sitiom/nvim-numbertoggle' },

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
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup({})
    end,
  },

  {
    'kylechui/nvim-surround',
    version = '*', -- Use for stability; omit to use `main` branch for the latest features
    event = 'VeryLazy',
    opts = {},
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
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      -- "antoinemadec/FixCursorHold.nvim",
    },
    opts = {
      -- Can be a list of adapters like what neotest expects,
      -- or a list of adapter names,
      -- or a table of adapter names, mapped to adapter configs.
      -- The adapter will then be automatically loaded with the config.
      adapters = {},
      -- Example for loading neotest-go with a custom config
      -- adapters = {
      --   ["neotest-go"] = {
      --     args = { "-tags=integration" },
      --   },
      -- },
      status = { virtual_text = true },
      output = { open_on_run = true },
      -- quickfix = {
      --   open = function()
      --     if require("lazyvim.util").has("trouble.nvim") then
      --       vim.cmd("Trouble quickfix")
      --     else
      --       vim.cmd("copen")
      --     end
      --   end,
      -- },
    },
    config = function(_, opts)
      local neotest_ns = vim.api.nvim_create_namespace('neotest')
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            -- Replace newline and tab characters with space for more compact diagnostics
            local message =
              diagnostic.message:gsub('\n', ' '):gsub('\t', ' '):gsub('%s+', ' '):gsub('^%s+', '')
            return message
          end,
        },
      }, neotest_ns)

      if opts.adapters then
        local adapters = {}
        for name, config in pairs(opts.adapters or {}) do
          if type(name) == 'number' then
            if type(config) == 'string' then
              config = require(config)
            end
            adapters[#adapters + 1] = config
          elseif config ~= false then
            local adapter = require(name)
            if type(config) == 'table' and not vim.tbl_isempty(config) then
              local meta = getmetatable(adapter)
              if adapter.setup then
                adapter.setup(config)
              elseif meta and meta.__call then
                adapter(config)
              else
                error('Adapter ' .. name .. ' does not support setup')
              end
            end
            adapters[#adapters + 1] = adapter
          end
        end
        opts.adapters = adapters
      end

      require('neotest').setup(opts)
    end,
    keys = {
      {
        '<localleader>tf',
        function()
          require('neotest').run.run(vim.fn.expand('%'))
        end,
        desc = 'Run File',
      },
      {
        '<localleader>tp',
        function()
          require('neotest').run.run(vim.loop.cwd())
        end,
        desc = 'Run All Test Files',
      },
      {
        '<localleader>tt',
        function()
          require('neotest').run.run()
        end,
        desc = 'Run Nearest',
      },
      {
        '<localleader>ts',
        function()
          require('neotest').summary.toggle()
        end,
        desc = 'Toggle Summary',
      },
      {
        '<localleader>to',
        function()
          require('neotest').output.open({ enter = true, auto_close = true })
        end,
        desc = 'Show Output',
      },
      {
        '<localleader>tO',
        function()
          require('neotest').output_panel.toggle()
        end,
        desc = 'Toggle Output Panel',
      },
      {
        '<localleader>tS',
        function()
          require('neotest').run.stop()
        end,
        desc = 'Stop',
      },
    },
  },

  {
    'andythigpen/nvim-coverage',
    dependencies = 'nvim-lua/plenary.nvim',
    cmd = {
      'Coverage',
      'CoverageLoad',
      'CoverageLoadLcov',
      'CoverageToggle',
      'CoverageShow',
      'CoverageHide',
      'CoverageClear',
      'CoverageSummary',
    },
    opts = {
      auto_reload = true,
    },
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
}, {})

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

vim.keymap.set(
  'n',
  '<leader>ff',
  require('telescope.builtin').find_files,
  { desc = '[F]uzzy search [F]iles' }
)
vim.keymap.set(
  'n',
  '<leader>fb',
  require('telescope.builtin').buffers,
  { desc = '[F]uzzy search [B]uffers' }
)
vim.keymap.set(
  'n',
  '<leader>fh',
  require('telescope.builtin').help_tags,
  { desc = '[F]uzzy search [H]elp' }
)
vim.keymap.set(
  'n',
  '<leader>fw',
  require('telescope.builtin').grep_string,
  { desc = '[F]uzzy search current [W]ord' }
)
vim.keymap.set(
  'n',
  '<leader>fg',
  require('telescope.builtin').live_grep,
  { desc = '[F]uzzy search by [G]rep' }
)
vim.keymap.set(
  'n',
  '<leader>fd',
  require('telescope.builtin').diagnostics,
  { desc = '[F]uzzy search [D]iagnostics' }
)
vim.keymap.set(
  'n',
  '<leader>fs',
  require('telescope.builtin').lsp_document_symbols,
  { desc = '[F]uzzy search document [S]ymbols' }
)
-- vim.keymap.set('n', '<leader>fS', require('telescope.builtin').lsp_workspace_symbols,
--   { desc = '[F]uzzy search workspace [S]ymbols' })
vim.keymap.set(
  'n',
  '<leader>fS',
  require('telescope.builtin').lsp_dynamic_workspace_symbols,
  { desc = '[F]uzzy search workspace [S]ymbols' }
)

-- extensions
vim.keymap.set(
  'n',
  '<leader>fa',
  '<cmd>:Telescope telescope-alternate alternate_file<CR>',
  { desc = '[F]uzzy search [A]lternate files' }
)
vim.keymap.set(
  'n',
  '<leader>fu',
  '<cmd>:Telescope undo<CR>',
  { desc = '[F]uzzy search [A]lternate files' }
)

vim.keymap.set('n', '<BS>', ':b#<CR>', { silent = true })

-- Diagnostic config
vim.diagnostic.config({
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
vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  -- clangd = {},
  gopls = {
    gopls = {
      -- ["env"] = {
      --   GOFLAGS = "-tags=integration",
      -- },
      -- ["formatting.local"] = "github.com/koinworks/asgard-koinneo",
      -- ["formatting.gofumpt"] = true,
      ['ui.semanticTokens'] = true,
      ['ui.completion.usePlaceholders'] = true,
      ['ui.completion.matcher'] = 'Fuzzy',
      ['ui.diagnostic.staticcheck'] = true,
      ['ui.diagnostic.analyses'] = {
        nilness = true,
        shadow = true,
        unusedparams = true,
        unusedwrite = true,
      },
    },
  },
  pyright = {},
  -- rust_analyzer = {},

  -- tsserver = {},
}

-- Setup mason so it can manage external tooling
-- require('mason').setup()

-- Ensure the servers above are installed
-- local mason_lspconfig = require 'mason-lspconfig'
-- mason_lspconfig.setup {
--   ensure_installed = vim.tbl_keys(servers),
-- }

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
--
-- mason_lspconfig.setup_handlers {
--   function(server_name)
--     require('lspconfig')[server_name].setup {
--       capabilities = capabilities,
--       settings = servers[server_name],
--     }
--   end,
-- }

-- nvim-cmp setup
local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete({}),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  },
})

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

-- vim: ts=2 sts=2 sw=2 et
