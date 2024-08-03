return {
  {
    'L3MON4D3/LuaSnip',
    build = 'make install_jsregexp',
    version = 'v2.*',
    keys = {
      {
        mode = { 'i', 's' },
        '<C-l>',
        function()
          if require('luasnip').choice_active() then
            require('luasnip.extras.select_choice')()
          else
            vim.api.nvim_feedkeys(
              vim.api.nvim_replace_termcodes([[<C-l>]], true, true, true),
              'n',
              true
            )
          end
        end,
        desc = 'Snippets: Select Choices',
      },
      {
        mode = { 'n' },
        '<leader>sel',
        function()
          require('luasnip.loaders').edit_snippet_files({})
        end,
        desc = 'Snippets: Edit (LuaSnip)',
      },
    },
    opts = {
      history = true,
      delete_check_events = 'TextChanged',
      update_events = 'TextChanged,TextChangedI',
      store_selection_keys = '<Tab>',
      ft_func = require('luasnip.extras.filetype_functions').from_pos_or_filetype,
      ext_opts = {
        [require('luasnip.util.types').choiceNode] = {
          active = {
            virt_text = { { ' ', 'TSTextReference' } },
          },
        },
        [require('luasnip.util.types').insertNode] = {
          active = {
            virt_text = { { ' ', 'TSEmphasis' } },
          },
        },
      },
    },
    config = function(_, opts)
      local ls = require('luasnip')
      ls.setup(opts)

      require('luasnip.loaders.from_vscode').lazy_load({
        paths = { vim.fn.stdpath('config') .. '/snippets/vscode' },
      })
      require('luasnip.loaders.from_lua').lazy_load({
        paths = { vim.fn.stdpath('config') .. '/snippets/luasnip' },
      })

      vim.api.nvim_create_user_command('LuaSnipEdit', function()
        require('luasnip.loaders').edit_snippet_files({})
      end, { desc = 'Edit Snippets (LuaSnip)' })
    end,
  },

  {
    'chrisgrieser/nvim-scissors',
    dependencies = { 'nvim-telescope/telescope.nvim', 'L3MON4D3/LuaSnip' },
    keys = {
      {
        mode = { 'n', 'x' },
        '<leader>sa',
        function()
          require('scissors').addNewSnippet()
        end,
        desc = 'Snippets: Add',
      },
      {
        mode = { 'n' },
        '<leader>sev',
        function()
          require('scissors').editSnippet()
        end,
        desc = 'Snippets: Edit (VSCode)',
      },
    },
    opts = {
      snippetDir = vim.fn.stdpath('config') .. '/snippets/vscode',
      jsonFormatter = 'jq',
    },
  },
}
