return {
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')

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
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
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
}
