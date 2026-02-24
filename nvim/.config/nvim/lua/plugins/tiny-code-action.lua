return {
  'rachartier/tiny-code-action.nvim',
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
  },
  event = 'LspAttach',
  opts = {
    picker = 'buffer',
    format_title = function(action, client)
      if action.kind then
        return string.format('[%s] %s (%s)', client.name, action.title, action.kind)
      end
      return string.format('[%s] %s', client.name, action.title)
    end,
  },
}
