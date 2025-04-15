local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.font = wezterm.font 'FiraCode Nerd Font'
config.font_size = 16

config.color_scheme = 'Catppuccin Macchiato'
config.enable_tab_bar = false

return config
