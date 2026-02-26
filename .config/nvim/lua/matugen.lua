 local M = {}

 function M.setup()
   require('base16-colorscheme').setup {
     -- Background tones
     base00 = '#1f1f1f', -- Default Background
     base01 = '#333333', -- Lighter Background (status bars)
     base02 = '#2e2e2e', -- Selection Background
     base03 = '#696969', -- Comments, Invisibles
     -- Foreground tones
     base04 = '#b6afaf', -- Dark Foreground (status bars)
     base05 = '#f3f2f2', -- Default Foreground
     base06 = '#f3f2f2', -- Light Foreground
     base07 = '#f3f2f2', -- Lightest Foreground
     -- Accent colors
     base08 = '#fd4663', -- Variables, XML Tags, Errors
     base09 = '#cc6666', -- Integers, Constants
     base0A = '#d65c5c', -- Classes, Search Background
     base0B = '#e46767', -- Strings, Diff Inserted
     base0C = '#e99696', -- Regex, Escape Chars
     base0D = '#ec9393', -- Functions, Methods
     base0E = '#e99696', -- Keywords, Storage
     base0F = '#900017', -- Deprecated, Embedded Tags
   }
 end

 -- Register a signal handler for SIGUSR1 (matugen updates)
 local signal = vim.uv.new_signal()
 signal:start(
   'sigusr1',
   vim.schedule_wrap(function()
     package.loaded['matugen'] = nil
     require('matugen').setup()
   end)
 )

 return M
