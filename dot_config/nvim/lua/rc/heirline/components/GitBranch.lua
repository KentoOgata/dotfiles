local conditions = require 'heirline.conditions'

return {
  condition = conditions.is_git_repo,
  init = function(self)
    if pcall(require, 'gitsigns') then
      local bufnr = vim.api.nvim_get_current_buf()
      self.status_dict = vim.b[bufnr].gitsigns_status_dict
    end
  end,
  hl = { fg = 'orange' },
  provider = function(self)
    return ' ' .. self.status_dict.head
  end,
}
