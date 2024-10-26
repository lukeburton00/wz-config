local wezterm = require("wezterm")
local act = wezterm.action

local M = {}

local home
local fd
local rootPath
local configPath

if wezterm.target_triple:find("windows") ~= nil then
    home = os.getenv( "USERPROFILE" )
    fd = home .. "/AppData/Local/Microsoft/WinGet/Packages/sharkdp.fd_Microsoft.Winget.Source_8wekyb3d8bbwe/fd-v10.2.0-x86_64-pc-windows-msvc/fd.exe"
    rootPath = "C:/Dev"
    configPath = home .. "/.config"
end

if wezterm.target_triple:find("darwin") ~= nil then
    home = os.getenv( "HOME" )
    fd = "/opt/homebrew/bin/fd"
    rootPath = home .. "/dev"
    configPath = home .. "/.config"
end

M.toggle = function(window, pane)
  local projects = {}

  local success, stdout, stderr = wezterm.run_child_process({
    fd,
    "-HI",
    "-td",
    "^.git$",
    "--max-depth=4",
    rootPath,
    configPath
  })

  if not success then
    wezterm.log_error("Failed to run fd: " .. stderr)
    return
  end

  for line in stdout:gmatch("([^\n]*)\n?") do
    local project = line:gsub("/.git/$", "")
    local label = project
    local id = project:gsub(".*/", "")
    table.insert(projects, { label = tostring(label), id = tostring(id) })
  end

  window:perform_action(
    act.InputSelector({
      action = wezterm.action_callback(function(win, _, id, label)
        if not id and not label then
          wezterm.log_info("Cancelled")
        else
          wezterm.log_info("Selected " .. label)
          win:perform_action(
            act.SwitchToWorkspace({ name = id, spawn = { cwd = label } }),
            pane
          )
        end
      end),
      fuzzy = true,
      title = "Select project",
      choices = projects,
    }),
    pane
  )
end

return M
