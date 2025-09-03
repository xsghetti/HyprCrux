return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- Set header
    dashboard.section.header.val = {
    	[[                                                                       ]],
	[[                                                                     ]],
	[[       ████ ██████           █████      ██                     ]],
	[[      ███████████             █████                             ]],
	[[      █████████ ███████████████████ ███   ███████████   ]],
	[[     █████████  ███    █████████████ █████ ██████████████   ]],
	[[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
	[[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
	[[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
	[[                                                                       ]],
    }

    -- Set menu
    dashboard.section.buttons.val = {
      dashboard.button( "L", "                    Lazy                       ", "<cmd>Lazy<CR>"),
      dashboard.button( "N", "󰱽                    New File                   ", "<cmd>ene<CR>"),
      dashboard.button( "Y", "                    Hyprland                   ", ":e ~/.config/hypr/<CR>"),
      dashboard.button( "P", "                    Plugins                    ", ":e ~/.config/nvim/lua/crux/plugins<CR>"),
      dashboard.button( "H", "󰋖                    Command Help               ", ":Telescope help_tags<CR>"),
      dashboard.button( "C", "                    Colors                     ", ":Telescope colorscheme<CR>"),
      dashboard.button( "Q", "󰩈                    Quit                       ", ":qa<CR>"),
    }

    -- Send config to alpha
    alpha.setup(dashboard.opts)

    -- Disable folding on alpha buffer
    vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
  end,
}
