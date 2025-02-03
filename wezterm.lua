local wezterm = require 'wezterm'
local remaps = require 'remaps'

local config = {}
config.font = wezterm.font('JetBrains Mono')
config.harfbuzz_features = {"calt=0", "clig=0", "liga=0"}

config.color_scheme = 'Molokai'

config.leader = remaps.leader
config.keys = remaps.keys

config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true

config.max_fps = 240

if wezterm.target_triple:find("darwin") ~= nil then
    config.font_size = 14
end

if wezterm.target_triple:find("windows") ~= nil then
    config.default_prog = { 'pwsh.exe'}
end

return config
