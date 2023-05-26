local pick = require('rc.utils').pick

vim.go.background = pick { 'dark', 'light' }

local opts = {
  background = pick { 'hard', 'medium', 'soft' },
  enable_italic = 0,
  disable_italic_comment = 1,
  cursor = 'auto',
  transparent_background = 0,
  sign_column_background = 'none',
  spell_foreground = 'none',
  ui_contrast = pick { 'low', 'high' },
  show_eob = 1,
  diagnostic_text_highlight = 1,
  diagnostic_line_highlight = 0,
  diagnostic_virtual_text = 'colored',
  current_word = 'grey background',
  disable_terminal_colors = 0,
  better_performance = 1,
}

for opt, value in pairs(opts) do
  vim.g['everforest_' .. opt] = value
end
