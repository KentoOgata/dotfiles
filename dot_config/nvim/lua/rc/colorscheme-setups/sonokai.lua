local pick = require('rc.utils').pick

vim.go.background = 'dark'

local opts = {
  style = pick { 'default', 'atlantis', 'andromeda', 'shusia', 'maia', 'espresso' },
  disable_italic_comment = 1,
  enable_italic = 0,
  cursor = pick { 'red', 'orange', 'yellow', 'green', 'blue', 'purple' },
  transparent_background = 0,
  menu_selection_background = 'blue',
  spell_foreground = 'none',
  show_eob = 1,
  diagnostic_text_highlight = 1,
  diagnostic_line_highlight = 1,
  diagnostic_virtual_text = 'colored',
  current_word = 'grey background',
  disable_terminal_colors = 0,
  better_performance = 1,
}

for opt, value in pairs(opts) do
  vim.g['sonokai_' .. opt] = value
end
