require('pasta').setup {
  converters = {
    require('pasta.converters').indentation,
  },
  paste_mode = true,
  prevent_diagnostics = false,
  next_key = vim.api.nvim_replace_termcodes('<C-p>', true, true, true),
  prev_key = vim.api.nvim_replace_termcodes('<C-n>', true, true, true),
}

vim.keymap.set({ 'n', 'x' }, '<Plug>(pasta-p)', require('pasta.mappings').p)
vim.keymap.set({ 'n', 'x' }, '<Plug>(pasta-P)', require('pasta.mappings').P)
vim.keymap.set('n', '<Plug>(pasta-toggle_pin)', require('pasta.mappings').toggle_pin)
