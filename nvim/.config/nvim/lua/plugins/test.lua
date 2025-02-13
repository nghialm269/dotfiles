return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    -- stylua: ignore
    keys = {
      { '<localleader>tf', function() require('neotest').run.run(vim.fn.expand('%')) end, desc = 'Run File' },
      { '<localleader>tp', function() require('neotest').run.run(vim.loop.cwd()) end, desc = 'Run All Test Files' },
      { '<localleader>tt', function() require('neotest').run.run() end, desc = 'Run Nearest' },
      { '<localleader>ts', function() require('neotest').summary.toggle() end, desc = 'Toggle Summary' },
      { '<localleader>to', function() require('neotest').output.open({ enter = true, auto_close = true }) end, desc = 'Show Output' },
      { '<localleader>tO', function() require('neotest').output_panel.toggle() end, desc = 'Toggle Output Panel' },
      { '<localleader>tS', function() require('neotest').run.stop() end, desc = 'Stop' },
    },
    opts = {
      adapters = {},
      -- See all config options with :h neotest.Config
      discovery = {
        -- Drastically improve performance in ginormous projects by
        -- only AST-parsing the currently opened buffer.
        enabled = false,
        -- Number of workers to parse files concurrently.
        -- A value of 0 automatically assigns number based on CPU.
        -- Set to 1 if experiencing lag.
        concurrent = 0,
      },
      running = {
        -- Run tests concurrently when an adapter provides multiple commands to run.
        concurrent = true,
      },
      summary = {
        -- Enable/disable animation of icons.
        animated = true,
      },
    },
    config = function(_, opts)
      local neotest_ns = vim.api.nvim_create_namespace('neotest')
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            -- Replace newline and tab characters with space for more compact diagnostics
            local message =
              diagnostic.message:gsub('\n', ' '):gsub('\t', ' '):gsub('%s+', ' '):gsub('^%s+', '')
            return message
          end,
        },
      }, neotest_ns)

      if opts.adapters then
        local adapters = {}
        for name, config in pairs(opts.adapters or {}) do
          if type(name) == 'number' then
            if type(config) == 'string' then
              config = require(config)
            end
            adapters[#adapters + 1] = config
          elseif config ~= false then
            local adapter = require(name)
            if type(config) == 'table' and not vim.tbl_isempty(config) then
              local meta = getmetatable(adapter)
              if adapter.setup then
                adapter.setup(config)
              elseif meta and meta.__call then
                adapter(config)
              else
                error('Adapter ' .. name .. ' does not support setup')
              end
            end
            adapters[#adapters + 1] = adapter
          end
        end
        opts.adapters = adapters
      end

      require('neotest').setup(opts)
    end,
  },
  {
    'andythigpen/nvim-coverage',
    dependencies = 'nvim-lua/plenary.nvim',
    cmd = {
      'Coverage',
      'CoverageLoad',
      'CoverageLoadLcov',
      'CoverageToggle',
      'CoverageShow',
      'CoverageHide',
      'CoverageClear',
      'CoverageSummary',
    },
    opts = {
      auto_reload = true,
      lang = {
        python = {
          coverage_command = 'poetry run coverage json -o -',
        },
      },
    },
  },
  {
    'mfussenegger/nvim-dap',
    keys = {
      {
        '<localleader>td',
        function()
          require('neotest').run.run({ suite = false, strategy = 'dap' })
        end,
        desc = 'Debug Nearest',
      },
    },
  },
  {
    'echasnovski/mini.clue',
    opts = function(_, opts)
      opts.clues = opts.clues or {}
      vim.list_extend(opts.clues, {
        { mode = 'n', keys = '<localleader>t', desc = '+test' },
      })
    end,
  },
}
