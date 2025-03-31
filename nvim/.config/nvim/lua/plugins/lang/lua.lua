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
    dependencies = {
      {
        'williamboman/mason-lspconfig.nvim',
        dependencies = {
          {
            'williamboman/mason.nvim',
          },
        },
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, { 'lua_ls' })
        end,
      },
      {
        'folke/lazydev.nvim',
        ft = 'lua', -- only load on lua files
        opts = {
          library = {

            -- Library paths can be absolute
            -- "~/projects/my-awesome-lib",

            -- Or relative, which means they will be resolved from the plugin dir.
            'luvit-meta/library',
            'neotest',
            'plenary',

            { path = 'snacks.nvim', words = { 'Snacks' } },
            { path = 'lazy.nvim', words = { 'LazyVim' } },

            -- It can also be a table with trigger words / mods
            -- Only load luvit types when the `vim.uv` word is found
            { path = 'luvit-meta/library', words = { 'vim%.uv' } },
          },
        },
      },
      { 'Bilal2453/luvit-meta', lazy = true }, -- optional `vim.uv` typings
      { -- optional blink completion source for require statements and module annotations
        'saghen/blink.cmp',
        opts = {
          sources = {
            -- add lazydev to your completion providers
            default = { 'lazydev' },
            providers = {
              lazydev = {
                name = 'LazyDev',
                module = 'lazydev.integrations.blink',
                -- make lazydev completions top priority (see `:h blink.cmp`)
                score_offset = 100,
              },
            },
          },
        },
      },
    },
    ft = { 'lua' },
    opts = function(_, opts)
      opts.servers['lua_ls'] = {
        settings = {
          Lua = {
            runtime = {
              -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
              version = 'LuaJIT',
            },
            workspace = {
              checkThirdParty = false,
            },
            codeLens = {
              enable = true,
            },
            completion = {
              callSnippet = 'Replace',
            },
            doc = {
              privateName = { '^_' },
            },
            hint = {
              enable = true,
              setType = false,
              paramType = true,
              paramName = 'Disable',
              semicolon = 'Disable',
              arrayIndex = 'Disable',
            },
          },
        },
      }
    end,
  },
  {
    'nvimtools/none-ls.nvim',
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
