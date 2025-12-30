-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Themes / UI
config.color_scheme = "Catppuccin Frappe"
-- config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.font = wezterm.font("MesloLGS NF")
config.font_size = 14
config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.window_background_opacity = 1
config.macos_window_background_blur = 10
config.window_padding = {
  left = 10,
  right = 10,
  top = 10,
  bottom = 0,
}

config.animation_fps = 120
config.cursor_blink_rate = 500 -- lower = faster blink (ms)
config.cursor_blink_ease_in = "Linear"
config.cursor_blink_ease_out = "Linear"

config.keys = {
  {
    key = "Enter",
    mods = "CMD",
    action = wezterm.action.ToggleFullScreen,
  },
}


-- and finally, return the configuration to wezterm
return config
