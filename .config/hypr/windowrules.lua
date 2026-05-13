-- Opacities
hl.window_rule({ match = { class = "^(spotify)$" },          opacity = "0.80 0.80", workspace = "3 silent" })
hl.window_rule({ match = { class = "^(dolphin)$" },          opacity = "0.80 0.80" })
hl.window_rule({ match = { class = "^(discord)$" },          opacity = "0.90 0.90", workspace = "1" })
hl.window_rule({ match = { class = "^(steam)$" },            opacity = "0.80 0.80", workspace = "3" })
hl.window_rule({ match = { class = "^(kitty)$" },            opacity = "0.80 0.80" })
hl.window_rule({ match = { class = "^(kitty-dropterm)$" },   opacity = "0.80 0.80" })
hl.window_rule({ match = { class = "^(bettersoundcloud)$" }, opacity = "0.80 0.80", workspace = "5 silent" })
hl.window_rule({ match = { class = "^(Termius)$" },          opacity = "0.80 0.80" })

-- Floating
hl.window_rule({ match = { class = "^(nwg-look)$" },                                    float = true })
hl.window_rule({ match = { class = "^(eog)$" },                                         float = true })
hl.window_rule({ match = { class = "^(org.pulseaudio.pavucontrol)$" },                  float = true, size = {750, 550}, move = {1148, 28} })
hl.window_rule({ match = { class = "^(blueman-manager)$" },                             float = true, move = {1262, 32} })
hl.window_rule({ match = { class = "^(nm-applet)$" },                                   float = true })
hl.window_rule({ match = { class = "^(nm-connection-editor)$" },                        float = true })
hl.window_rule({ match = { class = "^(org.kde.polkit-kde-authentication-agent-1)$" },   float = true })

-- Steam
hl.window_rule({ match = { class = "^(steam)$", title = "^(Friends List)$" },           float = true })
hl.window_rule({ match = { class = "^(steam)$", title = "^()$" },                       stay_focused = true, min_size = {1, 1} })
hl.window_rule({ match = { class = "^(steam_app_1476970)$" },                           workspace = "2 silent" })

-- Noctalia background layer
hl.layer_rule({
    name           = "noctalia-bg",
    match          = { namespace = "^(noctalia-background-).*$" },
    ignore_alpha   = 0.5,
    blur           = true,
    blur_popups    = true,
})
