local function toggle_venn()
  if vim.b.venn_enabled == nil then
    vim.b.venn_enabled = true
    vim.wo.virtualedit = 'all'
    -- draw a line on HJKL keystokes
    vim.keymap.set('n', 'J', [[<C-v>j:VBox<CR>]], { buffer = true })
    vim.keymap.set('n', 'K', [[<C-v>k:VBox<CR>]], { buffer = true })
    vim.keymap.set('n', 'L', [[<C-v>l:VBox<CR>]], { buffer = true })
    vim.keymap.set('n', 'H', [[<C-v>h:VBox<CR>]], { buffer = true })
  else
    vim.wo.virtualedit = 'none'

    vim.keymap.del('n', 'J', { buffer = true })
    vim.keymap.del('n', 'K', { buffer = true })
    vim.keymap.del('n', 'L', { buffer = true })
    vim.keymap.del('n', 'H', { buffer = true })

    vim.b.venn_enabled = nil
  end
end

vim.api.nvim_create_user_command('Venn', toggle_venn, {})
