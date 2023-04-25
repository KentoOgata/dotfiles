return {
  provider = function()
    local fmt = vim.bo.fileformat
    return fmt ~= 'unix' and fmt:upper()
  end,
}
