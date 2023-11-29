local wezterm = require('wezterm')
local config = {}

config.term = 'wezterm'
config.front_end = 'WebGpu'
config.font = wezterm.font_with_fallback({
  'Maple Mono',
  { family = 'Symbols Nerd Font Mono', scale = 0.7 },
})
config.color_scheme = 'Catppuccin Mocha'
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
-- config.allow_win32_input_mode = false
-- config.enable_csi_u_key_encoding = true
-- config.enable_kitty_keyboard = true
config.disable_default_key_bindings = true

local keymaps = require('keymaps')

config.leader = keymaps.leader
config.keys = keymaps.keys

local domains = require('domains')
config.unix_domains = domains.unix

wezterm.on('mux-startup', function()
  wezterm.log_info('mux-startup hi')
end)

return config
