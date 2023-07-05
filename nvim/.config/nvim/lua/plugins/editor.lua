return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = 'Neotree',
    keys = {
      { "<leader>ef", "<cmd>Neotree toggle=true reveal=true position=right<cr>", desc = "NeoTree Files" },
      {
        "<leader>es",
        "<cmd>Neotree toggle=true reveal=true position=right document_symbols<cr>",
        desc = "NeoTree Document Symbols"
      },
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
      open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "Outline" },
      sources = { "filesystem", "buffers", "git_status" },
      source_selector = {
        winbar = true,
        statusline = false,
        sources = {
          { source = "filesystem", display_name = "󰉓 Files" },
          { source = "buffers",    display_name = "󰈙 Buffers" },
          { source = "git_status", display_name = "󰊢 Git" },
        },
      },
      window = {
        mappings = {
          ["<cr>"] = "open_with_window_picker",
          ["<C-v>"] = "vsplit_with_window_picker",
          ["<C-x>"] = "split_with_window_picker",
          ["<C-t>"] = "open_tabnew",
          ["<space>"] = "none",
        }
      },
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = true,
        use_libuv_file_watcher = true,
      },
      default_component_configs = {
        indent = {
          with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
        icon = {
          folder_empty = "󰜌",
          folder_empty_open = "󰜌",
        },
        git_status = {
          symbols = {
            renamed = "󰁕",
            unstaged = "󰄱",
          },
        },
      },
    },
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {
      modes = {
        char = {
          keys = { "f", "F", "t", "T", [";"] = "L", [","] = "H" },
        }
      }
    },
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          -- default options: exact mode, multi window, all directions, with a backdrop
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "o", --[[ "x" ]] },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
    },
  },
}
