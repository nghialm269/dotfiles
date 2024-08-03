return {
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'onsails/lspkind.nvim',
      {
        'zbirenbaum/copilot-cmp',
        dependencies = {
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
        },
        opts = {},
      },
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')

      local has_words_before = function()
        if vim.api.nvim_get_option_value('buftype', { buf = 0 }) == 'prompt' then
          return false
        end
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0
          and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match('^%s*$')
            == nil
      end

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete({}),
          ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() and has_words_before() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() and has_words_before() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
        sources = {
          { name = 'copilot' },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
        },
        sorting = {
          priority_weight = 2,
          comparators = {
            require('copilot_cmp.comparators').prioritize,
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            -- cmp.config.compare.scopes,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.locality,
            cmp.config.compare.kind,
            -- cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
        formatting = {
          format = require('lspkind').cmp_format({
            mode = 'symbol',
            symbol_map = { Copilot = '' },
            menu = {
              buffer = '[Buffer]',
              nvim_lsp = '[LSP]',
              luasnip = '[LuaSnip]',
              nvim_lua = '[Lua]',
              latex_symbols = '[Latex]',
              path = '[Path]',
              copilot = '[Copilot]',
            },
          }),
        },
        experimental = {
          ghost_text = true,
        },
      })

      local kind = cmp.lsp.CompletionItemKind

      -- Add parenthesis on completion confirmation
      -- if completion item is method/function and not a snippet
      cmp.event:on('confirm_done', function(event)
        local completion_item = event.entry:get_completion_item()
        local insert_text_format = completion_item.insertTextFormat
        local completion_kind = completion_item.kind
        if
          insert_text_format == cmp.lsp.InsertTextFormat.PlainText
          and vim.tbl_contains({ kind.Function, kind.Method }, completion_kind)
        then
          local left = vim.api.nvim_replace_termcodes('<Left>', true, true, true)
          vim.api.nvim_feedkeys('()' .. left, 'n', false)
        end
      end)

      cmp.event:on('menu_opened', function()
        vim.b.copilot_suggestion_hidden = true
      end)

      cmp.event:on('menu_closed', function()
        vim.b.copilot_suggestion_hidden = false
      end)
    end,
  },
  {
    'altermo/ultimate-autopair.nvim',
    event = { 'InsertEnter', 'CmdlineEnter' },
    branch = 'v0.6', --recomended as each new version will have breaking changes
    opts = {
      { '**', '**', ft = { 'markdown' }, multiline = false },
      { '*', '*', ft = { 'markdown' }, multiline = false },
      { '_', '_', ft = { 'markdown' }, multiline = false },
      fastwarp = {
        map = '<C-f>',
        cmap = '<C-f>',
      },
    },
  },
  {
    'kylechui/nvim-surround',
    version = '*',
    event = 'VeryLazy',
    opts = {},
  },
  {
    'Wansmer/treesj',
    keys = { 'gS' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {
      use_default_keymaps = false,
      max_join_length = 500,
    },
    config = function(_, opts)
      local treesj = require('treesj')
      treesj.setup(opts)
      vim.keymap.set('n', 'gS', treesj.toggle, { desc = 'Toggle split/join' })
    end,
  },
}
