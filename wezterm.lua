local wezterm = require 'wezterm'
local config = {}

config.font = wezterm.font('JetBrains Mono')
config.harfbuzz_features = {"calt=0", "clig=0", "liga=0"}
config.window_background_opacity = 0.8 
config.color_scheme = 'Molokai'

config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true

config.max_fps = 240

config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 2000 }
config.keys = {}

config.keys = {
    {
        key = "'",
        mods = 'LEADER',
        action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' }
    },
    {
        key = "%",
        mods = 'LEADER|SHIFT',
        action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' }
    },
    {
        key = "d",
        mods = 'LEADER',
        action = wezterm.action.CloseCurrentPane { confirm = true }
    },
    {
        key = "c",
        mods = 'LEADER',
        action = wezterm.action.SpawnTab 'CurrentPaneDomain'
    },
    {
        key = 'h',
        mods = 'LEADER',
        action = wezterm.action.SwitchToWorkspace {
            name = 'default',
        }
    },
    {
        key = "Tab",
        mods = "CTRL",
        action = wezterm.action.DisableDefaultAssignment,
    },
}

for i = 1, 9 do
    table.insert(config.keys, {
        key = tostring(i),
        mods = 'LEADER',
        action = wezterm.action.ActivateTab(i - 1),
    })
end

if wezterm.target_triple:find("darwin") ~= nil then
    config.font_size = 14
end

if wezterm.target_triple:find("windows") ~= nil then
    config.default_prog = { 'pwsh.exe'}
end

return config
