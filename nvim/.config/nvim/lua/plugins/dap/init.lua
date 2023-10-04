return {
  'mfussenegger/nvim-dap',

  dependencies = {

    -- fancy UI for the debugger
    {
      'rcarriga/nvim-dap-ui',
      dependencies = {
        {
          'Bekaboo/dropbar.nvim',
          opts = function(_, opts)
            local bar = require('dropbar.bar')
            local create_custom_source = function(icon, name)
              return function(_, _, _)
                return {
                  bar.dropbar_symbol_t:new({
                    icon = icon .. ' ',
                    icon_hl = '@variable.builtin',
                    name = name,
                    name_hl = 'Keyword',
                  }),
                }
              end
            end
            opts.custom_sources = vim.tbl_extend('force', opts.custom_sources or {}, {
              dapui_scopes = create_custom_source('', 'DAP Scopes'),
              dapui_breakpoints = create_custom_source('', 'DAP Breakpoints'),
              dapui_stacks = create_custom_source('', 'DAP Stacks'),
              dapui_watches = create_custom_source('', 'DAP Watches'),
              dapui_console = create_custom_source('', 'DAP Console'),
            })
          end,
        },
      },
      -- stylua: ignore
      keys = {
        { "<localleader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
        { "<localleader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
      },
      opts = {},
      config = function(_, opts)
        local dap = require('dap')
        local dapui = require('dapui')
        dapui.setup(opts)
        dap.listeners.after.event_initialized['dapui_config'] = function()
          dapui.open({})
        end
        dap.listeners.before.event_terminated['dapui_config'] = function()
          dapui.close({})
        end
        dap.listeners.before.event_exited['dapui_config'] = function()
          dapui.close({})
        end
      end,
    },

    -- virtual text for the debugger
    {
      'theHamsta/nvim-dap-virtual-text',
      opts = {},
    },

    -- which key integration
    {
      'folke/which-key.nvim',
      optional = true,
      opts = {
        defaults = {
          ['<localleader>d'] = { name = '+debug' },
          ['<localleader>da'] = { name = '+adapters' },
        },
      },
    },

    -- hydra integration
    {
      'anuvyklack/hydra.nvim',
      keys = {
        { '<localleader>dh', desc = 'Hydra', mode = 'n' },
      },
      config = function()
        local dap = require('dap')
        local hint = [[
     ^ ^Step^ ^ ^      ^ ^     Action
 ----^-^-^-^--^-^----  ^-^-------------------  
     ^ ^back^ ^ ^     ^_t_: toggle breakpoint 
     ^ ^ _K_^ ^        _T_: clear breakpoints 
 out _H_ ^ ^ _L_ into  _c_: continue
     ^ ^ _J_ ^ ^       _x_: terminate
     ^ ^over ^ ^     ^^_r_: open repl

     ^ ^  _q_: exit
]]
        require('hydra')({
          name = 'Debug',
          hint = hint,
          config = {
            color = 'pink',
            invoke_on_body = true,
            hint = {
              type = 'window',
            },
          },
          mode = { 'n' },
          body = '<localleader>dh',
          heads = {
            { 'H', dap.step_out, { desc = 'step out' } },
            { 'J', dap.step_over, { desc = 'step over' } },
            { 'K', dap.step_back, { desc = 'step back' } },
            { 'L', dap.step_into, { desc = 'step into' } },
            { 'b', dap.toggle_breakpoint, { desc = 'toggle breakpoint' } },
            { 'B', dap.clear_breakpoints, { desc = 'clear breakpoints' } },
            { 'c', dap.continue, { desc = 'continue' } },
            { 'x', dap.terminate, { desc = 'terminate' } },
            { 'r', dap.repl.open, { exit = true, desc = 'open repl' } },
            { 'q', nil, { exit = true, nowait = true, desc = 'exit' } },
          },
        })
      end,
    },
  },

  -- stylua: ignore
  keys = {
    { "<localleader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
    { "<localleader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    { "<localleader>dc", function()
      if vim.fn.filereadable('.vscode/launch.json') then
        require('dap.ext.vscode').load_launchjs()
      end
      require("dap").continue()
    end, desc = "Continue" },
    { "<localleader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
    { "<localleader>dg", function() require("dap").goto_() end, desc = "Go to line (no execute)" },
    { "<localleader>di", function() require("dap").step_into() end, desc = "Step Into" },
    { "<localleader>dj", function() require("dap").down() end, desc = "Down" },
    { "<localleader>dk", function() require("dap").up() end, desc = "Up" },
    { "<localleader>dl", function() require("dap").run_last() end, desc = "Run Last" },
    { "<localleader>dn", function() require("dap").step_over() end, desc = "Step Over" },
    { "<localleader>do", function() require("dap").step_out() end, desc = "Step Out" },
    { "<localleader>dp", function() require("dap").pause() end, desc = "Pause" },
    { "<localleader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
    { "<localleader>ds", function() require("dap").session() end, desc = "Session" },
    { "<localleader>dt", function() require("dap").terminate() end, desc = "Terminate" },
    { "<localleader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
  },

  config = function()
    local Config = require('config')
    vim.api.nvim_set_hl(0, 'DapStoppedLine', { default = true, link = 'Visual' })

    for name, sign in pairs(Config.icons.dap) do
      sign = type(sign) == 'table' and sign or { sign }
      vim.fn.sign_define(
        'Dap' .. name,
        { text = sign[1], texthl = sign[2] or 'DiagnosticInfo', linehl = sign[3], numhl = sign[3] }
      )
    end
  end,
}
