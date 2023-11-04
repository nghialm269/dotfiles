return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup({
        custom_highlights = function(colors)
          return {
            NormalMode = { fg = colors.blue },
            InsertMode = { fg = colors.green },
            VisualMode = { fg = colors.mauve },
            CommandMode = { fg = colors.peach },
            ReplaceMode = { fg = colors.red },
            SelectMode = { fg = colors.mauve },
            TerminalMode = { fg = colors.green },
            TerminalNormalMode = { fg = colors.blue },
          }
        end,
        dim_inactive = {
          enabled = true, -- dims the background color of inactive window
          shade = 'dark',
          percentage = 0.15, -- percentage of the shade to apply to the inactive window
        },
        integrations = {
          dropbar = {
            enabled = true,
            color_mode = true, -- enable color for kind's texts, not just kind's icons
          },
          fidget = true,
          flash = true,
          gitsigns = true,
          indent_blankline = {
            enabled = true,
            colored_indent_levels = false,
          },
          lsp_saga = true,
          mason = true,
          mini = {
            enabled = true,
            indentscope_color = 'lavender', -- catppuccin color (eg. `lavender`) Default: text
          },
          neotree = true,
          neogit = true,
          neotest = true,
          cmp = true,
          dap = {
            enabled = true,
            enable_ui = true, -- enable nvim-dap-ui
          },
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { 'italic' },
              hints = { 'italic' },
              warnings = { 'italic' },
              information = { 'italic' },
            },
            underlines = {
              errors = { 'underline' },
              hints = { 'underline' },
              warnings = { 'underline' },
              information = { 'underline' },
            },
            inlay_hints = {
              background = true,
            },
          },
          notify = true,
          semantic_tokens = true,
          treesitter = true,
          window_picker = true,
          overseer = true,
          rainbow_delimiters = true,
          telescope = {
            enabled = true,
            style = 'nvchad',
          },
          lsp_trouble = true,
          illuminate = true,
          which_key = true,
        },
      })

      vim.cmd.colorscheme('catppuccin')
    end,
  },
  {
    'stevearc/dressing.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      require('dressing').setup({
        input = {
          enabled = true,
          default_prompt = 'Input:',
          title_pos = 'center',
          insert_only = false,
          start_in_insert = true,
          -- Set to `false` to disable
          mappings = {
            n = {
              ['<Esc>'] = 'Close',
              ['q'] = 'Close',
              ['<CR>'] = 'Confirm',
            },
            i = {
              ['<C-c>'] = 'Close',
              ['<CR>'] = 'Confirm',
              ['<Up>'] = 'HistoryPrev',
              ['<Down>'] = 'HistoryNext',
            },
          },
        },
        select = {
          -- Set to false to disable the vim.ui.select implementation
          enabled = true,
          -- Priority list of preferred vim.select implementations
          backend = { 'telescope', 'fzf_lua', 'fzf', 'builtin', 'nui' },
          trim_prompt = true,
          telescope = require('telescope.themes').get_cursor(),
        },
      })
    end,
  },
  {
    'luukvbaal/statuscol.nvim',
    config = function()
      local builtin = require('statuscol.builtin')
      require('statuscol').setup({
        relculright = true,
        segments = {
          {
            text = { builtin.foldfunc },
            click = 'v:lua.ScFa',
          },
          {
            sign = {
              namespace = { 'gitsigns' },
              maxwidth = 1,
              colwidth = 1,
              auto = false,
              wrap = true,
            },
            click = 'v:lua.ScSa',
          },
          {
            sign = {
              name = { '^DiagnosticSign' },
              maxwidth = 1,
              colwidth = 2,
              auto = false,
              wrap = false,
            },
            click = 'v:lua.ScSa',
          },
          {
            sign = { name = { '.*' }, maxwidth = 2, colwidth = 2, auto = false, wrap = false },
            click = 'v:lua.ScSa',
          },
          {
            sign = { name = { '^Dap' }, maxwidth = 1, colwidth = 1, auto = true, wrap = false },
            click = 'v:lua.ScSa',
          },
          {
            text = { builtin.lnumfunc, ' ' },
            condition = { true, builtin.not_empty },
            click = 'v:lua.ScLa',
          },
          {
            sign = { name = { '^coverage_' }, maxwidth = 1, colwidth = 1, auto = true, wrap = true },
            click = 'v:lua.ScSa',
          },
        },
        ft_ignore = { 'neo-tree', 'qf' },
      })
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        theme = 'catppuccin',
        icons_enabled = true,
        component_separators = '|',
        section_separators = '',
        globalstatus = true,
      },
      extensions = { 'lazy', 'neo-tree', 'nvim-dap-ui', 'overseer', 'quickfix', 'trouble' },
    },
  },
  {
    'Bekaboo/dropbar.nvim',
    opts = {
      custom_sources = {},
    },
    config = function(_, opts)
      local default_opts = require('dropbar.configs').opts
      local default_enable = default_opts.general.enable
      local default_sources = default_opts.bar.sources

      require('dropbar').setup({
        general = {
          enable = function(buf, win)
            return opts.custom_sources[vim.bo[buf].ft] or default_enable(buf, win)
          end,
        },
        bar = {
          sources = function(buf, win)
            local custom_sources = opts.custom_sources[vim.bo[buf].ft]
            if custom_sources then
              return {
                {
                  get_symbols = custom_sources,
                },
              }
            end

            return default_sources(buf, win)
          end,
        },
      })
    end,
  },

  { 'hiphish/rainbow-delimiters.nvim' },

  {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    main = 'ibl',
    opts = {
      indent = {
        char = '│',
        tab_char = '│',
      },
      exclude = {
        filetypes = {
          'lspinfo',
          'packer',
          'checkhealth',
          'help',
          'man',
          'gitcommit',
          'TelescopePrompt',
          'TelescopeResults',
          '',
          'alpha',
          'dashboard',
          'neo-tree',
          'Trouble',
          'lazy',
          'mason',
          'notify',
          'toggleterm',
          'lazyterm',
          'sagafinder',
        },
      },
      scope = { enabled = false },
    },
  },
  {
    'echasnovski/mini.indentscope',
    version = '*',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      symbol = '│',
      options = { try_as_border = true },
    },
    init = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = {
          'help',
          'alpha',
          'dashboard',
          'neo-tree',
          'Trouble',
          'lazy',
          'mason',
          'notify',
          'toggleterm',
          'lazyterm',
          'sagafinder',
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },
  {
    'rcarriga/nvim-notify',
    event = 'VeryLazy',
    keys = {
      {
        '<leader>nd',
        function()
          require('notify').dismiss({ silent = true, pending = true })
        end,
        desc = 'Dismiss all Notifications',
      },
    },
    opts = {
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      -- top_down = false,
    },
    init = function()
      vim.notify = require('notify')
    end,
  },
  {
    'j-hui/fidget.nvim',
    branch = 'legacy',
    opts = {
      window = {
        blend = 0,
      },
    },
  },
  -- {
  --   "nvim-zh/colorful-winsep.nvim",
  --   opts = {},
  --   event = { "WinNew" },
  -- },
}
