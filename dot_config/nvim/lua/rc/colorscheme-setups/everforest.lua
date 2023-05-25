local pick = require('rc.utils').pick

vim.go.background = pick { 'dark', 'light' }

local function setOpt(name, value)
  vim.g['everforest_' .. name] = value
end

setOpt('background', pick { 'hard', 'medium', 'soft' })
setOpt('enable_italic', 0)
setOpt('disable_italic_comment', 1)
setOpt('cursor', 'auto')
setOpt('transparent_background', 0)
setOpt('sign_column_background', 'none')
setOpt('spell_foreground', 'none')
setOpt('ui_contrast', pick { 'low', 'high' })
setOpt('show_eob', 1)
setOpt('diagnostic_text_highlight', 1)
setOpt('diagnostic_line_highlight', 0)
setOpt('diagnostic_virtual_text', 'colored')
setOpt('current_word', 'grey background')
setOpt('disable_terminal_colors', 0)
setOpt('better_performance', 1)
