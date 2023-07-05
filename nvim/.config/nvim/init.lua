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
  eol = "¬",
  tab = "  ",     --"  ▸", -- Alternatives: '▷▷',
  extends = "›", -- Alternatives: … »
  precedes = "‹", -- Alternatives: … «
  trail = "•",  -- BULLET (U+2022, UTF-8: E2 80 A2), Alternatives: ·
  lead = "⋅",
  multispace = "⋅",
}

vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.eadirection = "hor"

vim.opt.mouse = "a"
vim.opt.mousefocus = true
vim.opt.mousemodel = "extend"

-- vim.opt.signcolumn = "yes:3"

vim.opt.showmode = false

vim.opt.virtualedit = "block" -- allow cursor to move where there is no text in visual block mode

vim.opt.termguicolors = true

vim.opt.undofile = true

vim.opt.breakindent = true

vim.opt.updatetime = 300
vim.opt.timeoutlen = 400
vim.opt.ttimeoutlen = 20

vim.opt.cursorline = true
vim.opt.number = true

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ','
vim.g.maplocalleader = ' '


-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  -- NOTE: First, some plugins that don't require any configuration


  {
    "gabrielpoca/replacer.nvim",
    keys = {
      { "<leader>h", function() require("replacer").run() end, desc = "Replacer: Run" },
    },
  },
  {
    "romainl/vim-qf",
  },

  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    init = function()
      vim.g.undotree_SetFocusWhenToggle = 1
    end,
  },


  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  'tpope/vim-abolish',

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      {
        'j-hui/fidget.nvim',
        branch = 'legacy',
        opts = {
          window = {
            blend = 0,
          },
        }
      },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
  },

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim',    opts = {} },

  { "sitiom/nvim-numbertoggle" },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        theme = "catppuccin",
        icons_enabled = true,
        component_separators = '|',
        section_separators = '',
        globalstatus = true,
      },
    },
  },

  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    opts = {
      char = '┊',
      show_trailing_blankline_indent = false,
    },
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim',         opts = {} },

  -- Fuzzy Finder (files, lsp, etc)
  { 'nvim-telescope/telescope.nvim', dependencies = { 'nvim-lua/plenary.nvim' } },

  {
    'nvim-telescope/telescope-fzf-native.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
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
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "TroubleToggle",
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle<cr>",                       desc = "Trouble: Toggle" },
      { "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Trouble: Toggle Workspace Diagnostics" },
      { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",  desc = "Trouble: Toggle Document Diagnostics" },
      { "<leader>xl", "<cmd>TroubleToggle loclist<cr>",               desc = "Trouble: Toggle Location List" },
      { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",              desc = "Trouble: Toggle Quickfix" },
    },
    opts = {
      auto_jump = { "lsp_definitions", "lsp_references", "lsp_type_definitions" }, -- automatically jump if there is only a single result
      use_diagnostic_signs = true,
    },
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  },

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    opts = {},
  },

  {
    "christoomey/vim-tmux-navigator",
    init = function()
      vim.g.tmux_navigator_no_mappings = 1
    end,
    config = function()
      vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", { desc = "Move to left window / tmux pane" })
      vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", { desc = "Move to below window / tmux pane" })
      vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", { desc = "Move to above window / tmux pane" })
      vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", { desc = "Move to right window / tmux pane" })
      vim.keymap.set("n", "<C-S-l>", "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
        { desc = "Clear search highlight" })
      vim.keymap.set("n", "<ESC>", "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
        { desc = "Clear search highlight" })
      --
      vim.keymap.set("n", "<C-\\>", "<cmd>TmuxNavigatePrevious<CR>", { desc = "Move to previous window / tmux pane" })
    end,
  },

  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup({
        goimport = "gopls",
        gofmt = "gopls",
      })

      local go_format = require("go.format")

      -- Run gofmt + goimport on save
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("LspFormat", {}),
        pattern = "*.go",
        callback = function()
          go_format.goimport()
        end,
      })

      vim.api.nvim_create_user_command("Format", function()
        go_format.goimport()
      end, {})
    end,
    event = { "CmdlineEnter" },
    ft = { "go", 'gomod' },
    -- build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
  },

  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
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
      local neotest_ns = vim.api.nvim_create_namespace("neotest")
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            -- Replace newline and tab characters with space for more compact diagnostics
            local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
          end,
        },
      }, neotest_ns)

      if opts.adapters then
        local adapters = {}
        for name, config in pairs(opts.adapters or {}) do
          if type(name) == "number" then
            if type(config) == "string" then
              config = require(config)
            end
            adapters[#adapters + 1] = config
          elseif config ~= false then
            local adapter = require(name)
            if type(config) == "table" and not vim.tbl_isempty(config) then
              local meta = getmetatable(adapter)
              if adapter.setup then
                adapter.setup(config)
              elseif meta and meta.__call then
                adapter(config)
              else
                error("Adapter " .. name .. " does not support setup")
              end
            end
            adapters[#adapters + 1] = adapter
          end
        end
        opts.adapters = adapters
      end

      require("neotest").setup(opts)
    end,
    -- stylua: ignore
    keys = {
      {
        "<localleader>tf",
        function() require("neotest").run.run(vim.fn.expand("%")) end,
        desc =
        "Run File"
      },
      {
        "<localleader>tp",
        function() require("neotest").run.run(vim.loop.cwd()) end,
        desc =
        "Run All Test Files"
      },
      {
        "<localleader>tt",
        function() require("neotest").run.run() end,
        desc =
        "Run Nearest"
      },
      {
        "<localleader>ts",
        function() require("neotest").summary.toggle() end,
        desc =
        "Toggle Summary"
      },
      {
        "<localleader>to",
        function() require("neotest").output.open({ enter = true, auto_close = true }) end,
        desc =
        "Show Output"
      },
      {
        "<localleader>tO",
        function() require("neotest").output_panel.toggle() end,
        desc =
        "Toggle Output Panel"
      },
      {
        "<localleader>tS",
        function() require("neotest").run.stop() end,
        desc =
        "Stop"
      },
    },
  },

  {
    "andythigpen/nvim-coverage",
    dependencies = "nvim-lua/plenary.nvim",
    cmd = { 'Coverage', 'CoverageLoad', 'CoverageLoadLcov', 'CoverageToggle', 'CoverageShow', 'CoverageHide',
      'CoverageClear', 'CoverageSummary', },
    opts = {
      auto_reload = true,
    },
  },

  {
    'stevearc/overseer.nvim',
    cmd = { 'OverseerOpen', 'OverseerClose', 'OverseerToggle', 'OverseerRun', 'OverseerRunCmd', 'OverseerInfo',
      'OverseerBuild', 'OverseerQuickAction', 'OverseerTaskAction', 'OverseerClearTask' },
    keys = {
      {
        "<leader>tt",
        function() require("overseer").toggle({ enter = false }) end,
        desc =
        "Overseer: Toggle Task List"
      },
      {
        "<leader>to",
        function() require("overseer").open({ enter = true }) end,
        desc =
        "Overseer: Open Task List"
      },
      {
        "<leader>tr",
        function() require("overseer").run_template() end,
        desc =
        "Overseer: Run"
      },
    },
    opts = {
      task_list = {
        bindings = {
          ["o"] = "RunAction",
          ["<CR>"] = "IncreaseDetail",
          ["<BS>"] = "DecreaseDetail",
          ["<C-l>"] = false,
          ["<C-h>"] = false,
          ["<C-k>"] = false,
          ["<C-j>"] = false,
        },
      }
    },
  },

  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  },
  -- {
  --   "jose-elias-alvarez/typescript.nvim",
  --   dependencies = 'neovim/nvim-lspconfig',
  -- },
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- 'jose-elias-alvarez/typescript.nvim',
    },
  },
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-treesitter/nvim-treesitter" }
    },
    keys = {
      {
        mode = { "v" },
        "<leader>rr",
        "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
        desc = "Refactor: List refactors",
      },
    },
    opts = {},
  },

  -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
  --       These are some example plugins that I've included in the kickstart repository.
  --       Uncomment any of the lines below to enable them.
  require 'kickstart.plugins.autoformat',
  -- require 'kickstart.plugins.debug',

  -- NOTE: The import below automatically adds your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
  --    up-to-date with whatever is in the kickstart repo.
  --
  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  --
  --    An additional note is that if you only copied in the `init.lua`, you can just comment this line
  --    to get rid of the warning telling you that there are not plugins in `lua/custom/plugins/`.
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
local actions = require("telescope.actions")
-- local trouble = require("trouble.providers.telescope")

