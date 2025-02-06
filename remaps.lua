local wezterm = require 'wezterm'

local remaps = {}

remaps.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 2000 }

remaps.keys = {
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
        key = 'n',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.DisableDefaultAssignment
    }
}


for i = 1, 9 do
    table.insert(remaps.keys, {
        key = tostring(i),
        mods = 'LEADER',
        action = wezterm.action.ActivateTab(i - 1),
    })
end

return remaps
