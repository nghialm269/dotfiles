local config = require('config')

---@class util.log
local M = {}

function M.info(msg, opts)
  opts = opts or {}
  opts.title = opts.title or 'Info'
  opts.icon = opts.icon or config.icons.diagnostics.Info

  M.log(msg, vim.log.levels.INFO, opts)
end

function M.warn(msg, opts)
  opts = opts or {}
  opts.title = opts.title or 'Warn'
  opts.icon = opts.icon or config.icons.diagnostics.Warn

  M.log(msg, vim.log.levels.WARN, opts)
end

function M.error(msg, opts)
  opts = opts or {}
  opts.title = opts.title or 'Error'
  opts.icon = opts.icon or config.icons.diagnostics.Error

  M.log(msg, vim.log.levels.ERROR, opts)
end

function M.log(msg, level, opts)
  opts = opts or {}

  local notify = opts.once and vim.notify_once or vim.notify

  notify(msg, level, opts)
end

return M
