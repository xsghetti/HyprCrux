------------------
---- MONITORS ----
------------------

-- hl.monitor({ output = "DP-2", mode = "1920x1080@100", position = "0x250", scale = 1 })
-- hl.monitor({ output = "DP-1", mode = "1920x1080@100", position = "auto",  scale = 1, transform = 3 })

hl.monitor({ output = "eDP-1", mode = "1920x1080@144", position = "auto", scale = 1 })

hl.workspace_rule({ workspace = "1", monitor = "eDP-1", persistent = true, layout = "scrolling", default = true })
hl.workspace_rule({ workspace = "2", monitor = "eDP-1", persistent = true, layout = "scrolling" })
hl.workspace_rule({ workspace = "3", monitor = "eDP-1", persistent = true })
hl.workspace_rule({ workspace = "4", monitor = "eDP-1", persistent = true })
hl.workspace_rule({ workspace = "5", monitor = "eDP-1", persistent = true })


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE",               "24")
hl.env("XCURSOR_THEME",              "Oxygen-35-Black-Zion")
hl.env("QT_QPA_PLATFORMTHEME",       "qt6ct")
hl.env("LIBVA_DRIVER_NAME",          "nvidia")
hl.env("XDG_SESSION_TYPE",           "wayland")
hl.env("XDG_SESSION_DESKTOP",        "Hyprland")
hl.env("XDG_CURRENT_DESKTOP",        "Hyprland")
hl.env("GBM_BACKEND",                "nvidia-drm")
hl.env("__GLX_VENDOR_LIBRARY_NAME",  "nvidia")
hl.env("WLR_RENDERER_ALLOW_SOFTWARE","1")
hl.env("AQ_DRM_DEVICES",             "/dev/dri/card0:/dev/dri/card2")


-----------------
---- GENERAL ----
-----------------

hl.config({
    cursor = {
        no_hardware_cursors = true,
    },

    input = {
        kb_layout          = "us",
        kb_variant         = "",
        kb_model           = "",
        kb_options         = "",
        kb_rules           = "",
        numlock_by_default = true,
        follow_mouse       = 1,
        sensitivity        = 0.3,
        touchpad = {
            natural_scroll = false,
        },
    },

    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    scrolling = {
        follow_focus             = true,
        follow_min_visible       = 1,
        fullscreen_on_one_column = true,
    },

    misc = {
        force_default_wallpaper  = 0,
        disable_hyprland_logo    = true,
        disable_splash_rendering = true,
    },

    ecosystem = {
        no_donation_nag = true,
    },

    debug = {
        disable_logs = false,
    },
})

-----------------
---- MODULES ----
-----------------

require("animations")
require("keybinds")
require("windowrules")
require("exec")
require("hve")
