local wezterm = require 'wezterm'
local sessionizer = require 'sessionizer'
local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.font = wezterm.font 'JetBrains Mono'

config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true

config.leader = { key = 'b', mods = 'CTRL', timeout_milliseconds = 2000 }
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
        key = 'f',
        mods = 'CTRL',
        action = wezterm.action_callback(sessionizer.toggle)
    },
    {
        key = 'h',
        mods = 'LEADER',
        action = wezterm.action.SwitchToWorkspace {
        name = 'default',
    },
  },
}

-- <leader> 1 through 9 switch to respective tab
for i = 1, 9 do
    table.insert(config.keys, {
        key = tostring(i),
        mods = 'LEADER',
        action = wezterm.action.ActivateTab(i - 1),
    })
end

-- OS Specific Configs
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
    config.default_prog = { 'pwsh.exe'}
end

if wezterm.target_triple:find("darwin") ~= nil then
    config.font_size = 14
end

return config
