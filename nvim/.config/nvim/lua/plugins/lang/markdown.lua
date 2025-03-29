return {
  {
    'OXY2DEV/markview.nvim',
    lazy = false,
    dependencies = {
      {
        'nvim-treesitter/nvim-treesitter',
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, {
            'markdown',
            'markdown_inline',
            'html',
            -- 'latex',
            'typst',
            'yaml',
          })
        end,
      },
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      preview = {
        modes = { 'n', 'i', 'no', 'c' },
        hybrid_modes = { 'i' },

        -- This is nice to have
        callbacks = {
          on_enable = function(_, win)
            vim.wo[win].conceallevel = 2
            vim.wo[win].concealcursor = 'nc'
          end,
        },
      },
    },
  },
}
