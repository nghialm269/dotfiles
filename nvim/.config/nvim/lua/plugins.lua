vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  use {'wbthomason/packer.nvim', opt = true}

  use {
    'whiteinge/diffconflicts',
    cmd = { 'DiffConflicts', 'DiffConflictsWithHistory', 'DiffConflictsShowHistory' }
  }

  use {
    'rhysd/conflict-marker.vim'
  }

  use 'tpope/vim-unimpaired'

  use {'tomtom/tcomment_vim'}

  use {
    {'neovim/nvim-lspconfig', opt = true},
    {
      'nvim-lua/completion-nvim',
      opt = true,
      requires = {
        {'hrsh7th/vim-vsnip', opt = true},
        {'hrsh7th/vim-vsnip-integ', opt = true},
        -- {
        --   'norcalli/snippets.nvim',
        --   opt = true,
        --   -- commit = "f7f4e43",
        -- },
        {
          'steelsojka/completion-buffers',
          opt = true,
          after = {'completion-nvim'}
        },
      }
    },
    {'nvim-lua/lsp-status.nvim', opt = true},
    {
      'glepnir/lspsaga.nvim',
      opt = true,
      require = {{ 'neovim/nvim-lspconfig' }}
    },
    {
      'kosayoda/nvim-lightbulb', opt = true,
    },
    {
      'nvim-treesitter/nvim-treesitter',
      run = ":TSUpdate",
      opt = true,
    },
    {'nvim-treesitter/nvim-treesitter-textobjects', opt = true},
    {'nvim-treesitter/nvim-treesitter-refactor', opt = true},
    {'nvim-treesitter/playground', opt = true},
    {'romgrk/nvim-treesitter-context', opt = true},
  }

  use {
    'justinmk/vim-dirvish',
    { 'kristijanhusak/vim-dirvish-git', after = 'vim-dirvish' }
  }

  use {
    'dhruvasagar/vim-prosession',
    after = 'vim-obsession',
    requires = {{'tpope/vim-obsession', cmd = 'Prosession'}}
  }

  use {
    'zhimsel/vim-stay',
    opt = true
  }

  use {
    'tpope/vim-abolish',
    cmd = 'S',
  }

  use {
    'gruvbox-community/gruvbox',
    config = function()
      vim.g.gruvbox_italic = 1
      vim.g.gruvbox_contrast_dark = 'hard'
      vim.g.gruvbox_invert_selection = 0
      vim.cmd[[set background=dark]]
      vim.cmd[[colorscheme gruvbox]]
    end
  }

  use {
    'norcalli/nvim-colorizer.lua',
    config = function() require'colorizer'.setup() end
  }

  use {
    'nvim-telescope/telescope.nvim',
     opt = true,
     requires = {
       {'nvim-lua/popup.nvim', opt = true},
       {'nvim-lua/plenary.nvim', opt = true},
     }
  }

  use {
    'mhinz/vim-signify',
    opt = true,
  }

  -- use {
  --   'buoto/gotests-vim',
  --   cmd = { 'GoTests', 'GoTestsAll' }
  -- }

  use {
    'fatih/vim-go',
    ft = {'go', 'gomod'},
    config = function()
      vim.g.go_gopls_enabled = 1

      vim.g.go_fmt_autosave = 1
      vim.g.go_fmt_command = 'gopls'
      vim.g.go_gopls_gofumpt = 1

      vim.g.go_imports_autosave = 1
      vim.g.go_imports_mode = 'gopls'

      vim.g.go_fillstruct_mode = 'gopls'

      vim.g.go_term_mode = 'split'
      vim.g.go_term_enabled = 1
      vim.g.go_term_reuse = 1

      vim.g.go_code_completion_enabled = 0
      vim.g.go_doc_keywordprg_enabled = 0
      vim.g.go_def_mapping_enabled = 0 vim.g.go_echo_go_info = 0

      vim.g.go_fold_enable = {}
    end
  }

  -- use {
    -- 'tpope/vim-endwise',
  -- }
  -- use {
  --   'rstacruz/vim-closer',
  -- }
  use {
    'cohama/lexima.vim',
    opt = true,
  }

  -- Better increment/decrement
  use {
    'monaqa/dial.nvim'
  }

  use {
    'tpope/vim-surround'
  }

  use {
    'tpope/vim-sleuth'
  }

  use {
    'voldikss/vim-floaterm',
    opt = true
  }

  use {
    'romainl/vim-qf'
  }

  -- Languages
  use {
    'dart-lang/dart-vim-plugin',
    ft = {'dart'},
  }
  use {
    'akinsho/flutter-tools.nvim',
    -- ft = {'dart'},
    requires = {
      'neovim/nvim-lspconfig',
      'dart-lang/dart-vim-plugin',
    },
    config = function()
      require'flutter-tools'.setup{}
    end
  }
  -- use {
  --   'thosakwe/vim-flutter',
  --   ft = {'dart'},
  --   config = function()
  --     vim.g.flutter_hot_reload_on_save = 1
  --     vim.g.flutter_hot_restart_on_save = 0
  --     vim.g.flutter_show_log_on_run = 0
  --   end
  -- }

  -- Local plugins
  use {
    '~/projects/personal/nvim-plugins/telescope-floaterm.nvim',
    requires = {
      'nvim-telescope/telescope.nvim'
    },
    opt = true,
  }
end)

-- vim: ts=2 sts=2 sw=2 et
