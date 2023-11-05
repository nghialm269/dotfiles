return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        'lua',
        'luadoc',
        'luap',
      })
    end,
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              telemetry = {
                enable = false,
              },
              completion = {
                callSnippet = 'Replace',
              },
              hint = {
                enable = true,
                arrayIndex = 'Disable',
              },
              format = {
                enable = false,
              },
            },
          },
        },
      },
    },
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    dependencies = {
      {
        'williamboman/mason.nvim',
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, { 'stylua' })
        end,
      },
    },
    opts = function(_, opts)
      local nls = require('null-ls')

      opts.sources = opts.sources or {}
      vim.list_extend(opts.sources, { nls.builtins.formatting.stylua })
    end,
  },
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      {
        'jbyuki/one-small-step-for-vimkind',
        -- stylua: ignore
        keys = {
          { "<localleader>daL", function() require("osv").launch({ port = 8086 }) end, desc = "Adapter Lua Server" },
          { "<localleader>dal", function() require("osv").run_this() end, desc = "Adapter Lua" },
        },
        config = function()
          local dap = require('dap')
          dap.adapters.nlua = function(callback, config)
            callback({
              type = 'server',
              host = config.host or '127.0.0.1',
              port = config.port or 8086,
            })
          end
          dap.configurations.lua = {
            {
              type = 'nlua',
              request = 'attach',
              name = 'Attach to running Neovim instance',
            },
          }
        end,
      },
    },
  },
}
