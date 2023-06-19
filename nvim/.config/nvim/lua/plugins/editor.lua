return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = 'Neotree',
    keys = {
      { "<leader>ef", "<cmd>Neotree toggle=true reveal=true position=right<cr>", desc = "NeoTree" },
    },
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      {
        -- only needed if you want to use the commands with "_with_window_picker" suffix
        's1n7ax/nvim-window-picker',
        version = "2.*",
        opts = {
          -- hint = 'statusline-winbar',
          hint = 'floating-big-letter',
          filter_rules = {
            autoselect_one = true,
            include_current_win = false,
            -- filter using buffer options
            bo = {
              -- if the file type is one of following, the window will be ignored
              filetype = { 'neo-tree', "neo-tree-popup", "notify" },
              -- if the buffer type is one of following, the window will be ignored
              buftype = { 'terminal', "quickfix" },
            },
          },
        },
      }
    },
    init = function()
      vim.g.neo_tree_remove_legacy_commands = 1
    end,
    opts = {
      source_selector = {
        winbar = true,
        statusline = false,
      },
      window = {
        mappings = {
          ["<cr>"] = "open_with_window_picker",
          ["<C-v>"] = "vsplit_with_window_picker",
          ["<C-x>"] = "split_with_window_picker",
        }
      }
    },
  }
}
