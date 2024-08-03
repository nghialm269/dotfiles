local n = require('nui-components')
local wp = require('window-picker')

local M = {}

M.toggle = function(on_win_select)
  if M.renderer then
    return M.renderer:focus()
  end

  local renderer = n.create_renderer({
    width = 22,
    height = 6,
    relative = 'cursor',
    position = 1,
  })

  renderer:on_unmount(function()
    M.renderer = nil
  end)

  M.renderer = renderer

  -- local cur_win_id = vim.api.nvim_get_current_win()
  local body = n.select({
    border_label = 'Select open strategy',
    autofocus = true,
    data = {
      n.option('open', { id = 'open' }),
      n.option('vsplit', { id = 'vsplit' }),
      n.option('split', { id = 'split' }),
      n.option('tab', { id = 'tab' }),
    },
    multiselect = false,
    on_select = function(node)
      local id = node.id
      local origin_win = renderer:get_origin_winid()

      vim.defer_fn(function()
        local picked_win

        if id == 'tab' then
          picked_win = origin_win
        else
          picked_win = wp.pick_window({

            hint = 'floating-big-letter',
            filter_rules = {
              -- when there is only one window available to pick from, use that window
              -- without prompting the user to select
              autoselect_one = true,

              -- whether you want to include the window you are currently on to window
              -- selection or not
              include_current_win = true,

              -- filter using buffer options
              bo = {
                -- if the file type is one of following, the window will be ignored
                filetype = { 'NvimTree', 'neo-tree', 'notify', 'fidget' },

                -- if the file type is one of following, the window will be ignored
                buftype = { 'terminal' },
              },

              -- filter using window options
              wo = {},

              -- if the file path contains one of following names, the window
              -- will be ignored
              file_path_contains = {},

              -- if the file name contains one of following names, the window will be
              -- ignored
              file_name_contains = {},
            },
          })
        end

        if not picked_win then
          return
        end

        local win_cmd
        if id == 'open' then
          win_cmd = 'edit'
        elseif id == 'split' then
          win_cmd = 'belowright split'
        elseif id == 'vsplit' then
          win_cmd = 'belowright vertical split'
        elseif id == 'tab' then
          win_cmd = 'tabedit'
        end

        local new_win
        vim.api.nvim_set_current_win(picked_win)
        vim.api.nvim_win_call(picked_win, function()
          if win_cmd then
            vim.cmd(win_cmd)
          end
          new_win = vim.api.nvim_get_current_win()
        end)

        vim.api.nvim_set_current_win(new_win)
        if on_win_select then
          on_win_select(origin_win, picked_win, new_win)
        end
      end, 1)
      renderer:close()
    end,
  })

  renderer:render(body)
end

return M
