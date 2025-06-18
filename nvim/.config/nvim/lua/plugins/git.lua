return {
  {
    'NeogitOrg/neogit',
    dependencies = 'nvim-lua/plenary.nvim',
    cmd = 'Neogit',
    opts = {},
  },
  {
    'sindrets/diffview.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
    keys = {
      { '<leader>gdd', '<cmd>DiffviewOpen<CR>', desc = 'Git: Diffview - diff HEAD' },
      {
        '<leader>gdhb',
        '<cmd>DiffviewFileHistory<CR>',
        desc = 'Git: Diffview - current branch history',
      },
      {
        '<leader>gdhh',
        '<cmd>DiffviewFileHistory %<CR>',
        desc = 'Git: Diffview - current file history',
      },
      {
        mode = { 'v' },
        '<leader>gdh',
        ':DiffviewFileHistory<CR>',
        desc = 'Git: Diffview - selected lines history',
      },
      -- https://old.reddit.com/r/neovim/comments/11ls23z/what_is_your_nvim_workflow_for_reviewing_prs/jbf6ifd/
      {
        '<leader>gdrb',
        function()
          -- "<cmd>DiffviewOpen origin/main... --imply-local<CR>"
          local main_branch =
            vim.fn.system("git symbolic-ref refs/remotes/origin/HEAD | cut -d'/' -f4 | tr -d '\n'")
          vim.cmd('DiffviewOpen origin/' .. main_branch .. '... --imply-local')
        end,
        desc = 'Git: Diffview - review feature branch',
      },
      {
        '<leader>gdrc',
        function()
          -- "<cmd>DiffviewFileHistory --range=origin/main...<CR>"
          local main_branch =
            vim.fn.system("git symbolic-ref refs/remotes/origin/HEAD | cut -d'/' -f4 | tr -d '\n'")
          vim.cmd('DiffviewFileHistory --range=origin/' .. main_branch .. '...')
        end,
        desc = 'Git: Diffview - review commits',
      },
    },
    opts = {
      enhanced_diff_hl = true,
      key_bindings = {
        file_panel = { q = '<cmd>DiffviewClose<CR>' },
        file_history_panel = { q = '<cmd>DiffviewClose<CR>' },
        -- view = { q = "<cmd>DiffviewClose<CR>" },
      },
      view = {
        merge_tool = {
          layout = 'diff3_mixed',
          disable_diagnostics = true, -- Temporarily disable diagnostics for conflict buffers while in the view.
        },
      },
    },
  },

  {
    'lewis6991/gitsigns.nvim',
    event = 'VeryLazy',
    keys = {
      {
        '<leader>gdi',
        function()
          local gs = require('gitsigns')
          gs.toggle_deleted()
          gs.toggle_linehl()
          gs.toggle_word_diff()
        end,
        desc = 'Git: gitsigns: diff inline',
      },
      {
        '[h',
        function()
          local gs = require('gitsigns')
          if vim.wo.diff then
            vim.cmd.normal({ '[c', bang = true })
          else
            gs.nav_hunk('prev')
          end
        end,
        desc = 'Git: gitsigns: prev hunk',
      },
      {
        ']h',
        function()
          local gs = require('gitsigns')
          if vim.wo.diff then
            vim.cmd.normal({ ']c', bang = true })
          else
            gs.nav_hunk('next')
          end
        end,
        desc = 'Git: gitsigns: next hunk',
      },
      {
        '<leader>gb',
        function()
          require('gitsigns').blame_line({ full = true })
        end,
        desc = 'Git: gitsigns: blame line',
      },
    },
    opts = {},
  },
  {
    'FabijanZulj/blame.nvim',
    config = function()
      require('blame').setup()
    end,
  },
  {
    'folke/which-key.nvim',
    opts = {
      spec = {
        { '<leader>g', group = 'git' },
        { '<leader>gd', group = 'diff' },
        { '<leader>gdh', group = 'history' },
        { '<leader>gdr', group = 'review' },
      },
    },
  },
}
