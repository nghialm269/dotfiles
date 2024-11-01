local wezterm = require('wezterm')

local M = {}

local act = wezterm.action

local make_escape_sequence = function(opts)
  -- http://www.leonerd.org.uk/hacks/fixterms/
  local UNMODIFIED = 1
  local SHIFT = 1
  local ALT = 2
  local CTRL = 4

  local key = opts.key
  local mods = opts.mods or 'NONE'

  if mods == 'NONE' then
    -- return string.format('\x1b[%s', c)
    return key
  end

  mods = string.upper(mods)

  local modifier = UNMODIFIED

  if string.find(mods, 'SHIFT') then
    modifier = modifier + SHIFT
  end

  if string.find(mods, 'ALT') then
    modifier = modifier + ALT
  end

  if string.find(mods, 'CTRL') then
    modifier = modifier + CTRL
  end

  local c = string.byte(key)
  return string.format('\x1b[%s;%du', c, modifier)
end

local function basename(s)
  return string.gsub(s, '(.*[/\\])(.*)', '%2')
end

local clear_screen_or_fallback = function(window, pane)
  -- After switching to a new process, the first call returns the previous process's name, hence called twice
  mux_pane = wezterm.mux.get_pane(pane:pane_id())
  wezterm.log_info('mux_name', mux_pane:get_foreground_process_name())
  wezterm.log_info('mux_info', mux_pane:get_foreground_process_info())
  wezterm.log_info('mux_tty', mux_pane:get_tty_name())
  wezterm.log_info('mux_user_vars', mux_pane:get_user_vars())
  wezterm.log_info('name', pane:get_foreground_process_name())
  wezterm.log_info('info', pane:get_foreground_process_info())
  wezterm.log_info('tty', pane:get_tty_name())
  wezterm.log_info('user_vars', pane:get_user_vars())
  local process_name = basename(pane:get_foreground_process_name())
  process_name = basename(pane:get_foreground_process_name())
  if process_name == 'zsh' then
    -- Clears the scrollback and viewport, and then sends CTRL-L to ask the
    -- shell to redraw its prompt
    window:perform_action(
      act.Multiple({
        act.ClearScrollback('ScrollbackAndViewport'),
        act.SendKey({ mods = 'CTRL', key = 'l' }), -- NOTE: `l` is lowercase, uppercase `L` will send CTRL-SHIFT-L
      }),
      pane
    )
  else
    window:perform_action(
      act.SendString(make_escape_sequence({ mods = 'CTRL|SHIFT', key = 'L' })),
      pane
    ) -- CTRL-SHIFT-L = '\x1b[76;6u' (CSI u: http://www.leonerd.org.uk/hacks/fixterms/)
  end
end

M.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
M.keys = {
  -- Send leader
  {
    key = 'a',
    mods = 'LEADER|CTRL',
    action = wezterm.action.SendKey({ key = 'a', mods = 'CTRL' }),
  },
  -- Clipboard
  { key = 'c', mods = 'SHIFT|CTRL', action = act.CopyTo('Clipboard') },
  { key = 'v', mods = 'SHIFT|CTRL', action = act.PasteFrom('Clipboard') },
  { key = 'Insert', mods = 'CTRL', action = act.CopyTo('PrimarySelection') },
  { key = 'Insert', mods = 'SHIFT', action = act.PasteFrom('PrimarySelection') },
  { key = 'Copy', mods = 'NONE', action = act.CopyTo('Clipboard') },
  { key = 'Paste', mods = 'NONE', action = act.PasteFrom('Clipboard') },

  -- Font size
  { key = '0', mods = 'CTRL', action = act.ResetFontSize },
  { key = '0', mods = 'SHIFT|CTRL', action = act.ResetFontSize },
  { key = '=', mods = 'CTRL', action = act.IncreaseFontSize },
  { key = '=', mods = 'SHIFT|CTRL', action = act.IncreaseFontSize },
  { key = '-', mods = 'CTRL', action = act.DecreaseFontSize },
  { key = '-', mods = 'SHIFT|CTRL', action = act.DecreaseFontSize },

  -- Multiplexing
  { key = 'c', mods = 'LEADER', action = act.SpawnTab('CurrentPaneDomain') },
  { key = 'Tab', mods = 'LEADER', action = act.ShowTabNavigator },
  { key = '1', mods = 'LEADER', action = act.ActivateTab(0) },
  { key = '2', mods = 'LEADER', action = act.ActivateTab(1) },
  { key = '3', mods = 'LEADER', action = act.ActivateTab(2) },
  { key = '4', mods = 'LEADER', action = act.ActivateTab(3) },
  { key = '5', mods = 'LEADER', action = act.ActivateTab(4) },
  { key = '6', mods = 'LEADER', action = act.ActivateTab(5) },
  { key = '7', mods = 'LEADER', action = act.ActivateTab(6) },
  { key = '8', mods = 'LEADER', action = act.ActivateTab(7) },
  { key = '9', mods = 'LEADER', action = act.ActivateTab(8) },
  { key = '0', mods = 'LEADER', action = act.ActivateTab(9) },

  { key = '-', mods = 'LEADER', action = act.SplitVertical({ domain = 'CurrentPaneDomain' }) },
  {
    key = '-',
    mods = 'LEADER|SHIFT',
    action = act.SplitVertical({ domain = 'CurrentPaneDomain' }),
  },

  { key = '\\', mods = 'LEADER', action = act.SplitHorizontal({ domain = 'CurrentPaneDomain' }) },
  {
    key = '|',
    mods = 'LEADER|SHIFT',
    action = act.SplitHorizontal({ domain = 'CurrentPaneDomain' }),
  },

  { key = 'p', mods = 'LEADER', action = act.PaneSelect },
  { key = 'P', mods = 'LEADER', action = act.PaneSelect({ mode = 'SwapWithActive' }) },
  {
    key = 'h',
    mods = 'LEADER',
    action = act.ActivatePaneDirection('Left'),
  },
  {
    key = 'j',
    mods = 'LEADER',
    action = act.ActivatePaneDirection('Down'),
  },
  {
    key = 'k',
    mods = 'LEADER',
    action = act.ActivatePaneDirection('Up'),
  },
  {
    key = 'l',
    mods = 'LEADER',
    action = act.ActivatePaneDirection('Right'),
  },

  { key = 'z', mods = 'LEADER', action = act.TogglePaneZoomState },
  { key = 'w', mods = 'LEADER|SHIFT', action = act.CloseCurrentTab({ confirm = true }) },
  { key = 'x', mods = 'LEADER', action = act.CloseCurrentPane({ confirm = true }) },

  -- Others
  { key = 'i', mods = 'SHIFT|CTRL', action = act.ShowDebugOverlay },
  { key = 'p', mods = 'SHIFT|CTRL', action = act.ActivateCommandPalette },
  { key = 'r', mods = 'SHIFT|CTRL', action = act.ReloadConfiguration },
  { key = 'phys:Space', mods = 'SHIFT|CTRL', action = act.QuickSelect },

  -- Custom actions
  { key = 'l', mods = 'CTRL|SHIFT', action = wezterm.action_callback(clear_screen_or_fallback) },
}

local _default_keys = {
  keys = {

    { key = 'Tab', mods = 'CTRL', action = act.ActivateTabRelative(1) },
    { key = 'Tab', mods = 'SHIFT|CTRL', action = act.ActivateTabRelative(-1) },
    { key = 'Enter', mods = 'ALT', action = act.ToggleFullScreen },
    { key = '!', mods = 'CTRL', action = act.ActivateTab(0) },
    { key = '!', mods = 'SHIFT|CTRL', action = act.ActivateTab(0) },
    { key = '"', mods = 'ALT|CTRL', action = act.SplitVertical({ domain = 'CurrentPaneDomain' }) },
    {
      key = '"',
      mods = 'SHIFT|ALT|CTRL',
      action = act.SplitVertical({ domain = 'CurrentPaneDomain' }),
    },
    { key = '#', mods = 'CTRL', action = act.ActivateTab(2) },
    { key = '#', mods = 'SHIFT|CTRL', action = act.ActivateTab(2) },
    { key = '$', mods = 'CTRL', action = act.ActivateTab(3) },
    { key = '$', mods = 'SHIFT|CTRL', action = act.ActivateTab(3) },
    { key = '%', mods = 'CTRL', action = act.ActivateTab(4) },
    { key = '%', mods = 'SHIFT|CTRL', action = act.ActivateTab(4) },
    {
      key = '%',
      mods = 'ALT|CTRL',
      action = act.SplitHorizontal({ domain = 'CurrentPaneDomain' }),
    },
    {
      key = '%',
      mods = 'SHIFT|ALT|CTRL',
      action = act.SplitHorizontal({ domain = 'CurrentPaneDomain' }),
    },
    { key = '&', mods = 'CTRL', action = act.ActivateTab(6) },
    { key = '&', mods = 'SHIFT|CTRL', action = act.ActivateTab(6) },
    {
      key = "'",
      mods = 'SHIFT|ALT|CTRL',
      action = act.SplitVertical({ domain = 'CurrentPaneDomain' }),
    },
    { key = '(', mods = 'CTRL', action = act.ActivateTab(-1) },
    { key = '(', mods = 'SHIFT|CTRL', action = act.ActivateTab(-1) },
    { key = ')', mods = 'CTRL', action = act.ResetFontSize },
    { key = ')', mods = 'SHIFT|CTRL', action = act.ResetFontSize },
    { key = '*', mods = 'CTRL', action = act.ActivateTab(7) },
    { key = '*', mods = 'SHIFT|CTRL', action = act.ActivateTab(7) },
    { key = '+', mods = 'CTRL', action = act.IncreaseFontSize },
    { key = '+', mods = 'SHIFT|CTRL', action = act.IncreaseFontSize },
    { key = '-', mods = 'CTRL', action = act.DecreaseFontSize },
    { key = '-', mods = 'SHIFT|CTRL', action = act.DecreaseFontSize },
    { key = '-', mods = 'SUPER', action = act.DecreaseFontSize },
    { key = '0', mods = 'CTRL', action = act.ResetFontSize },
    { key = '0', mods = 'SHIFT|CTRL', action = act.ResetFontSize },
    { key = '0', mods = 'SUPER', action = act.ResetFontSize },
    { key = '1', mods = 'SHIFT|CTRL', action = act.ActivateTab(0) },
    { key = '1', mods = 'SUPER', action = act.ActivateTab(0) },
    { key = '2', mods = 'SHIFT|CTRL', action = act.ActivateTab(1) },
    { key = '2', mods = 'SUPER', action = act.ActivateTab(1) },
    { key = '3', mods = 'SHIFT|CTRL', action = act.ActivateTab(2) },
    { key = '3', mods = 'SUPER', action = act.ActivateTab(2) },
    { key = '4', mods = 'SHIFT|CTRL', action = act.ActivateTab(3) },
    { key = '4', mods = 'SUPER', action = act.ActivateTab(3) },
    { key = '5', mods = 'SHIFT|CTRL', action = act.ActivateTab(4) },
    {
      key = '5',
      mods = 'SHIFT|ALT|CTRL',
      action = act.SplitHorizontal({ domain = 'CurrentPaneDomain' }),
    },
    { key = '5', mods = 'SUPER', action = act.ActivateTab(4) },
    { key = '6', mods = 'SHIFT|CTRL', action = act.ActivateTab(5) },
    { key = '6', mods = 'SUPER', action = act.ActivateTab(5) },
    { key = '7', mods = 'SHIFT|CTRL', action = act.ActivateTab(6) },
    { key = '7', mods = 'SUPER', action = act.ActivateTab(6) },
    { key = '8', mods = 'SHIFT|CTRL', action = act.ActivateTab(7) },
    { key = '8', mods = 'SUPER', action = act.ActivateTab(7) },
    { key = '9', mods = 'SHIFT|CTRL', action = act.ActivateTab(-1) },
    { key = '9', mods = 'SUPER', action = act.ActivateTab(-1) },
    { key = '=', mods = 'CTRL', action = act.IncreaseFontSize },
    { key = '=', mods = 'SHIFT|CTRL', action = act.IncreaseFontSize },
    { key = '=', mods = 'SUPER', action = act.IncreaseFontSize },
    { key = '@', mods = 'CTRL', action = act.ActivateTab(1) },
    { key = '@', mods = 'SHIFT|CTRL', action = act.ActivateTab(1) },
    { key = 'C', mods = 'CTRL', action = act.CopyTo('Clipboard') },
    { key = 'C', mods = 'SHIFT|CTRL', action = act.CopyTo('Clipboard') },
    { key = 'F', mods = 'CTRL', action = act.Search('CurrentSelectionOrEmptyString') },
    { key = 'F', mods = 'SHIFT|CTRL', action = act.Search('CurrentSelectionOrEmptyString') },
    { key = 'K', mods = 'CTRL', action = act.ClearScrollback('ScrollbackOnly') },
    { key = 'K', mods = 'SHIFT|CTRL', action = act.ClearScrollback('ScrollbackOnly') },
    { key = 'L', mods = 'CTRL', action = act.ShowDebugOverlay },
    { key = 'L', mods = 'SHIFT|CTRL', action = act.ShowDebugOverlay },
    { key = 'M', mods = 'CTRL', action = act.Hide },
    { key = 'M', mods = 'SHIFT|CTRL', action = act.Hide },
    { key = 'N', mods = 'CTRL', action = act.SpawnWindow },
    { key = 'N', mods = 'SHIFT|CTRL', action = act.SpawnWindow },
    { key = 'P', mods = 'CTRL', action = act.ActivateCommandPalette },
    { key = 'P', mods = 'SHIFT|CTRL', action = act.ActivateCommandPalette },
    { key = 'R', mods = 'CTRL', action = act.ReloadConfiguration },
    { key = 'R', mods = 'SHIFT|CTRL', action = act.ReloadConfiguration },
    { key = 'T', mods = 'CTRL', action = act.SpawnTab('CurrentPaneDomain') },
    { key = 'T', mods = 'SHIFT|CTRL', action = act.SpawnTab('CurrentPaneDomain') },
    {
      key = 'U',
      mods = 'CTRL',
      action = act.CharSelect({ copy_on_select = true, copy_to = 'ClipboardAndPrimarySelection' }),
    },
    {
      key = 'U',
      mods = 'SHIFT|CTRL',
      action = act.CharSelect({ copy_on_select = true, copy_to = 'ClipboardAndPrimarySelection' }),
    },
    { key = 'V', mods = 'CTRL', action = act.PasteFrom('Clipboard') },
    { key = 'V', mods = 'SHIFT|CTRL', action = act.PasteFrom('Clipboard') },
    { key = 'W', mods = 'CTRL', action = act.CloseCurrentTab({ confirm = true }) },
    { key = 'W', mods = 'SHIFT|CTRL', action = act.CloseCurrentTab({ confirm = true }) },
    { key = 'X', mods = 'CTRL', action = act.ActivateCopyMode },
    { key = 'X', mods = 'SHIFT|CTRL', action = act.ActivateCopyMode },
    { key = 'Z', mods = 'CTRL', action = act.TogglePaneZoomState },
    { key = 'Z', mods = 'SHIFT|CTRL', action = act.TogglePaneZoomState },
    { key = '[', mods = 'SHIFT|SUPER', action = act.ActivateTabRelative(-1) },
    { key = ']', mods = 'SHIFT|SUPER', action = act.ActivateTabRelative(1) },
    { key = '^', mods = 'CTRL', action = act.ActivateTab(5) },
    { key = '^', mods = 'SHIFT|CTRL', action = act.ActivateTab(5) },
    { key = '_', mods = 'CTRL', action = act.DecreaseFontSize },
    { key = '_', mods = 'SHIFT|CTRL', action = act.DecreaseFontSize },
    { key = 'c', mods = 'SHIFT|CTRL', action = act.CopyTo('Clipboard') },
    { key = 'c', mods = 'SUPER', action = act.CopyTo('Clipboard') },
    { key = 'f', mods = 'SHIFT|CTRL', action = act.Search('CurrentSelectionOrEmptyString') },
    { key = 'f', mods = 'SUPER', action = act.Search('CurrentSelectionOrEmptyString') },
    { key = 'k', mods = 'SHIFT|CTRL', action = act.ClearScrollback('ScrollbackOnly') },
    { key = 'k', mods = 'SUPER', action = act.ClearScrollback('ScrollbackOnly') },
    { key = 'l', mods = 'SHIFT|CTRL', action = act.ShowDebugOverlay },
    { key = 'm', mods = 'SHIFT|CTRL', action = act.Hide },
    { key = 'm', mods = 'SUPER', action = act.Hide },
    { key = 'n', mods = 'SHIFT|CTRL', action = act.SpawnWindow },
    { key = 'n', mods = 'SUPER', action = act.SpawnWindow },
    { key = 'p', mods = 'SHIFT|CTRL', action = act.ActivateCommandPalette },
    { key = 'r', mods = 'SHIFT|CTRL', action = act.ReloadConfiguration },
    { key = 'r', mods = 'SUPER', action = act.ReloadConfiguration },
    { key = 't', mods = 'SHIFT|CTRL', action = act.SpawnTab('CurrentPaneDomain') },
    { key = 't', mods = 'SUPER', action = act.SpawnTab('CurrentPaneDomain') },
    {
      key = 'u',
      mods = 'SHIFT|CTRL',
      action = act.CharSelect({ copy_on_select = true, copy_to = 'ClipboardAndPrimarySelection' }),
    },
    { key = 'v', mods = 'SHIFT|CTRL', action = act.PasteFrom('Clipboard') },
    { key = 'v', mods = 'SUPER', action = act.PasteFrom('Clipboard') },
    { key = 'w', mods = 'SHIFT|CTRL', action = act.CloseCurrentTab({ confirm = true }) },
    { key = 'w', mods = 'SUPER', action = act.CloseCurrentTab({ confirm = true }) },
    { key = 'x', mods = 'SHIFT|CTRL', action = act.ActivateCopyMode },
    { key = 'z', mods = 'SHIFT|CTRL', action = act.TogglePaneZoomState },
    { key = '{', mods = 'SUPER', action = act.ActivateTabRelative(-1) },
    { key = '{', mods = 'SHIFT|SUPER', action = act.ActivateTabRelative(-1) },
    { key = '}', mods = 'SUPER', action = act.ActivateTabRelative(1) },
    { key = '}', mods = 'SHIFT|SUPER', action = act.ActivateTabRelative(1) },
    { key = 'phys:Space', mods = 'SHIFT|CTRL', action = act.QuickSelect },
    { key = 'PageUp', mods = 'SHIFT', action = act.ScrollByPage(-1) },
    { key = 'PageUp', mods = 'CTRL', action = act.ActivateTabRelative(-1) },
    { key = 'PageUp', mods = 'SHIFT|CTRL', action = act.MoveTabRelative(-1) },
    { key = 'PageDown', mods = 'SHIFT', action = act.ScrollByPage(1) },
    { key = 'PageDown', mods = 'CTRL', action = act.ActivateTabRelative(1) },
    { key = 'PageDown', mods = 'SHIFT|CTRL', action = act.MoveTabRelative(1) },
    { key = 'LeftArrow', mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection('Left') },
    { key = 'LeftArrow', mods = 'SHIFT|ALT|CTRL', action = act.AdjustPaneSize({ 'Left', 1 }) },
    { key = 'RightArrow', mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection('Right') },
    { key = 'RightArrow', mods = 'SHIFT|ALT|CTRL', action = act.AdjustPaneSize({ 'Right', 1 }) },
    { key = 'UpArrow', mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection('Up') },
    { key = 'UpArrow', mods = 'SHIFT|ALT|CTRL', action = act.AdjustPaneSize({ 'Up', 1 }) },
    { key = 'DownArrow', mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection('Down') },
    { key = 'DownArrow', mods = 'SHIFT|ALT|CTRL', action = act.AdjustPaneSize({ 'Down', 1 }) },
    { key = 'Insert', mods = 'SHIFT', action = act.PasteFrom('PrimarySelection') },
    { key = 'Insert', mods = 'CTRL', action = act.CopyTo('PrimarySelection') },
    { key = 'Copy', mods = 'NONE', action = act.CopyTo('Clipboard') },
    { key = 'Paste', mods = 'NONE', action = act.PasteFrom('Clipboard') },
  },

  key_tables = {
    copy_mode = {
      { key = 'Tab', mods = 'NONE', action = act.CopyMode('MoveForwardWord') },
      { key = 'Tab', mods = 'SHIFT', action = act.CopyMode('MoveBackwardWord') },
      { key = 'Enter', mods = 'NONE', action = act.CopyMode('MoveToStartOfNextLine') },
      { key = 'Escape', mods = 'NONE', action = act.CopyMode('Close') },
      { key = 'Space', mods = 'NONE', action = act.CopyMode({ SetSelectionMode = 'Cell' }) },
      { key = '$', mods = 'NONE', action = act.CopyMode('MoveToEndOfLineContent') },
      { key = '$', mods = 'SHIFT', action = act.CopyMode('MoveToEndOfLineContent') },
      { key = ',', mods = 'NONE', action = act.CopyMode('JumpReverse') },
      { key = '0', mods = 'NONE', action = act.CopyMode('MoveToStartOfLine') },
      { key = ';', mods = 'NONE', action = act.CopyMode('JumpAgain') },
      { key = 'F', mods = 'NONE', action = act.CopyMode({ JumpBackward = { prev_char = false } }) },
      {
        key = 'F',
        mods = 'SHIFT',
        action = act.CopyMode({ JumpBackward = { prev_char = false } }),
      },
      { key = 'G', mods = 'NONE', action = act.CopyMode('MoveToScrollbackBottom') },
      { key = 'G', mods = 'SHIFT', action = act.CopyMode('MoveToScrollbackBottom') },
      { key = 'H', mods = 'NONE', action = act.CopyMode('MoveToViewportTop') },
      { key = 'H', mods = 'SHIFT', action = act.CopyMode('MoveToViewportTop') },
      { key = 'L', mods = 'NONE', action = act.CopyMode('MoveToViewportBottom') },
      { key = 'L', mods = 'SHIFT', action = act.CopyMode('MoveToViewportBottom') },
      { key = 'M', mods = 'NONE', action = act.CopyMode('MoveToViewportMiddle') },
      { key = 'M', mods = 'SHIFT', action = act.CopyMode('MoveToViewportMiddle') },
      { key = 'O', mods = 'NONE', action = act.CopyMode('MoveToSelectionOtherEndHoriz') },
      { key = 'O', mods = 'SHIFT', action = act.CopyMode('MoveToSelectionOtherEndHoriz') },
      { key = 'T', mods = 'NONE', action = act.CopyMode({ JumpBackward = { prev_char = true } }) },
      { key = 'T', mods = 'SHIFT', action = act.CopyMode({ JumpBackward = { prev_char = true } }) },
      { key = 'V', mods = 'NONE', action = act.CopyMode({ SetSelectionMode = 'Line' }) },
      { key = 'V', mods = 'SHIFT', action = act.CopyMode({ SetSelectionMode = 'Line' }) },
      { key = '^', mods = 'NONE', action = act.CopyMode('MoveToStartOfLineContent') },
      { key = '^', mods = 'SHIFT', action = act.CopyMode('MoveToStartOfLineContent') },
      { key = 'b', mods = 'NONE', action = act.CopyMode('MoveBackwardWord') },
      { key = 'b', mods = 'ALT', action = act.CopyMode('MoveBackwardWord') },
      { key = 'b', mods = 'CTRL', action = act.CopyMode('PageUp') },
      { key = 'c', mods = 'CTRL', action = act.CopyMode('Close') },
      { key = 'd', mods = 'CTRL', action = act.CopyMode({ MoveByPage = 0.5 }) },
      { key = 'e', mods = 'NONE', action = act.CopyMode('MoveForwardWordEnd') },
      { key = 'f', mods = 'NONE', action = act.CopyMode({ JumpForward = { prev_char = false } }) },
      { key = 'f', mods = 'ALT', action = act.CopyMode('MoveForwardWord') },
      { key = 'f', mods = 'CTRL', action = act.CopyMode('PageDown') },
      { key = 'g', mods = 'NONE', action = act.CopyMode('MoveToScrollbackTop') },
      { key = 'g', mods = 'CTRL', action = act.CopyMode('Close') },
      { key = 'h', mods = 'NONE', action = act.CopyMode('MoveLeft') },
      { key = 'j', mods = 'NONE', action = act.CopyMode('MoveDown') },
      { key = 'k', mods = 'NONE', action = act.CopyMode('MoveUp') },
      { key = 'l', mods = 'NONE', action = act.CopyMode('MoveRight') },
      { key = 'm', mods = 'ALT', action = act.CopyMode('MoveToStartOfLineContent') },
      { key = 'o', mods = 'NONE', action = act.CopyMode('MoveToSelectionOtherEnd') },
      { key = 'q', mods = 'NONE', action = act.CopyMode('Close') },
      { key = 't', mods = 'NONE', action = act.CopyMode({ JumpForward = { prev_char = true } }) },
      { key = 'u', mods = 'CTRL', action = act.CopyMode({ MoveByPage = -0.5 }) },
      { key = 'v', mods = 'NONE', action = act.CopyMode({ SetSelectionMode = 'Cell' }) },
      { key = 'v', mods = 'CTRL', action = act.CopyMode({ SetSelectionMode = 'Block' }) },
      { key = 'w', mods = 'NONE', action = act.CopyMode('MoveForwardWord') },
      {
        key = 'y',
        mods = 'NONE',
        action = act.Multiple({
          { CopyTo = 'ClipboardAndPrimarySelection' },
          { CopyMode = 'Close' },
        }),
      },
      { key = 'PageUp', mods = 'NONE', action = act.CopyMode('PageUp') },
      { key = 'PageDown', mods = 'NONE', action = act.CopyMode('PageDown') },
      { key = 'End', mods = 'NONE', action = act.CopyMode('MoveToEndOfLineContent') },
      { key = 'Home', mods = 'NONE', action = act.CopyMode('MoveToStartOfLine') },
      { key = 'LeftArrow', mods = 'NONE', action = act.CopyMode('MoveLeft') },
      { key = 'LeftArrow', mods = 'ALT', action = act.CopyMode('MoveBackwardWord') },
      { key = 'RightArrow', mods = 'NONE', action = act.CopyMode('MoveRight') },
      { key = 'RightArrow', mods = 'ALT', action = act.CopyMode('MoveForwardWord') },
      { key = 'UpArrow', mods = 'NONE', action = act.CopyMode('MoveUp') },
      { key = 'DownArrow', mods = 'NONE', action = act.CopyMode('MoveDown') },
    },

    search_mode = {
      { key = 'Enter', mods = 'NONE', action = act.CopyMode('PriorMatch') },
      { key = 'Escape', mods = 'NONE', action = act.CopyMode('Close') },
      { key = 'n', mods = 'CTRL', action = act.CopyMode('NextMatch') },
      { key = 'p', mods = 'CTRL', action = act.CopyMode('PriorMatch') },
      { key = 'r', mods = 'CTRL', action = act.CopyMode('CycleMatchType') },
      { key = 'u', mods = 'CTRL', action = act.CopyMode('ClearPattern') },
      { key = 'PageUp', mods = 'NONE', action = act.CopyMode('PriorMatchPage') },
      { key = 'PageDown', mods = 'NONE', action = act.CopyMode('NextMatchPage') },
      { key = 'UpArrow', mods = 'NONE', action = act.CopyMode('PriorMatch') },
      { key = 'DownArrow', mods = 'NONE', action = act.CopyMode('NextMatch') },
    },
  },
}

return M
