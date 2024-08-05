local M = {}

---@type PluginLspKeys
M._keys = nil

---@return (LazyKeys|{has?:string})[]
function M.get()
  local format = function()
    require('plugins.lsp.format').format({ force = true })
  end
  if not M._keys then
    ---@class PluginLspKeys
    -- stylua: ignore
    M._keys = {
      { 'gd', function() require("telescope.builtin").lsp_definitions() end, desc = 'Goto Definition', has = 'definition', },
      { 'gr', '<cmd>Telescope lsp_references<cr>', desc = 'Goto References' },
      { 'gR', '<cmd>Lspsaga finder<cr>', desc = 'Find Implementations, References, Definitions, Type Definitions' },
      { 'gD', vim.lsp.buf.declaration, desc = 'Goto Declaration' },
      { 'gI', function() require("telescope.builtin").lsp_implementations() end, desc = 'Goto Implementation', },
      { 'gT', function() require("telescope.builtin").lsp_type_definitions() end, desc = 'Goto Type Definition', },
      { 'K', vim.lsp.buf.hover, desc = 'Hover Documentation', },
      { 'gK', vim.lsp.buf.signature_help, desc = 'Signature Help', has = 'signatureHelp', },
      { '<C-s>', vim.lsp.buf.signature_help, mode = 'i', desc = 'Signature Help', has = 'signatureHelp', },
      { '<localleader>lf', format, desc = 'Format Document', has = 'formatting', },
      { '<localleader>lf', format, desc = 'Format Range', mode = 'v', has = 'rangeFormatting', },
      { '<localleader>lca', vim.lsp.buf.code_action, desc = 'Code Action', mode = { 'n', 'i', 'v' }, has = 'codeAction', },
      { '<C-Enter>', vim.lsp.buf.code_action, desc = 'Code Action', mode = { 'n', 'i', 'v' }, has = 'codeAction', },
      { '<localleader>lcA', function() vim.lsp.buf.code_action({ context = { only = { 'source', }, diagnostics = {}, }, }) end, desc = 'Source Action', has = 'codeAction', },
      { '<localleader>lrn', vim.lsp.buf.rename, desc = 'Rename', has = 'rename', },
      { '<localleader>lsd', '<cmd>Telescope lsp_document_symbols<CR>', desc = 'Document Symbols', },
      { '<localleader>lsw', '<cmd>Telescope lsp_dynamic_workspace_symbols<CR>', desc = 'Workspace Symbols', },
      { '<localleader>lwa', vim.lsp.buf.add_workspace_folder, desc = 'Workspace Add Folder', },
      { '<localleader>lwr', vim.lsp.buf.remove_workspace_folder, desc = 'Workspace Remove Folder', },
      { '<localleader>lwl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, desc = 'Workspace List Folders', },
    }
  end
  return M._keys
end

---@param method string
function M.has(buffer, method)
  method = method:find('/') and method or 'textDocument/' .. method
  local clients = vim.lsp.get_clients({ bufnr = buffer })
  for _, client in ipairs(clients) do
    if client.supports_method(method) then
      return true
    end
  end
  return false
end

---@return (LazyKeys|{has?:string})[]
function M.resolve(buffer)
  local Keys = require('lazy.core.handler.keys')
  if not Keys.resolve then
    return {}
  end
  local spec = M.get()
  local opts = require('util').opts('nvim-lspconfig')
  local clients = vim.lsp.get_clients({ bufnr = buffer })
  for _, client in ipairs(clients) do
    local maps = opts.servers[client.name] and opts.servers[client.name].keys or {}
    vim.list_extend(spec, maps)
  end
  return Keys.resolve(spec)
end

function M.on_attach(_, buffer)
  local Keys = require('lazy.core.handler.keys')
  local keymaps = M.resolve(buffer)

  for _, keys in pairs(keymaps) do
    if not keys.has or M.has(buffer, keys.has) then
      local opts = Keys.opts(keys)
      opts.has = nil
      opts.silent = opts.silent ~= false
      opts.buffer = buffer
      vim.keymap.set(keys.mode or 'n', keys.lhs, keys.rhs, opts)
    end
  end
end

function M.diagnostic_goto(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

function M.definition_split()
  vim.lsp.buf.definition({
    on_list = function(options)
      -- if there are multiple items, warn the user
      if #options.items > 1 then
        vim.fn.setqflist({}, ' ', { title = options.title, items = options.items })
        vim.cmd('botright copen')
        return
      end

      require('pickers.selectwin').toggle(function(origin_win, picked_win, new_win)
        -- Save position in jumplist
        vim.cmd("normal! m'")

        -- Push a new item into tagstack
        local from = { vim.fn.bufnr('%'), vim.fn.line('.'), vim.fn.col('.'), 0 }
        local items = { { tagname = vim.fn.expand('<cword>'), from = from } }
        vim.fn.settagstack(vim.fn.win_getid(), { items = items }, 't')

        -- Open the first item in a vertical split
        local item = options.items[1]
        local uri = vim.uri_from_fname(item.filename)
        local bufnr = vim.uri_to_bufnr(uri)
        vim.api.nvim_win_set_buf(new_win, bufnr)
        vim.api.nvim_win_set_cursor(new_win, { item.lnum, item.col - 1 })
        vim.api.nvim_win_call(new_win, function()
          -- Open folds under the cursor
          vim.cmd('normal! zv')
        end)
        -- local cmd = 'vsplit +'
        --   .. item.lnum
        --   .. ' '
        --   .. item.filename
        --   .. '|'
        --   .. 'normal '
        --   .. item.col
        --   .. '|'
        --
        -- vim.cmd(cmd)
      end)
    end,
  })
end

return M
