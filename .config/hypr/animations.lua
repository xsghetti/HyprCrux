hl.config({
    general = {
        gaps_in     = 10,
        gaps_out    = 10,
        border_size = 2,

        resize_on_border       = true,
        extend_border_grab_area = 15,

        layout        = "scrolling",
        allow_tearing = false,

        snap = {
            enabled       = true,
            respect_gaps  = true,
        },
    },

    decoration = {
        rounding       = 40,
        rounding_power = 1,

        active_opacity   = 1,
        inactive_opacity = 1,

        shadow = {
            enabled = false,
        },

        blur = {
            enabled           = true,
            size              = 2,
            passes            = 3,
            new_optimizations = true,
            ignore_opacity    = true,
            xray              = false,
            brightness        = 1,
            vibrancy          = 0.50,
            vibrancy_darkness = 0.50,
            contrast          = 1.0,
            popups            = true,
        },
    },

    animations = {
        enabled = true,
    },
})
