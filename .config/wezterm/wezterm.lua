local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.default_prog = { "/bin/bash" }
local act = wezterm.action

config.keys = {
    { key = "v", mods = "CTRL", action = act.PasteFrom("Clipboard") },

    { key = "v", mods = "CTRL", action = act.PasteFrom("PrimarySelection") },
}

config.mouse_bindings = {
    {
        event = { Up = { streak = 1, button = "Right" } },
        mods = "NONE",
        action = act.PasteFrom("PrimarySelection"),
    },
}

config.window_background_opacity = 1.0

config.color_scheme = "Catppuccin Mocha"

config.font = wezterm.font_with_fallback({
    { family = "JetBrains Mono", weight = "Regular" },
    { family = "JetBrains Mono", weight = "Bold",     italic = true },
    { family = "JetBrains Mono", weight = "ExtraBold" },
})

config.font_size = 10
config.enable_tab_bar = false

-- Rendering Method: OpenGL, Software, WebGpu
config.front_end = "Software"

return config
