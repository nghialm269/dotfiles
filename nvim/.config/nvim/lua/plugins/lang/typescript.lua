return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        'javascript',
        'typescript',
        'tsx',
      })
    end,
  },
  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    opts = {
      settings = {
        tsserver_file_preferences = {
          includeInlayParameterNameHints = 'all',
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayVariableTypeHintsWhenTypeMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
    },
  },

  {
    'neovim/nvim-lspconfig',
    -- other settings removed for brevity
    opts = {
      ---@type lspconfig.options
      servers = {
        eslint = {
          settings = {
            -- helps eslint find the eslintrc when it's placed in a subfolder instead of the cwd root
            workingDirectory = { mode = 'auto' },
          },
        },
      },
      setup = {
        eslint = function()
          vim.api.nvim_create_autocmd('BufWritePre', {
            callback = function(event)
              if not require('plugins.lsp.format').enabled() then
                -- exit early if autoformat is not enabled
                return
              end

              local client = vim.lsp.get_clients({ bufnr = event.buf, name = 'eslint' })[1]
              if client then
                local diag = vim.diagnostic.get(
                  event.buf,
                  { namespace = vim.lsp.diagnostic.get_namespace(client.id) }
                )
                if #diag > 0 then
                  vim.cmd('EslintFixAll')
                end
              end
            end,
          })
        end,
      },
    },
  },

  {
    'jose-elias-alvarez/null-ls.nvim',
    dependencies = {
      {
        'vuki656/package-info.nvim',
        dependencies = 'MunifTanjim/nui.nvim',
        opts = {
          package_manager = 'npm',
        },
      },
    },
    opts = function(_, opts)
      local nls = require('null-ls')

      vim.list_extend(opts.sources, {
        nls.builtins.formatting.prettierd,
        require('null-ls.helpers').make_builtin({
          name = 'package-info',
          method = nls.methods.CODE_ACTION,
          filetypes = { 'json' },
          generator = {
            fn = function(params)
              local state = require('package-info.state')
              local is_in_dependency = require('package-info.helpers.get_dependency_name_from_line')(
                params.content[params.row]
              ) ~= nil

              local actions = {
                {
                  title = 'Show latest versions',
                  command = 'show',
                  args = {},
                  condition = state.is_loaded and not state.is_virtual_text_displayed,
                },
                {
                  title = 'Force refresh package versions',
                  command = 'show',
                  args = { force = true },
                  condition = state.is_loaded,
                },
                {
                  title = 'Hide latest versions',
                  command = 'hide',
                  args = {},
                  condition = state.is_loaded and state.is_virtual_text_displayed,
                },
                {
                  title = 'Delete package',
                  command = 'delete',
                  args = {},
                  condition = state.is_loaded and is_in_dependency,
                },
                {
                  title = 'Change package version',
                  command = 'change_version',
                  args = {},
                  condition = state.is_loaded and is_in_dependency,
                },
                {
                  title = 'Install package',
                  command = 'install',
                  args = {},
                  condition = state.is_in_project,
                },
                {
                  title = 'Update package',
                  command = 'update',
                  args = {},
                  condition = state.is_loaded and is_in_dependency,
                },
              }

              return vim.tbl_map(
                function(action)
                  return {
                    title = action.title,
                    action = function()
                      require('package-info')[action.command](action.args)
                    end,
                  }
                end,
                vim.tbl_filter(function(action)
                  return action.condition
                end, actions)
              )
            end,
          },
        }),
      })
    end,
  },
  {
    'mfussenegger/nvim-dap',
    optional = true,
    dependencies = {
      {
        'williamboman/mason.nvim',
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          -- vim.list_extend(opts.ensure_installed, { 'delve' })
          table.insert(opts.ensure_installed, 'js-debug-adapter')
        end,
      },
      {
        'mxsdev/nvim-dap-vscode-js',
        config = function()
          require('dap-vscode-js').setup({
            -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
            -- debugger_path = "(runtimedir)/site/pack/packer/opt/vscode-js-debug", -- Path to vscode-js-debug installation.
            -- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
            adapters = {
              'pwa-node',
              'pwa-chrome',
              'pwa-msedge',
              'node-terminal',
              'pwa-extensionHost',
            }, -- which adapters to register in nvim-dap
          })

          local dap = require('dap')
          for _, language in ipairs({
            'typescript',
            'javascript',
            'javascriptreact',
            'typescriptreact',
          }) do
            dap.configurations[language] = {
              {
                type = 'pwa-node',
                request = 'launch',
                name = 'Launch file',
                program = '${file}',
                cwd = '${workspaceFolder}',
              },
              {
                type = 'pwa-node',
                request = 'attach',
                name = 'Attach',
                processId = require('dap.utils').pick_process,
                cwd = '${workspaceFolder}',
              },
              {
                type = 'pwa-node',
                request = 'launch',
                name = 'Debug Mocha Tests',
                -- trace = true, -- include debugger info
                runtimeExecutable = 'node',
                runtimeArgs = {
                  './node_modules/mocha/bin/mocha.js',
                },
                rootPath = '${workspaceFolder}',
                cwd = '${workspaceFolder}',
                console = 'integratedTerminal',
                internalConsoleOptions = 'neverOpen',
              },
              {
                type = 'pwa-node',
                request = 'launch',
                name = 'Debug Jest Tests',
                -- trace = true, -- include debugger info
                runtimeExecutable = 'node',
                runtimeArgs = {
                  './node_modules/jest/bin/jest.js',
                  '--runInBand',
                },
                rootPath = '${workspaceFolder}',
                cwd = '${workspaceFolder}',
                console = 'integratedTerminal',
                internalConsoleOptions = 'neverOpen',
              },
            }
          end

          -- https://github.com/anasrar/.dotfiles/blob/b973e76cfa88d589092f280f20bcb9541a763678/neovim/.config/nvim/lua/rin/DAP/languages/typescript.lua#L84
          -- local exts = {
          --   'javascript',
          --   'typescript',
          --   'javascriptreact',
          --   'typescriptreact',
          --   -- using pwa-chrome
          --   'vue',
          --   'svelte',
          -- }

          -- for i, ext in ipairs(exts) do
          --   dap.configurations[ext] = {
          --     {
          --       type = 'pwa-node',
          --       request = 'launch',
          --       name = 'Launch Current File (pwa-node)',
          --       cwd = vim.fn.getcwd(),
          --       args = { '${file}' },
          --       sourceMaps = true,
          --       protocol = 'inspector',
          --     },
          --     {
          --       type = 'pwa-node',
          --       request = 'launch',
          --       name = 'Launch Current File (pwa-node with ts-node)',
          --       cwd = vim.fn.getcwd(),
          --       runtimeArgs = { '--loader', 'ts-node/esm' },
          --       runtimeExecutable = 'node',
          --       args = { '${file}' },
          --       sourceMaps = true,
          --       protocol = 'inspector',
          --       skipFiles = { '<node_internals>/**', 'node_modules/**' },
          --       resolveSourceMapLocations = {
          --         '${workspaceFolder}/**',
          --         '!**/node_modules/**',
          --       },
          --     },
          --     {
          --       type = 'pwa-node',
          --       request = 'launch',
          --       name = 'Launch Current File (pwa-node with deno)',
          --       cwd = vim.fn.getcwd(),
          --       runtimeArgs = { 'run', '--inspect-brk', '--allow-all', '${file}' },
          --       runtimeExecutable = 'deno',
          --       attachSimplePort = 9229,
          --     },
          --     {
          --       type = 'pwa-node',
          --       request = 'launch',
          --       name = 'Launch Test Current File (pwa-node with jest)',
          --       cwd = vim.fn.getcwd(),
          --       runtimeArgs = { '${workspaceFolder}/node_modules/.bin/jest' },
          --       runtimeExecutable = 'node',
          --       args = { '${file}', '--coverage', 'false' },
          --       rootPath = '${workspaceFolder}',
          --       sourceMaps = true,
          --       console = 'integratedTerminal',
          --       internalConsoleOptions = 'neverOpen',
          --       skipFiles = { '<node_internals>/**', 'node_modules/**' },
          --     },
          --     {
          --       type = 'pwa-node',
          --       request = 'launch',
          --       name = 'Launch Test Current File (pwa-node with vitest)',
          --       cwd = vim.fn.getcwd(),
          --       program = '${workspaceFolder}/node_modules/vitest/vitest.mjs',
          --       args = { '--inspect-brk', '--threads', 'false', 'run', '${file}' },
          --       autoAttachChildProcesses = true,
          --       smartStep = true,
          --       console = 'integratedTerminal',
          --       skipFiles = { '<node_internals>/**', 'node_modules/**' },
          --     },
          --     {
          --       type = 'pwa-node',
          --       request = 'launch',
          --       name = 'Launch Test Current File (pwa-node with deno)',
          --       cwd = vim.fn.getcwd(),
          --       runtimeArgs = { 'test', '--inspect-brk', '--allow-all', '${file}' },
          --       runtimeExecutable = 'deno',
          --       smartStep = true,
          --       console = 'integratedTerminal',
          --       attachSimplePort = 9229,
          --     },
          --     {
          --       type = 'pwa-chrome',
          --       request = 'attach',
          --       name = 'Attach Program (pwa-chrome, select port)',
          --       program = '${file}',
          --       cwd = vim.fn.getcwd(),
          --       sourceMaps = true,
          --       port = function()
          --         return vim.fn.input('Select port: ', 9222)
          --       end,
          --       webRoot = '${workspaceFolder}',
          --     },
          --     -- {
          --     --   type = "node2",
          --     --   request = "attach",
          --     --   name = "Attach Program (Node2)",
          --     --   processId = dap_utils.pick_process,
          --     -- },
          --     -- {
          --     --   type = "node2",
          --     --   request = "attach",
          --     --   name = "Attach Program (Node2 with ts-node)",
          --     --   cwd = vim.fn.getcwd(),
          --     --   sourceMaps = true,
          --     --   skipFiles = { "<node_internals>/**" },
          --     --   port = 9229,
          --     -- },
          --     {
          --       type = 'pwa-node',
          --       request = 'attach',
          --       name = 'Attach Program (pwa-node, select pid)',
          --       cwd = vim.fn.getcwd(),
          --       processId = dap_utils.pick_process,
          --       skipFiles = { '<node_internals>/**' },
          --     },
          --   }
          -- end
        end,
      },
    },
  },
}