local telescope = require("telescope")
local fzf_opts = {
  fuzzy = true,                   -- false will only do exact matching
  override_generic_sorter = true, -- override the generic sorter
  override_file_sorter = true,    -- override the file sorter
  case_mode = "smart_case",       -- or "ignore_case" or "respect_case" the default case_mode is "smart_case"
}

telescope.setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
        ["<C-b>"] = actions.preview_scrolling_up,
        ["<C-f>"] = actions.preview_scrolling_down,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        -- ["<C-q>"] = trouble.open_with_trouble,
      },
      n = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
        ["<C-b>"] = actions.preview_scrolling_up,
        ["<C-f>"] = actions.preview_scrolling_down,
        -- ["<C-q>"] = trouble.open_with_trouble,
      },
    },
  },
  pickers = {
    lsp_dynamic_workspace_symbols = {
      sorter = telescope.extensions.fzf.native_fzf_sorter(fzf_opts)
    },
  },
  extensions = {
    fzf = fzf_opts,
    undo = {
      side_by_side = true,
      layout_strategy = "vertical",
      layout_config = {
        preview_height = 0.8,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(telescope.load_extension, 'fzf')
pcall(telescope.load_extension, 'refactoring')
pcall(telescope.load_extension, 'telescope-alternate')
pcall(telescope.load_extension, 'undo')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>f?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>f/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[F]uzzy search [F]iles' })
vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, { desc = '[F]uzzy search [B]uffers' })
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = '[F]uzzy search [H]elp' })
vim.keymap.set('n', '<leader>fw', require('telescope.builtin').grep_string, { desc = '[F]uzzy search current [W]ord' })
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = '[F]uzzy search by [G]rep' })
vim.keymap.set('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = '[F]uzzy search [D]iagnostics' })
vim.keymap.set('n', '<leader>fs', require('telescope.builtin').lsp_document_symbols,
  { desc = '[F]uzzy search document [S]ymbols' })
-- vim.keymap.set('n', '<leader>fS', require('telescope.builtin').lsp_workspace_symbols,
--   { desc = '[F]uzzy search workspace [S]ymbols' })
vim.keymap.set('n', '<leader>fS', require('telescope.builtin').lsp_dynamic_workspace_symbols,
  { desc = '[F]uzzy search workspace [S]ymbols' })

-- extensions
vim.keymap.set('n', '<leader>fa', "<cmd>:Telescope telescope-alternate alternate_file<CR>",
  { desc = '[F]uzzy search [A]lternate files' })
vim.keymap.set('n', '<leader>fu', "<cmd>:Telescope undo<CR>",
  { desc = '[F]uzzy search [A]lternate files' })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'typescript', 'vimdoc', 'vim', 'markdown',
    'markdown_inline' },

  -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  auto_install = true,

  highlight = {
    enable = true,
    disable = function(lang, buf)
      if lang == "vim" then
        local bufname = vim.api.nvim_buf_get_name(buf)
        return string.match(bufname, "%[Command Line%]")
      else
        return false
      end
    end,
    additional_vim_regex_highlighting = false
  },
  indent = { enable = true, disable = { 'python' } },
  incremental_selection = {
    enable = true,
    disable = function(lang, buf)
      if lang == "vim" then
        local bufname = vim.api.nvim_buf_get_name(buf)
        return string.match(bufname, "%[Command Line%]")
      else
        return false
      end
    end,
    keymaps = {
      -- init_selection = '<c-space>',
      -- node_incremental = '<c-space>',
      -- scope_incremental = '<c-s>',
      -- node_decremental = '<M-space>',
      -- init_selection = '<CR>',
      -- node_incremental = '<CR>',
      -- node_decremental = '<BS>',
      node_incremental = 'v',
      node_decremental = 'V',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}

vim.keymap.set("n", "<BS>", ":b#<CR>", { silent = true })

-- Diagnostic config
vim.diagnostic.config({
  severity_sort = true,
})

vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn", linehl = "", numhl = "" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo", linehl = "", numhl = "" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint", linehl = "", numhl = "" })

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set('n', '<leader>do', vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(client, bufnr)
  local map = function(mode, keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
  end

  -- map('n', 'gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  map('n', 'gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  map('n', '<localleader>lrn', vim.lsp.buf.rename, '[R]e[n]ame')
  map('n', 'K', vim.lsp.buf.hover, 'Hover Documentation')
  -- map('n', '<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
  -- map('n', 'gr', vim.lsp.buf.references, '[G]oto [R]eferences')
  -- map('n', 'gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  map({ 'n', 'i', 'v' }, '<C-Enter>', vim.lsp.buf.code_action, '[C]ode [A]ction')
  map({ 'n', 'i', 'v' }, '<localleader>lca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  local builtin = require('telescope.builtin')
  map('n', 'gd', builtin.lsp_definitions, '[G]oto [D]efinition')
  map('n', 'gr', builtin.lsp_references, 'Find Definition / [R]eferences / Implementation')
  map('n', 'gT', builtin.lsp_type_definitions, '[T]ype Definition')
  map('n', 'gI', builtin.lsp_implementations, '[G]oto [I]mplementation')

  map('n', '<localleader>lsd', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  -- map('n', '<localleader>lsw', require('telescope.builtin').lsp_workspace_symbols, '[W]orkspace [S]ymbols')
  map('n', '<localleader>lsw', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')


  -- Lesser used LSP functionality
  map('n', '<localleader>lwa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  map('n', '<localleader>lwr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  map('n', '<localleader>lwl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  vim.lsp.inlay_hint(bufnr, true)

  if client.name ~= "gopls" -- added in go.nvim
      or client.name ~= "tsserver" or client.name == 'typescript-tools' then
    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
      vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })
  end
end

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
      ["ui.semanticTokens"] = true,
      ["ui.completion.usePlaceholders"] = true,
      ["ui.completion.matcher"] = "Fuzzy",
      ["ui.diagnostic.staticcheck"] = true,
      ["ui.diagnostic.analyses"] = {
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
  eslint = {},
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      hint = { enable = true, arrayIndex = "Disable" },
    },
  },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.code_actions.refactoring,
    -- require("typescript.extensions.null-ls.code-actions"),
  },
})

require("typescript-tools").setup {
  on_attach = on_attach,
  settings = {
    tsserver_file_preferences = {
      includeInlayParameterNameHints = "all",
      includeInlayParameterNameHintsWhenArgumentMatchesName = true,
      includeInlayFunctionParameterTypeHints = true,
      includeInlayVariableTypeHints = true,
      includeInlayVariableTypeHintsWhenTypeMatchesName = true,
      includeInlayPropertyDeclarationTypeHints = true,
      includeInlayFunctionLikeReturnTypeHints = true,
      includeInlayEnumMemberValueHints = true,
    },
  }
}

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'
mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,

  -- ["tsserver"] = function()
  --   require("typescript").setup({
  --     disable_commands = false, -- prevent the plugin from creating Vim commands
  --     debug = false,            -- enable debug logging for commands
  --     go_to_source_definition = {
  --       fallback = true,        -- fall back to standard LSP definition on failure
  --     },
  --     server = {
  --       -- pass options to lspconfig's setup method
  --       capabilities = capabilities,
  --       on_attach = on_attach,
  --       init_options = {
  --         preferences = {
  --           allowRenameOfImportPath = true,
  --           importModuleSpecifierEnding = "auto",
  --           importModuleSpecifierPreference = "non-relative",
  --           includeCompletionsForImportStatements = true,
  --           includeCompletionsForModuleExports = true,
  --           quotePreference = "single",
  --           includeInlayParameterNameHints = "all",
  --           includeInlayParameterNameHintsWhenArgumentMatchesName = true,
  --           includeInlayFunctionParameterTypeHints = true,
  --           includeInlayVariableTypeHints = true,
  --           includeInlayVariableTypeHintsWhenTypeMatchesName = true,
  --           includeInlayPropertyDeclarationTypeHints = true,
  --           includeInlayFunctionLikeReturnTypeHints = true,
  --           includeInlayEnumMemberValueHints = true,
  --         },
  --       },
  --       settings = servers["tsserver"],
  --     },
  --   })
  -- end,
}

-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
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
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

-- vim: ts=2 sts=2 sw=2 et
