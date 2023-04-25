local conditions = require 'heirline.conditions'

return {
  condition = conditions.has_diagnostics,
  update = { 'DiagnosticChanged', 'BufEnter' },
  on_click = {
    callback = function()
      require('trouble').toggle { mode = 'document_diagnostics' }
    end,
    name = 'heirline_diagnostics',
  },
  static = {
    error_icon = vim.fn.sign_getdefined('DiagnosticSignError')[1].text,
    warn_icon = vim.fn.sign_getdefined('DiagnosticSignWarn')[1].text,
    info_icon = vim.fn.sign_getdefined('DiagnosticSignInfo')[1].text,
    hint_icon = vim.fn.sign_getdefined('DiagnosticSignHint')[1].text,
  },
  init = function(self)
    self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
  end,
  {
    provider = function(self)
      return self.errors > 0 and (self.error_icon .. self.errors .. ' ')
    end,
    hl = 'DiagnosticError',
  },
  {
    provider = function(self)
      return self.warnings > 0 and (self.warn_icon .. self.warnings .. ' ')
    end,
    hl = 'DiagnosticWarn',
  },
  {
    provider = function(self)
      return self.info > 0 and (self.info_icon .. self.info .. ' ')
    end,
    hl = 'DiagnosticInfo',
  },
  {
    provider = function(self)
      return self.hints > 0 and (self.hint_icon .. self.hints)
    end,
    hl = 'DiagnosticHint',
  },
}
