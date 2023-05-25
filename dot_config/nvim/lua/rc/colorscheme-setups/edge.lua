local pick = require('rc.utils').pick

vim.go.background = 'dark'

local function setOpt(name, value)
  vim.g['edge_' .. name] = value
end

setOpt('style', pick { 'default', 'aura', 'neon' })
setOpt('dim_foreground', 0)
setOpt('disable_italic_comment', 1)
setOpt('enable_italic', 0)
setOpt('cursor', 'auto')
setOpt('transparent_background', 0)
setOpt('menu_selection_background', 'blue')
setOpt('spell_foreground', 'none')
setOpt('show_eob', 1)
setOpt('diagnostic_text_highlight', 1)
setOpt('diagnostic_line_highlight', 1)
setOpt('diagnostic_virtual_text', 'colored')
setOpt('current_word', 'grey background')
setOpt('disable_terminal_colors', 0)
setOpt('better_performance', 1)
