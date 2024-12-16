local wezterm = require 'wezterm'
local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.font = wezterm.font 'JetBrains Mono'
config.color_scheme = 'rose-pine'

config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true

config.max_fps = 240

config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 2000 }
config.keys = {}

-- OS Specific Configs
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
    -- Behave like Tmux on Windows
    local sessionizer = require 'sessionizer'
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
            }
        },
    }

    for i = 1, 9 do
        table.insert(config.keys, {
            key = tostring(i),
            mods = 'LEADER',
            action = wezterm.action.ActivateTab(i - 1),
        })
    end
    config.default_prog = { 'pwsh.exe'}

else
    -- Give CTRL-Tab behavior to Tmux
    config.keys = {
        {
            key = "Tab",
            mods = "CTRL",
            action = wezterm.action.DisableDefaultAssignment,
        },
    }
end

if wezterm.target_triple:find("darwin") ~= nil then
    config.font_size = 14
end

return config
