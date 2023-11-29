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
}
