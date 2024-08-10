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
          fzf = true,
          gitsigns = true,
          grug_far = true,
          harpoon = true,
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
          dap = true,
          dap_ui = true,
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
          which_key = false,
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
          backend = { 'fzf_lua', 'telescope', 'fzf', 'builtin', 'nui' },
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
              namespace = { 'diagnostic/signs' },
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
            sign = {
              name = { '^Dap' },
              maxwidth = 1,
              colwidth = 1,
              auto = true,
              wrap = false,
            },
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
          {
            text = { builtin.foldfunc },
            click = 'v:lua.ScFa',
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
    'shellRaining/hlchunk.nvim',
    event = { 'UIEnter' },
    config = function()
      require('hlchunk').setup({
        chunk = {
          enable = true,
        },
        indent = {
          enable = true,
        },
        line_num = {
          enable = true,
        },
        blank = {
          enable = true,
        },
      })
    end,
  },

  {
    'j-hui/fidget.nvim',
    config = function()
      local fidget = require('fidget')
      local display = require('fidget.progress.display')
      fidget.setup({
        progress = {
          -- ignore_done_already = true,
          display = {
            format_message = function(msg)
              if msg.lsp_client.config.name == 'null-ls' and msg.title == 'code_action' then
                -- vim.notify(vim.inspect(msg))
                return nil
              end
              return display.default_format_message(msg)
            end,
          },
        },
        notification = {
          override_vim_notify = true,
          window = {
            winblend = 0,
          },
        },
      })
    end,
  },
  {
    'rasulomaroff/reactive.nvim',
    dependencies = {
      {
        'catppuccin/nvim',
        name = 'catppuccin',
      },
    },
    opts = {
      load = { 'catppuccin-mocha-cursor', 'catppuccin-mocha-cursorline' },
    },
  },
  {
    'grapp-dev/nui-components.nvim',
    dependencies = {
      'MunifTanjim/nui.nvim',
    },
  },
}
