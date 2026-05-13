local mainMod     = "SUPER"
local ipc         = "qs -c noctalia-shell ipc call"
local terminal    = "kitty"
local fileManager = "kitty -e yazi"
local menu        = "rofi -show drun"
local browser     = "firefox"
local discord     = "discord"
local editor      = "kitty -e nvim"

local function mod(extra, key)
    if extra == "" then return mainMod .. " + " .. key end
    return mainMod .. " + " .. extra .. " + " .. key
end


----- Noctalia binds -----
hl.bind(mod("",      "A"),     hl.dsp.exec_cmd(ipc .. " launcher toggle"))
hl.bind(mod("",      "S"),     hl.dsp.exec_cmd(ipc .. " controlCenter toggle"))
hl.bind(mod("",      "comma"), hl.dsp.exec_cmd(ipc .. " settings toggle"))


----- Media keys -----
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd(ipc .. " volume increase"),     { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd(ipc .. " volume decrease"),     { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd(ipc .. " volume muteOutput"),   { locked = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd(ipc .. " brightness increase"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(ipc .. " brightness decrease"), { locked = true, repeating = true })


----- App launchers / actions -----
hl.bind(mod("",       "F"),      hl.dsp.exec_cmd(browser))
hl.bind(mod("",       "R"),      hl.dsp.exec_cmd("pypr toggle term"))
hl.bind(mod("SHIFT",  "N"),      hl.dsp.exec_cmd("pypr toggle notes"))
hl.bind(mod("SHIFT",  "ESCAPE"), hl.dsp.exec_cmd("qs -c noctalia-shell"))
hl.bind(mod("",       "D"),      hl.dsp.exec_cmd(discord))
hl.bind(mod("SHIFT",  "F"),      hl.dsp.window.fullscreen())
hl.bind(mod("",       "N"),      hl.dsp.exec_cmd("swaync-client -t -sw"))
hl.bind(mod("",       "L"),      hl.dsp.exec_cmd(ipc .. " lockScreen lock"))
hl.bind(mod("SHIFT",  "L"),      hl.dsp.exec_cmd("kitty --session ~/rain.conf"))
hl.bind(mod("ALT",    "L"),      hl.dsp.exec_cmd("dashboard"))
hl.bind(mod("",       "W"),      hl.dsp.exec_cmd(ipc .. " wallpaper toggle"))
hl.bind(mod("",       "G"),      hl.dsp.window.pin())
hl.bind(mod("",       "M"),      hl.dsp.exec_cmd("wlogout"))
hl.bind(mod("SHIFT",  "E"),      hl.dsp.exec_cmd(editor))

hl.bind(mod("",      "T"),      hl.dsp.exec_cmd(terminal))
hl.bind(mod("",      "Q"),      hl.dsp.window.close())
hl.bind(mod("",      "ESCAPE"), hl.dsp.exit())
hl.bind(mod("",      "E"),      hl.dsp.exec_cmd(fileManager))
hl.bind(mod("",      "V"),      hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod("SHIFT", "P"),      hl.dsp.window.pseudo())
hl.bind(mod("",      "J"),      hl.dsp.layout("togglesplit"))


----- Focus -----
hl.bind(mod("", "left"),  hl.dsp.focus({ direction = "l" }))
hl.bind(mod("", "right"), hl.dsp.focus({ direction = "r" }))
hl.bind(mod("", "up"),    hl.dsp.focus({ direction = "u" }))
hl.bind(mod("", "down"),  hl.dsp.focus({ direction = "d" }))


----- Workspaces -----
for i = 1, 10 do
    local key = i % 10
    hl.bind(mod("",      tostring(key)), hl.dsp.focus({ workspace = i }))
    hl.bind(mod("SHIFT", tostring(key)), hl.dsp.window.move({ workspace = i }))
    hl.bind(mod("ALT",   tostring(key)), hl.dsp.window.move({ workspace = i, follow = false }))
end

hl.bind(mod("CTRL + ALT", "right"), hl.dsp.window.move({ workspace = "r+1" }))
hl.bind(mod("CTRL + ALT", "left"),  hl.dsp.window.move({ workspace = "r-1" }))

hl.bind(mod("SHIFT + CTRL", "left"),  hl.dsp.window.move({ direction = "l" }))
hl.bind(mod("SHIFT + CTRL", "right"), hl.dsp.window.move({ direction = "r" }))
hl.bind(mod("SHIFT + CTRL", "up"),    hl.dsp.window.move({ direction = "u" }))
hl.bind(mod("SHIFT + CTRL", "down"),  hl.dsp.window.move({ direction = "d" }))

hl.bind(mod("SHIFT", "S"), hl.dsp.workspace.toggle_special("magic"))

hl.bind(mod("SHIFT", "mouse_down"), hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mod("SHIFT", "mouse_up"),   hl.dsp.focus({ workspace = "e+1" }))


----- Mouse drag / resize -----
hl.bind(mod("", "mouse:272"), hl.dsp.window.drag(),   { mouse = true })
hl.bind(mod("", "mouse:273"), hl.dsp.window.resize(), { mouse = true })


----- Screenshots -----
local home = os.getenv("HOME")
hl.bind(mod("",     "P"),     hl.dsp.exec_cmd(home .. "/.config/hypr/scripts/screenshot.sh s"))
hl.bind(mod("CTRL", "P"),     hl.dsp.exec_cmd(home .. "/.config/hypr/scripts/screenshot.sh sf"))
hl.bind(mod("ALT",  "P"),     hl.dsp.exec_cmd(home .. "/.config/hypr/scripts/screenshot.sh m"))
hl.bind("print",              hl.dsp.exec_cmd(home .. "/.config/hypr/scripts/screenshot.sh p"))


----- Audio (scripted) -----
hl.bind("F11",                  hl.dsp.exec_cmd(home .. "/.config/hypr/scripts/volumecontrol.sh -o d"), { locked = true, repeating = true })
hl.bind("F12",                  hl.dsp.exec_cmd(home .. "/.config/hypr/scripts/volumecontrol.sh -o i"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd(home .. "/.config/hypr/scripts/volumecontrol.sh -i m"), { locked = true })
hl.bind("XF86AudioPlay",        hl.dsp.exec_cmd("playerctl play-pause"),                                { locked = true })
hl.bind("XF86AudioPause",       hl.dsp.exec_cmd("playerctl play-pause"),                                { locked = true })
hl.bind("XF86AudioNext",        hl.dsp.exec_cmd("playerctl next"),                                       { locked = true })
hl.bind("XF86AudioPrev",        hl.dsp.exec_cmd("playerctl previous"),                                   { locked = true })


----- Quickshell overview -----
hl.bind("ALT + TAB", hl.dsp.exec_cmd("qs ipc -c overview call overview toggle"))


----- Adjust gaps -----
hl.bind(mod("SHIFT", "UP"),    hl.dsp.exec_cmd(home .. "/.config/hypr/scripts/gaps_out.sh up"),   { repeating = true })
hl.bind(mod("SHIFT", "DOWN"),  hl.dsp.exec_cmd(home .. "/.config/hypr/scripts/gaps_out.sh down"), { repeating = true })
hl.bind(mod("SHIFT", "left"),  hl.dsp.exec_cmd(home .. "/.config/hypr/scripts/gaps_in.sh down"),  { repeating = true })
hl.bind(mod("SHIFT", "right"), hl.dsp.exec_cmd(home .. "/.config/hypr/scripts/gaps_in.sh up"),    { repeating = true })


----- Scrolling layout -----
hl.bind(mod("",      "bracketleft"),  hl.dsp.layout("move -col"))
hl.bind(mod("",      "bracketright"), hl.dsp.layout("move +col"))
hl.bind(mod("",      "mouse_up"),     hl.dsp.layout("move +col"))
hl.bind(mod("",      "mouse_down"),   hl.dsp.layout("move -col"))
hl.bind(mod("SHIFT", "r"),            hl.dsp.layout("colresize +conf"))



