return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  -- stylua: ignore
  keys = {
    { "<leader>bd", function() Snacks.bufdelete.delete({ wipe = true }) end, desc = "Buffer: Delete", },
    { "<leader>bo", function() Snacks.bufdelete.other({ wipe = true }) end, desc = "Buffer: Delete Others", },
    { '<leader>gy', function() Snacks.gitbrowse({
      open = function(url) vim.fn.setreg('+', url) end
    }) end, desc = 'Git: Copy permalinks', mode = { 'n', 'v' }, },
    { '<leader>go', function() Snacks.gitbrowse() end, desc = 'Git: Open permalinks', mode = { 'n', 'v' }, },
  },
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    -- dashboard = { enabled = true },
    -- explorer = { enabled = true },
    indent = { enabled = true },
    input = {
      enabled = true,
      win = {
        relative = 'cursor',
      },
    },
    picker = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    -- statuscolumn = { enabled = true },
    words = { enabled = true },
    gitbrowse = {
      what = 'permalink',
    },
  },
}
