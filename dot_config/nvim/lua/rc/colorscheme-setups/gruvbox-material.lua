local pick = require('rc.utils').pick

vim.go.background = 'dark'

local opts = {
  background = pick { 'hard', 'medium', 'soft' },
  foreground = pick { 'material', 'mix', 'original' },
  disable_italic_comment = 1,
  enable_bold = 0,
  enable_italic = 0,
  cursor = pick { 'red', 'orange', 'yellow', 'green', 'blue', 'purple' },
  transparent_background = 0,
  visual = 'grey background',
  menu_selection_background = 'grey',
  spell_foreground = 'none',
  ui_contrast = pick { 'low', 'high' },
  show_eob = 1,
  diagnostic_text_highlight = 1,
  diagnostic_line_highlight = 1,
  diagnostic_virtual_text = 'colored',
  current_word = 'grey background',
  disable_terminal_colors = 0,
  statusline_style = pick { 'default', 'mix', 'original' },
  better_performance = 1,
}

for opt, value in pairs(opts) do
  vim.g['gruvbox_material_' .. opt] = value
end
