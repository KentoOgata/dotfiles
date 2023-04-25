return {
  provider = function()
    local ftime = vim.fn.getftime(vim.api.nvim_buf_get_name(0))
    return (ftime > 0) and os.date('%c', ftime)
  end,
}
