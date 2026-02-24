return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'mason.nvim',
      'mason-org/mason-lspconfig.nvim',
      'saghen/blink.cmp',
    },
    ---@class PluginLspOpts
    opts = {
      -- options for vim.diagnostic.config()
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = 'if_many',
          prefix = '●',
          -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
          -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
          -- prefix = "icons",
        },
        severity_sort = true,
      },
      -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
      -- Be aware that you also will need to properly configure your LSP server to
      -- provide the inlay hints.
      inlay_hints = {
        enabled = true,
      },
      -- add any global capabilities here
      capabilities = {},
      -- Automatically format on save
      autoformat = true,
      -- Enable this to show formatters used in a notification
      -- Useful for debugging formatter issues
      format_notify = true,
      -- options for vim.lsp.buf.format
      -- `bufnr` and `filter` is handled by the LazyVim formatter,
      -- but can be also overridden when specified
      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },
      -- LSP Server Settings
      ---@type lspconfig.options
      servers = {},
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- example to setup with typescript.nvim
        -- tsserver = function(_, opts)
        --   require("typescript").setup({ server = opts })
        --   return true
        -- end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
    ---@param opts PluginLspOpts
    config = function(_, opts)
      local Util = require('util')
      -- setup autoformat
      require('plugins.lsp.format').setup(opts)
      -- setup formatting and keymaps
      Util.on_attach(function(client, buffer)
        require('plugins.lsp.keymaps').on_attach(client, buffer)

        if
          client.name ~= 'gopls' -- added in go.nvim
          or client.name ~= 'tsserver'
          or client.name ~= 'typescript-tools'
        then
          vim.api.nvim_buf_create_user_command(buffer, 'Format', function()
            require('plugins.lsp.format').format({ force = true })
          end, { desc = 'Format current buffer with LSP' })
        end
      end)

      local register_capability = vim.lsp.handlers['client/registerCapability']

      vim.lsp.handlers['client/registerCapability'] = function(err, res, ctx)
        local ret = register_capability(err, res, ctx)
        local client_id = ctx.client_id
        ---@type lsp.Client
        local client = vim.lsp.get_client_by_id(client_id)
        local buffer = vim.api.nvim_get_current_buf()
        require('plugins.lsp.keymaps').on_attach(client, buffer)
        return ret
      end

      -- diagnostics
      -- for name, icon in pairs(require("lazyvim.config").icons.diagnostics) do
      --   name = "DiagnosticSign" .. name
      --   vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
      -- end

      local inlay_hint = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint.enable

      if opts.inlay_hints.enabled and inlay_hint then
        Util.on_attach(function(client, buffer)
          if client.server_capabilities.inlayHintProvider then
            inlay_hint(true, { bufnr = buffer })
          end
        end)
      end

      -- if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
      --   opts.diagnostics.virtual_text.prefix = vim.fn.has("nvim-0.10.0") == 0 and "●"
      --       or function(diagnostic)
      --         local icons = require("lazyvim.config").icons.diagnostics
      --         for d, icon in pairs(icons) do
      --           if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
      --             return icon
      --           end
      --         end
      --       end
      -- end

      -- vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      local servers = opts.servers
      local capabilities = require('blink.cmp').get_lsp_capabilities(opts.capabilities)

      local function setup(server)
        local server_opts = vim.tbl_deep_extend('force', {
          capabilities = vim.deepcopy(capabilities),
        }, servers[server] or {})

        if opts.setup[server] then
          if opts.setup[server](server, server_opts) then
            return
          end
        elseif opts.setup['*'] then
          if opts.setup['*'](server, server_opts) then
            return
          end
        end
        vim.lsp.enable(server)
      end

      -- get all the servers that are available through mason-lspconfig
      local have_mason, mlsp = pcall(require, 'mason-lspconfig')
      local all_mslp_servers = {}
      if have_mason then
        all_mslp_servers =
          vim.tbl_keys(require('mason-lspconfig.mappings.server').lspconfig_to_package)
      end

      local ensure_installed = {} ---@type string[]
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
          if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
            setup(server)
          else
            ensure_installed[#ensure_installed + 1] = server
          end
        end
      end

      if have_mason then
        mlsp.setup({ ensure_installed = ensure_installed, handlers = { setup } })
      end

      if Util.lsp_get_config('denols') and Util.lsp_get_config('tsserver') then
        local is_deno = require('lspconfig.util').root_pattern('deno.json', 'deno.jsonc')
        Util.lsp_disable('tsserver', is_deno)
        Util.lsp_disable('denols', function(root_dir)
          return not is_deno(root_dir)
        end)
      end

      ---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
      local progress = vim.defaulttable()
      vim.api.nvim_create_autocmd('LspProgress', {
        ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
        callback = function(ev)
          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
          if not client or type(value) ~= 'table' then
            return
          end

          if client.name == 'null-ls' and value.title == 'code_action' then
            return
          end

          local p = progress[client.id]

          for i = 1, #p + 1 do
            if i == #p + 1 or p[i].token == ev.data.params.token then
              p[i] = {
                token = ev.data.params.token,
                msg = ('[%3d%%] %s%s'):format(
                  value.kind == 'end' and 100 or value.percentage or 100,
                  value.title or '',
                  value.message and (' **%s**'):format(value.message) or ''
                ),
                done = value.kind == 'end',
              }
              break
            end
          end

          local msg = {} ---@type string[]
          progress[client.id] = vim.tbl_filter(function(v)
            return table.insert(msg, v.msg) or not v.done
          end, p)

          local spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' }
          vim.notify(table.concat(msg, '\n'), 'info', {
            id = 'lsp_progress',
            title = client.name,
            opts = function(notif)
              notif.icon = #progress[client.id] == 0 and ' '
                or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
            end,
          })
        end,
      })
    end,
  },

  {
    'mason-org/mason.nvim',
    enabled = not vim.env.NIX_NEOVIM,
    cmd = 'Mason',
    opts = {
      ensure_installed = {},
    },
    ---@param opts MasonSettings | {ensure_installed: string[]}
    config = function(_, opts)
      require('mason').setup(opts)
      local mr = require('mason-registry')
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },

  {
    'nvimtools/none-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'nvim-lua/plenary.nvim',
    },

    opts = function()
      local nls = require('null-ls')
      return {
        root_dir = require('null-ls.utils').root_pattern(
          '.null-ls-root',
          '.neoconf.json',
          'Makefile',
          '.git'
        ),
        sources = {
          nls.builtins.code_actions.refactoring,
          nls.builtins.code_actions.gitrebase,
        },
      }
    end,
  },

  {
    'antosha417/nvim-lsp-file-operations',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-neo-tree/neo-tree.nvim',
    },
    config = function()
      require('lsp-file-operations').setup()
    end,
  },

  {
    'folke/which-key.nvim',
    opts = {
      spec = {
        { '<localleader>l', group = 'lsp' },
      },
    },
  },

  -- pin to v1 for nowAdd commentMore actions
  { 'mason-org/mason.nvim', enabled = not vim.env.NIX_NEOVIM, version = '^1.0.0' },
  { 'mason-org/mason-lspconfig.nvim', enabled = not vim.env.NIX_NEOVIM, version = '^1.0.0' },
}
