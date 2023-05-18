local conditions = require 'heirline.conditions'

return {
  condition = conditions.is_git_repo,
  init = function(self)
    if pcall(require, 'gitsigns') then
      local bufnr = vim.api.nvim_get_current_buf()
      self.status_dict = vim.b[bufnr].gitsigns_status_dict
      self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
    end
  end,
  {
    provider = function(self)
      local count = self.status_dict.added or 0
      return count > 0 and ('+' .. count)
    end,
    hl = 'diffAdded',
  },
  {
    provider = function(self)
      local count = self.status_dict.removed or 0
      return count > 0 and ('-' .. count)
    end,
    hl = 'diffDeleted',
  },
  {
    provider = function(self)
      local count = self.status_dict.changed or 0
      return count > 0 and ('~' .. count)
    end,
    hl = 'diffChanged',
  },
}
