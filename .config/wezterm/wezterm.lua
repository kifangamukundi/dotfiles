local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.default_prog = { "/bin/bash" }
local act = wezterm.action

config.keys = { { key = "v", mods = "CTRL", action = act.PasteFrom("Clipboard") }, { key = "v", mods = "CTRL", action = act.PasteFrom("PrimarySelection") }, }

config.mouse_bindings = { { event = { Up = { streak = 1, button = "Right" } }, mods = "NONE", action = act.PasteFrom("PrimarySelection"), }, }

config.window_background_opacity = 0.98

config.color_scheme = "Dracula+"

config.font = wezterm.font_with_fallback({ { family = "JetBrains Mono", weight = "Regular" }, })

config.font_size = 12
config.enable_tab_bar = false

-- Rendering Method: OpenGL, Software, WebGpu
config.front_end = "Software"

return config
