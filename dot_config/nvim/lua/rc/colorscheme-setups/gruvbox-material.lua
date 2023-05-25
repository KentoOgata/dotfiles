local pick = require('rc.utils').pick

vim.go.background = 'dark'

local function setOpt(name, value)
  vim.g['gruvbox_material_' .. name] = value
end

setOpt('background', pick { 'hard', 'medium', 'soft' })
setOpt('foreground', pick { 'material', 'mix', 'original' })
setOpt('disable_italic_comment', 1)
setOpt('enable_bold', 0)
setOpt('enable_italic', 0)
setOpt('cursor', 'auto')
setOpt('transparent_background', 0)
setOpt('visual', 'grey background')
setOpt('menu_selection_background', 'grey')
setOpt('spell_foreground', 'none')
setOpt('ui_contrast', pick { 'low', 'high' })
setOpt('show_eob', 1)
setOpt('diagnostic_text_highlight', 1)
setOpt('diagnostic_line_highlight', 1)
setOpt('diagnostic_virtual_text', 'colored')
setOpt('current_word', 'grey background')
setOpt('disable_terminal_colors', 0)
setOpt('statusline_style', pick { 'default', 'mix', 'original' })
setOpt('better_performance', 1)
