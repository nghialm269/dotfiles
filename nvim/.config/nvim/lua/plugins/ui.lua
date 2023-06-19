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
          fidget = true,
          gitsigns = true,
          lsp_saga = true,
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
          },
          treesitter = true,
          telescope = true,
          which_key = true,
        },
      })

      vim.cmd.colorscheme 'catppuccin'
    end,
  },
  {
    'mawkler/modicator.nvim',
    dependencies = {
      'catppuccin',
    },
    opts = {},
  }
}
