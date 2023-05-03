local wezterm = require("wezterm")

local config

if wezterm.config_builder then
	config = wezterm.config_builder()
else
	config = {}
end

config.font = wezterm.font("CaskaydiaCove Nerd Font")

return config
