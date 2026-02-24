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
      -- override existing keymaps
      { 'gd', function() Snacks.picker.lsp_definitions() end, desc = 'Goto Definitions', has = 'definition', },
      { 'gD', function() Snacks.picker.lsp_declarations() end, desc = 'Goto Declarations', },
      { 'gra', function() require("tiny-code-action").code_action() end, desc = 'Code Action', mode = { 'n', 'i', 'v' }, has = 'codeAction', },
      { 'grr', function() Snacks.picker.lsp_references() end, desc = 'Goto References', },
      { 'gri', function() Snacks.picker.lsp_implementations() end, desc = 'Goto Implementations', },
      { 'grt', function() Snacks.picker.lsp_type_definitions() end, desc = 'Goto Type Definitions', },
      { 'g0', function() Snacks.picker.lsp_symbols() end, desc = 'Document Symbols', },

      -- new specific lsp keymaps
      { '<localleader>lgd', function() Snacks.picker.lsp_definitions() end, desc = 'Goto Definitions', has = 'definition', },
      { '<localleader>lgD', function() Snacks.picker.lsp_declarations() end, desc = 'Goto Declarations' },
      { '<localleader>lgr', function() Snacks.picker.lsp_references() end, desc = 'Goto References' },
      { '<localleader>lgi', function() Snacks.picker.lsp_implementations() end, desc = 'Goto Implementations', },
      { '<localleader>lgt', function() Snacks.picker.lsp_type_definitions() end, desc = 'Goto Type Definitions', },
      { '<localleader>lci', function() Snacks.picker.lsp_incoming_calls() end, desc = 'Incoming Calls', },
      { '<localleader>lco', function() Snacks.picker.lsp_outgoing_calls() end, desc = 'Outoging Calls', },
      { '<localleader>lh', vim.lsp.buf.hover, desc = 'Hover Documentation', },
      { '<localleader>lsh', vim.lsp.buf.signature_help, desc = 'Signature Help', has = 'signatureHelp', },
      { '<localleader>lf', format, desc = 'Format Document', has = 'formatting', },
      { '<localleader>lf', format, desc = 'Format Range', mode = 'v', has = 'rangeFormatting', },
      { '<localleader>lca', function() require("tiny-code-action").code_action() end, desc = 'Code Action', mode = { 'n', 'i', 'v' }, has = 'codeAction', },
      { '<localleader>lcA', function() require("tiny-code-action").code_action({ context = { only = { 'source', }, diagnostics = {}, }, }) end, desc = 'Source Action', has = 'codeAction', },
      { '<localleader>lrn', vim.lsp.buf.rename, desc = 'Rename', has = 'rename', },
      { '<localleader>lsd', function() Snacks.picker.lsp_symbols() end, desc = 'Document Symbols', },
      { '<localleader>lsw', function() Snacks.picker.lsp_workspace_symbols() end, desc = 'Workspace Symbols', },
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

return M
