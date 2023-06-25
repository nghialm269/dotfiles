return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      require("catppuccin").setup({
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
        integrations = {
          dropbar = {
            enabled = true,
            color_mode = false, -- enable color for kind's texts, not just kind's icons
          },
          fidget = true,
          gitsigns = true,
          indent_blankline = {
            enabled = true,
            colored_indent_levels = false,
          },
          mason = true,
          neotree = true,
          neotest = true,
          cmp = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "underline" },
              hints = { "underline" },
              warnings = { "underline" },
              information = { "underline" },
            },
            inlay_hints = {
              background = true,
            },
          },
          semantic_tokens = true,
          treesitter = true,
          telescope = {
            enabled = true,
            style = "nvchad",
          },
          lsp_trouble = true,
          which_key = true,
        },
      })

      vim.cmd.colorscheme 'catppuccin'
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
          default_prompt = "Input:",
          title_pos = "center",
          insert_only = false,
          start_in_insert = true,
          -- Set to `false` to disable
          mappings = {
            n = {
              ["<Esc>"] = "Close",
              ["q"] = "Close",
              ["<CR>"] = "Confirm",
            },
            i = {
              ["<C-c>"] = "Close",
              ["<CR>"] = "Confirm",
              ["<Up>"] = "HistoryPrev",
              ["<Down>"] = "HistoryNext",
            },
          },
        },
        select = {
          -- Set to false to disable the vim.ui.select implementation
          enabled = true,
          -- Priority list of preferred vim.select implementations
          backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },
          trim_prompt = true,
          telescope = require("telescope.themes").get_cursor(),
        },
      })
    end
  },
  {
    'mawkler/modicator.nvim',
    dependencies = {
      'catppuccin',
    },
    opts = {},
  },
  {
    "luukvbaal/statuscol.nvim",
    config = function()
      local builtin = require("statuscol.builtin")
      require("statuscol").setup({
        relculright = true,
        segments = {
          {
            text = { builtin.foldfunc },
            click = "v:lua.ScFa"
          },
          {
            sign = { name = { "^GitSigns" }, maxwidth = 1, colwidth = 1, auto = false, wrap = true },
            click = "v:lua.ScSa"
          },
          {
            sign = { name = { "^DiagnosticSign" }, maxwidth = 1, colwidth = 2, auto = false, wrap = false },
            click = "v:lua.ScSa"
          },
          {
            sign = { name = { ".*" }, maxwidth = 2, colwidth = 2, auto = false, wrap = false },
            click = "v:lua.ScSa"
          },
          {
            text = { builtin.lnumfunc, " " },
            condition = { true, builtin.not_empty },
            click = "v:lua.ScLa",
          },
          {
            sign = { name = { "^coverage_" }, maxwidth = 1, colwidth = 1, auto = true, wrap = true },
            click = "v:lua.ScSa"
          },
        },
        ft_ignore = { "neo-tree", "qf" },
      })
    end,
  },
  { 'Bekaboo/dropbar.nvim' },
}
