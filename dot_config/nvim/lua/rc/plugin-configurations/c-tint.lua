require('tint').setup {
  window_ignore_function = function(winid)
    local bufid = vim.api.nvim_win_get_buf(winid)
    local buftype = vim.api.nvim_buf_get_option(bufid, 'buftype')
    local floating = vim.api.nvim_win_get_config(winid).relative ~= ''
    return buftype == 'terminal' or floating
  end,
}

vim.api.nvim_create_user_command('TintToggle', function()
  require('tint').toggle()
end, {})
