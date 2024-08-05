return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    opts = {
      suggestion = {
        enabled = true,
        accept = '<C-e>',
        dismiss = '/',
      },
      panel = {
        enabled = true,
        auto_refresh = true,
      },
      copilot_node_command = vim.fn.expand('$HOME')
        .. '/.local/share/mise/installs/node/lts/bin/node',
    },
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'canary',
    dependencies = {
      { 'zbirenbaum/copilot.lua' },
      { 'nvim-lua/plenary.nvim' },
    },
    opts = {},
  },
  {
    'zbirenbaum/copilot-cmp',
    dependencies = {
      {
        'hrsh7th/nvim-cmp',
        opts = function(_, opts)
          opts.sources = opts.sources or {}
          table.insert(opts.sources, {
            name = 'copilot',
          })
        end,
      },
    },
    opts = {},
  },
}
