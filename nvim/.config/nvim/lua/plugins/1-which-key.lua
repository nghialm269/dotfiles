return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  -- NOTE: `opts_extend` doesn't work as expected if it isn't loaded first,
  -- hence the file name is prefixed with `1-`
  opts_extend = { 'spec' },
  opts = {
    preset = 'helix',
    spec = {
      { '[', group = 'prev' },
      { ']', group = 'next' },
    },
  },
  keys = {
    {
      '<leader>?',
      function()
        require('which-key').show({ global = false })
      end,
      desc = 'Buffer Local Keymaps (which-key)',
    },
  },
  config = function(_, opts)
    local wk = require('which-key')
    wk.setup(opts)
  end,
}
