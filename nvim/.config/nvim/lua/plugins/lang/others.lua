return {
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        typos_lsp = {
          init_options = {
            diagnosticSeverity = 'Warning',
          },
        },
      },
    },
  },
  {
    'https://gitlab.com/schrieveslaach/sonarlint.nvim',
    dependencies = {
      {
        'williamboman/mason.nvim',
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, { 'sonarlint-language-server' })
        end,
      },
    },
    opts = {
      server = {
        cmd = {
          'sonarlint-language-server',
          '-stdio',
          '-analyzers',
          vim.fn.expand('$MASON/share/sonarlint-analyzers/sonarpython.jar'),
          vim.fn.expand('$MASON/share/sonarlint-analyzers/sonargo.jar'),
          vim.fn.expand('$MASON/share/sonarlint-analyzers/sonarjs.jar'),
        },
        settings = {
          sonarlint = {},
        },
      },
      filetypes = {
        'python',
        'go',
        'javascript',
        'typescript',
      },
    },
  },
}
