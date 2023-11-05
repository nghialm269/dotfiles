return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        'go',
        'gomod',
        'gowork',
        'gosum',
      })
    end,
  },
  {
    'ray-x/go.nvim',
    dependencies = { -- optional packages
      'ray-x/guihua.lua',
      'neovim/nvim-lspconfig',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('go').setup({
        goimport = 'gopls',
        gofmt = 'gopls',
        lsp_cfg = true,
      })

      local go_format = require('go.format')

      -- Run gofmt + goimport on save
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('LspFormat', {}),
        pattern = '*.go',
        callback = function()
          go_format.goimport()
        end,
      })

      vim.api.nvim_create_user_command('Format', function()
        go_format.goimport()
      end, {})
    end,
    event = { 'CmdlineEnter' },
    ft = { 'go', 'gomod' },
    -- build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
  },
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     servers = {
  --       gopls = {
  --         settings = {
  --           gopls = {
  --             semanticTokens = true,
  --           },
  --         },
  --       },
  --     },
  --     setup = {
  --       gopls = function()
  --         -- workaround for gopls not supporting semantictokensprovider
  --         -- https://github.com/golang/go/issues/54531#issuecomment-1464982242
  --         require("lazyvim.util").on_attach(function(client, _)
  --           if client.name == "gopls" then
  --             if not client.server_capabilities.semanticTokensProvider then
  --               local semantic = client.config.capabilities.textDocument.semanticTokens
  --               client.server_capabilities.semanticTokensProvider = {
  --                 full = true,
  --                 legend = {
  --                   tokenTypes = semantic.tokenTypes,
  --                   tokenModifiers = semantic.tokenModifiers,
  --                 },
  --                 range = true,
  --               }
  --             end
  --           end
  --         end)
  --         -- end workaround
  --       end,
  --     },
  --   },
  -- },
  {
    'mfussenegger/nvim-dap',
    optional = true,
    dependencies = {
      {
        'williamboman/mason.nvim',
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, { 'delve' })
        end,
      },
      {
        'leoluz/nvim-dap-go',
        config = true,
      },
    },
  },
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/neotest-go',
    },
    opts = {
      adapters = {
        ['neotest-go'] = {
          -- Here we can set options for neotest-go, e.g.
          -- args = { "-tags=integration" }
          experimental = {
            test_table = true,
          },
          args = { '-count=1', '-coverprofile=coverage.out' },
        },
      },
    },
  },
}
