return {
  {
    'echasnovski/mini.clue',
    event = 'VeryLazy',
    opts = function(_, opts)
      local miniclue = require('mini.clue')
      -- Add a-z/A-Z marks.
      local function generate_mark_clues()
        local marks = {}
        vim.list_extend(marks, vim.fn.getmarklist(vim.api.nvim_get_current_buf()))
        vim.list_extend(marks, vim.fn.getmarklist())

        local res = {}
        for _, mark in ipairs(marks) do
          local key = mark.mark:sub(2, 2)

          -- Just look at letter marks.
          if not string.match(key, '^%a') then
            return nil
          end

          -- For global marks, use the file as a description.
          -- For local marks, use the line number and content.
          local desc
          if mark.file then
            desc = vim.fn.fnamemodify(mark.file, ':p:~:.')
          elseif mark.pos[1] and mark.pos[1] ~= 0 then
            local line_num = mark.pos[2]
            local lines = vim.fn.getbufline(mark.pos[1], line_num)
            if lines and lines[1] then
              desc = string.format('%d: %s', line_num, lines[1]:gsub('^%s*', ''))
            end
          end

          if desc then
            table.insert(res, { mode = 'n', keys = string.format("'%s", key), desc = desc })
            table.insert(res, { mode = 'n', keys = string.format('`%s', key), desc = desc })
          end
        end

        return res
      end

      -- Clues for recorded macros.
      local function generate_macro_clues()
        local res = {}
        for _, register in ipairs(vim.split('abcdefghijklmnopqrstuvwxyz', '')) do
          local keys = string.format('"%s', register)
          local ok, desc = pcall(vim.fn.getreg, register, 1)
          if ok and desc ~= '' then
            table.insert(res, { mode = 'n', keys = keys, desc = desc })
            table.insert(res, { mode = 'v', keys = keys, desc = desc })
          end
        end

        return res
      end

      return {
        triggers = {
          -- `g` key
          { mode = 'n', keys = 'g' },
          { mode = 'x', keys = 'g' },
          -- marks
          { mode = 'n', keys = "'" },
          { mode = 'x', keys = "'" },
          { mode = 'n', keys = '`' },
          { mode = 'x', keys = '`' },
          -- registers
          { mode = 'n', keys = '"' },
          { mode = 'x', keys = '"' },
          { mode = 'i', keys = '<C-r>' },
          { mode = 'c', keys = '<C-r>' },
          -- window commands
          { mode = 'n', keys = '<C-w>' },
          -- `z` key
          { mode = 'n', keys = 'z' },
          { mode = 'x', keys = 'z' },
          -- Leader triggers.
          { mode = 'n', keys = '<leader>' },
          { mode = 'x', keys = '<leader>' },
          { mode = 'n', keys = '<localleader>' },
          { mode = 'x', keys = '<localleader>' },
        },
        clues = {
          -- Leader/movement groups.
          { mode = 'n', keys = '<leader>b', desc = '+buffers' },
          { mode = 'n', keys = '<leader>d', desc = '+diagnostics' },
          { mode = 'n', keys = '<leader>e', desc = '+explorer' },
          { mode = 'n', keys = '<leader>f', desc = '+find' },
          { mode = 'n', keys = '<leader>m', desc = '+marks' },
          { mode = 'n', keys = '<leader>n', desc = '+notifications' },
          { mode = 'n', keys = '<leader>t', desc = '+tasks (overseer)' },
          { mode = 'n', keys = '[', desc = '+prev' },
          { mode = 'n', keys = ']', desc = '+next' },
          miniclue.gen_clues.g(),
          miniclue.gen_clues.marks(),
          miniclue.gen_clues.registers(),
          miniclue.gen_clues.windows(),
          miniclue.gen_clues.z(),
          -- Custom extras.
          generate_mark_clues,
          generate_macro_clues,
        },
        window = {
          delay = 500,
          scroll_down = '<C-f>',
          scroll_up = '<C-b>',
          config = function(bufnr)
            local max_width = 0
            for _, line in ipairs(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)) do
              max_width = math.max(max_width, vim.fn.strchars(line))
            end

            -- Keep some right padding.
            max_width = max_width + 2

            return {
              border = 'rounded',
              -- Dynamic width capped at 45.
              width = math.min(45, max_width),
            }
          end,
        },
      }
    end,
  },
  {
    'echasnovski/mini.files',
    version = '*',
    dependencies = {
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    },
    opts = {
      mappings = {
        go_in = '',
        go_in_plus = '<CR>',
        go_out = '',
        go_out_plus = '<BS>',
        reset = 'gR',
      },
      windows = {
        -- preview = true,
      },
    },
    config = function(_, opts)
      local minifiles = require('mini.files')
      minifiles.setup(opts)

      local toggle = function(...)
        if not minifiles.close() then
          minifiles.open(...)
        end
      end

      vim.keymap.set('n', '<leader>ef', function()
        toggle(vim.api.nvim_buf_get_name(0), false)
      end, { desc = 'Mini Files Toggle' })

      local map_split = function(buf_id, lhs, direction)
        local rhs = function()
          local window = minifiles.get_target_window()

          -- Noop if the explorer isn't open or the cursor is on a directory.
          if window == nil or minifiles.get_fs_entry().fs_type == 'directory' then
            return
          end

          -- Make new window and set it as target
          local new_target_window
          vim.api.nvim_win_call(window, function()
            vim.cmd(direction .. ' split')
            new_target_window = vim.api.nvim_get_current_win()
          end)

          minifiles.set_target_window(new_target_window)

          -- Go in and close the explorer.
          minifiles.go_in()
          minifiles.close()
        end

        -- Adding `desc` will result into `show_help` entries
        local desc = 'Split ' .. direction
        vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
      end

      vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesBufferCreate',
        callback = function(args)
          local buf_id = args.data.buf_id
          -- Tweak keys to your liking
          map_split(buf_id, '<C-x>', 'belowright horizontal')
          map_split(buf_id, '<C-v>', 'belowright vertical')
        end,
      })
    end,
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    cmd = 'Neotree',
    keys = {
      {
        '<leader>eF',
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
        search = {
          enabled = false,
        },
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
    dependencies = {
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
            { mode = 'n', keys = ']d', postkeys = ']' },
            { mode = 'n', keys = '[d', postkeys = '[' },
            { mode = 'n', keys = ']q', postkeys = ']' },
            { mode = 'n', keys = '[q', postkeys = '[' },
            { mode = 'n', keys = ']l', postkeys = ']' },
            { mode = 'n', keys = '[l', postkeys = '[' },
          })
        end,
      },
    },
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

  {
    'ojroques/nvim-osc52',
    opts = {
      max_length = 0,
      silent = false,
      trim = false,
      tmux_passthrough = true,
    },
    config = function(_, opts)
      local osc52 = require('osc52')
      osc52.setup(opts)

      local function copy(lines, _)
        osc52.copy(table.concat(lines, '\n'))
      end

      local function paste()
        return { vim.fn.split(vim.fn.getreg(''), '\n'), vim.fn.getregtype('') }
      end

      vim.g.clipboard = {
        name = 'osc52',
        copy = { ['+'] = copy, ['*'] = copy },
        paste = { ['+'] = paste, ['*'] = paste },
      }
    end,
  },
}
