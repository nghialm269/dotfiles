return {
  {
    'NeogitOrg/neogit',
    dependencies = 'nvim-lua/plenary.nvim',
    cmd = "Neogit",
  },

  {
    "ruifm/gitlinker.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    keys = {
      {
        "<leader>gy",
        function()
          require 'gitlinker'.get_buf_range_url('n')
        end,
        desc = "Git: Copy permalinks to the current line"
      },
      {
        mode = { "v" },
        "<leader>gy",
        function()
          require 'gitlinker'.get_buf_range_url('v')
        end,
        desc = "Git: Copy permalinks to the selected lines"
      },
      {
        "<leader>go",
        function()
          require "gitlinker".get_buf_range_url("n", { action_callback = require "gitlinker.actions".open_in_browser })
        end,
        desc = "Git: Open permalinks to the current line"
      },
      {
        mode = { "v" },
        "<leader>go",
        function()
          require "gitlinker".get_buf_range_url("v", { action_callback = require "gitlinker.actions".open_in_browser })
        end,
        desc = "Git: Open permalinks to the selected lines"
      },
      {
        "<leader>gY",
        function()
          require "gitlinker".get_repo_url()
        end,
        desc = "Git: Copy repo url"
      },
      {
        "<leader>gO",
        function()
          require "gitlinker".get_repo_url({ action_callback = require "gitlinker.actions".open_in_browser })
        end,
        desc = "Git: Open repo url"
      },
    },
    setup = function()
      local wk = require("which-key")
      wk.register({
        y = "gitlinker: copy url",
        o = "gitlinker: open url",
      }, { mode = "n", prefix = "<leader>g" })
    end,
    opts = {
      mappings = nil,
    },
  },

  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
      { "<leader>gdd",  "<cmd>DiffviewOpen<CR>",          desc = "Git: Diffview - diff HEAD" },
      { "<leader>gdhb", "<cmd>DiffviewFileHistory<CR>",   desc = "Git: Diffview - current branch history" },
      { "<leader>gdhh", "<cmd>DiffviewFileHistory %<CR>", desc = "Git: Diffview - current file history" },
      {
        mode = { "v" },
        "<leader>gdh",
        ":DiffviewFileHistory<CR>",
        desc = "Git: Diffview - selected lines history",
      },
      -- https://old.reddit.com/r/neovim/comments/11ls23z/what_is_your_nvim_workflow_for_reviewing_prs/jbf6ifd/
      {
        "<leader>gdrb",
        function()
          -- "<cmd>DiffviewOpen origin/main... --imply-local<CR>"
          local main_branch = vim.fn.system("git symbolic-ref refs/remotes/origin/HEAD | cut -d'/' -f4 | tr -d '\n'")
          print(main_branch)
          print("DiffviewOpen origin/" .. main_branch .. "... --imply-local")
          vim.cmd("DiffviewOpen origin/" .. main_branch .. "... --imply-local")
        end,
        desc = "Git: Diffview - review feature branch"
      },
      {
        "<leader>gdrc",
        function()
          -- "<cmd>DiffviewFileHistory --range=origin/main...<CR>"
          local main_branch = vim.fn.system("git symbolic-ref refs/remotes/origin/HEAD | cut -d'/' -f4 | tr -d '\n'")
          vim.cmd("DiffviewFileHistory --range=origin/" .. main_branch .. "...")
        end,
        desc = "Git: Diffview - review feature branch commits"
      },
    },
    opts = {
      enhanced_diff_hl = true,
      key_bindings = {
        file_panel = { q = "<cmd>DiffviewClose<CR>" },
        file_history_panel = { q = "<cmd>DiffviewClose<CR>" },
        -- view = { q = "<cmd>DiffviewClose<CR>" },
      },
      view = {
        merge_tool = {
          layout = "diff3_mixed",
          disable_diagnostics = true, -- Temporarily disable diagnostics for conflict buffers while in the view.
        },
      },
    },
  },

  {
    'lewis6991/gitsigns.nvim',
    opts = {
      -- signs = {
      --   add = { text = '+' },
      --   change = { text = '~' },
      --   delete = { text = '_' },
      --   topdelete = { text = '‾' },
      --   changedelete = { text = '~' },
      -- },
    },
  },
}
