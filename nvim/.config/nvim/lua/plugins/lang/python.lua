return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        'python',
      })
    end,
  },
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/neotest-python',
    },
    opts = {
      adapters = {
        ['neotest-python'] = {
          runner = 'unittest',
        },
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        'mason-org/mason-lspconfig.nvim',
        dependencies = {
          {
            'mason-org/mason.nvim',
          },
        },
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, { 'ruff', 'basedpyright' })
        end,
      },
    },
    ft = { 'python' },
    opts = {
      servers = {
        ruff = {},
        basedpyright = {
          settings = {
            basedpyright = {
              disableOrganizeImports = true,
            },
          },
        },
      },
    },
  },
}
