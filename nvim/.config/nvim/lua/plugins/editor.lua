return {
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {},
    config = function(_, opts)
      local wk = require('which-key')
      wk.setup(opts)
      wk.register(opts.defaults)
    end,
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    cmd = 'Neotree',
    keys = {
      {
        '<leader>ef',
        '<cmd>Neotree toggle=true reveal=true position=right<cr>',
        desc = 'NeoTree Files',
      },
      {
        '<leader>es',
        '<cmd>Neotree toggle=true reveal=true position=right document_symbols<cr>',
        desc = 'NeoTree Document Symbols',
      },
    },
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
      {
        -- only needed if you want to use the commands with "_with_window_picker" suffix
        's1n7ax/nvim-window-picker',
        version = '2.*',
        opts = {
          -- hint = 'statusline-winbar',
          hint = 'floating-big-letter',
          filter_rules = {
            autoselect_one = true,
            include_current_win = false,
            -- filter using buffer options
            bo = {
              -- if the file type is one of following, the window will be ignored
              filetype = { 'neo-tree', 'neo-tree-popup', 'notify' },
              -- if the buffer type is one of following, the window will be ignored
              buftype = { 'terminal', 'quickfix' },
            },
          },
        },
      },
    },
    opts = {
      open_files_do_not_replace_types = { 'terminal', 'Trouble', 'qf', 'Outline' },
      sources = { 'filesystem', 'buffers', 'git_status' },
      source_selector = {
        winbar = true,
        statusline = false,
        sources = {
          { source = 'filesystem' },
          { source = 'buffers' },
          { source = 'git_status' },
        },
      },
      window = {
        mappings = {
          ['<cr>'] = 'open_with_window_picker',
          ['<C-v>'] = 'vsplit_with_window_picker',
          ['<C-x>'] = 'split_with_window_picker',
          ['<C-t>'] = 'open_tabnew',
          ['l'] = 'none',
          ['gg'] = 'none',
        },
      },
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = {
          enabled = true,
        },
        use_libuv_file_watcher = true,
      },
      default_component_configs = {
        indent = {
          with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
        },
      },
    },
  },
  {
    'stevearc/overseer.nvim',
    cmd = {
      'OverseerOpen',
      'OverseerClose',
      'OverseerToggle',
      'OverseerRun',
      'OverseerRunCmd',
      'OverseerInfo',
      'OverseerBuild',
      'OverseerQuickAction',
      'OverseerTaskAction',
      'OverseerClearTask',
    },
    keys = {
      {
        '<leader>tt',
        function()
          require('overseer').toggle({ enter = false })
        end,
        desc = 'Overseer: Toggle Task List',
      },
      {
        '<leader>to',
        function()
          require('overseer').open({ enter = true })
        end,
        desc = 'Overseer: Open Task List',
      },
      {
        '<leader>tr',
        function()
          require('overseer').run_template()
        end,
        desc = 'Overseer: Run',
      },
    },
    opts = {
      task_list = {
        bindings = {
          ['o'] = 'RunAction',
          ['<CR>'] = 'IncreaseDetail',
          ['<BS>'] = 'DecreaseDetail',
          ['<C-l>'] = false,
          ['<C-h>'] = false,
          ['<C-k>'] = false,
          ['<C-j>'] = false,
        },
      },
    },
  },
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    ---@type Flash.Config
    opts = {
      modes = {
        char = {
          keys = {
            'f',
            'F',
            't',
            'T', --[[ [";"] = "L", [","] = "H" ]]
          },
        },
      },
    },
    keys = {
      {
        's',
        mode = { 'n', 'x', 'o' },
        function()
          -- default options: exact mode, multi window, all directions, with a backdrop
          require('flash').jump()
        end,
        desc = 'Flash',
      },
      {
        'S',
        mode = {
          'n',
          'o', --[[ "x" ]]
        },
        function()
          require('flash').treesitter()
        end,
        desc = 'Flash Treesitter',
      },
      {
        'r',
        mode = 'o',
        function()
          require('flash').remote()
        end,
        desc = 'Remote Flash',
      },
    },
  },
  {
    'mizlan/iswap.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'tpope/vim-repeat' },
    keys = {
      { 'gm', '<Plug>IMoveWith', desc = 'Interactive Move Node' },
      { 'gs', '<Plug>ISwapNodeWith', desc = 'Interactive Swap Node' },
      { 'g<', '<Plug>ISwapNodeWithLeft', desc = 'Swap Node With Left' },
      { 'g>', '<Plug>ISwapNodeWithRight', desc = 'Swap Node With Right' },
    },
    opts = {
      autoswap = true,
      move_cursor = true,
    },
  },
  -- buffer remove
  {
    'echasnovski/mini.bufremove',
    -- stylua: ignore
    keys = {
      { "<leader>bd", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
      { "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
    },
  },
  {
    'echasnovski/mini.bracketed',
    version = '*',
    opts = {},
  },

  {
    'echasnovski/mini.ai',
    version = '*',
    event = 'VeryLazy',
    dependencies = { 'nvim-treesitter-textobjects' },
    opts = function()
      local ai = require('mini.ai')
      return {
        mappings = {
          -- Move cursor to corresponding edge of `a` textobject
          goto_left = '',
          goto_right = '',
        },
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({
            a = { '@block.outer', '@conditional.outer', '@loop.outer' },
            i = { '@block.inner', '@conditional.inner', '@loop.inner' },
          }, {}),
          a = ai.gen_spec.treesitter({ a = '@parameter.outer', i = '@parameter.inner' }, {}),
          f = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }, {}),
          c = ai.gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }, {}),
          C = ai.gen_spec.treesitter({ a = '@comment.outer', i = '@comment.inner' }, {}),
        },
      }
    end,
    config = function(_, opts)
      require('mini.ai').setup(opts)
      -- register all text objects with which-key
      ---@type table<string, string|table>
      local i = {
        [' '] = 'Whitespace',
        ['"'] = 'Balanced "',
        ["'"] = "Balanced '",
        ['`'] = 'Balanced `',
        ['('] = 'Balanced (',
        [')'] = 'Balanced ) including white-space',
        ['>'] = 'Balanced > including white-space',
        ['<lt>'] = 'Balanced <',
        [']'] = 'Balanced ] including white-space',
        ['['] = 'Balanced [',
        ['}'] = 'Balanced } including white-space',
        ['{'] = 'Balanced {',
        ['?'] = 'User Prompt',
        _ = 'Underscore',
        a = 'Argument',
        b = 'Balanced ), ], }',
        c = 'Class',
        C = 'Comment',
        f = 'Function',
        o = 'Block, conditional, loop',
        q = 'Quote `, ", \'',
        t = 'Tag',
      }
      local a = vim.deepcopy(i)
      for k, v in pairs(a) do
        a[k] = v:gsub(' including.*', '')
      end

      local ic = vim.deepcopy(i)
      local ac = vim.deepcopy(a)
      for key, name in pairs({ n = 'Next', l = 'Last' }) do
        i[key] = vim.tbl_extend('force', { name = 'Inside ' .. name .. ' textobject' }, ic)
        a[key] = vim.tbl_extend('force', { name = 'Around ' .. name .. ' textobject' }, ac)
      end
      require('which-key').register({
        mode = { 'o', 'x' },
        i = i,
        a = a,
      })
    end,
  },

  {
    'RRethy/vim-illuminate',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      delay = 200,
      large_file_cutoff = 2000,
      large_file_overrides = {
        providers = { 'lsp' },
      },
    },
    config = function(_, opts)
      require('illuminate').configure(opts)

      local function map(key, dir, buffer)
        vim.keymap.set('n', key, function()
          require('illuminate')['goto_' .. dir .. '_reference'](false)
        end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. ' Reference', buffer = buffer })
      end

      map(']]', 'next')
      map('[[', 'prev')

      -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
      vim.api.nvim_create_autocmd('FileType', {
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          map(']]', 'next', buffer)
          map('[[', 'prev', buffer)
        end,
      })
    end,
    keys = {
      { ']]', desc = 'Next Reference' },
      { '[[', desc = 'Prev Reference' },
    },
  },

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  'tpope/vim-abolish',

  {
    'gabrielpoca/replacer.nvim',
    keys = {
      {
        '<leader>h',
        function()
          require('replacer').run()
        end,
        desc = 'Replacer: Run',
      },
    },
  },
  {
    'romainl/vim-qf',
  },

  {
    'mbbill/undotree',
    cmd = 'UndotreeToggle',
    init = function()
      vim.g.undotree_SetFocusWhenToggle = 1
    end,
  },

  {
    'cbochs/grapple.nvim',
    -- stylua: ignore
    keys = {
      { "<leader>mm", "<cmd>GrappleToggle<CR>", desc = "Tag/Untag buffer" },
      { "<leader>mv", "<cmd>GrapplePopup tags<CR>", desc = "View tags" },
    },
  },
}
