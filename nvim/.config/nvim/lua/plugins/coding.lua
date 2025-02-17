return {
  {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    -- dependencies = 'rafamadriz/friendly-snippets',

    -- use a release tag to download pre-built binaries
    version = '*',
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    opts_extend = { 'sources.default' },

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' for mappings similar to built-in completion
      -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
      -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
      -- See the full "keymap" documentation for information on defining your own keymap.
      keymap = { preset = 'default' },

      appearance = {
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
      },

      signature = { enabled = true },

      snippets = { preset = 'luasnip' },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
    },
  },
  {
    'altermo/ultimate-autopair.nvim',
    event = { 'InsertEnter', 'CmdlineEnter' },
    branch = 'v0.6', --recommended as each new version will have breaking changes
    opts = {
      { '**', '**', ft = { 'markdown' }, multiline = false },
      { '*', '*', ft = { 'markdown' }, multiline = false },
      { '_', '_', ft = { 'markdown' }, multiline = false },
      fastwarp = {
        map = '<C-f>',
        cmap = '<C-f>',
      },
    },
  },
  {
    'kylechui/nvim-surround',
    version = '*',
    event = 'VeryLazy',
    opts = {},
  },
  {
    'Wansmer/treesj',
    keys = { 'gS' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {
      use_default_keymaps = false,
      max_join_length = 500,
    },
    config = function(_, opts)
      local treesj = require('treesj')
      treesj.setup(opts)
      vim.keymap.set('n', 'gS', treesj.toggle, { desc = 'Toggle split/join' })
    end,
  },
}
