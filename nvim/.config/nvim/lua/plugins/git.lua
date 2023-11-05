return {
  {
    'NeogitOrg/neogit',
    dependencies = 'nvim-lua/plenary.nvim',
    cmd = 'Neogit',
    opts = {},
  },
  {
    'ruifm/gitlinker.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    keys = {
      {
        '<leader>gy',
        function()
          require('gitlinker').get_buf_range_url('n')
        end,
        desc = 'Git: Copy permalinks to the current line',
      },
      {
        mode = { 'v' },
        '<leader>gy',
        function()
          require('gitlinker').get_buf_range_url('v')
        end,
        desc = 'Git: Copy permalinks to the selected lines',
      },
      {
        '<leader>go',
        function()
          require('gitlinker').get_buf_range_url(
            'n',
            { action_callback = require('gitlinker.actions').open_in_browser }
          )
        end,
        desc = 'Git: Open permalinks to the current line',
      },
      {
        mode = { 'v' },
        '<leader>go',
        function()
          require('gitlinker').get_buf_range_url(
            'v',
            { action_callback = require('gitlinker.actions').open_in_browser }
          )
        end,
        desc = 'Git: Open permalinks to the selected lines',
      },
      {
        '<leader>gY',
        function()
          require('gitlinker').get_repo_url()
        end,
        desc = 'Git: Copy repo url',
      },
      {
        '<leader>gO',
        function()
          require('gitlinker').get_repo_url({
            action_callback = require('gitlinker.actions').open_in_browser,
          })
        end,
        desc = 'Git: Open repo url',
      },
    },
    opts = {
      mappings = nil,
    },
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
          require('gitsigns').prev_hunk()
        end,
        desc = 'Git: gitsigns: prev hunk',
      },
      {
        ']h',
        function()
          require('gitsigns').next_hunk()
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
    'echasnovski/mini.clue',
    opts = function(_, opts)
      opts.triggers = opts.triggers or {}
      vim.list_extend(opts.triggers, {
        { mode = 'n', keys = ']' },
        { mode = 'n', keys = '[' },
      })

      opts.clues = opts.clues or {}
      vim.list_extend(opts.clues, {
        { mode = 'n', keys = '<leader>g', desc = '+git' },
        { mode = 'n', keys = '<leader>gd', desc = '+diff' },
        { mode = 'n', keys = '<leader>gdh', desc = '+history' },
        { mode = 'n', keys = '<leader>gdr', desc = '+review' },
        { mode = 'n', keys = ']h', postkeys = ']' },
        { mode = 'n', keys = '[h', postkeys = '[' },
      })
    end,
  },
}
