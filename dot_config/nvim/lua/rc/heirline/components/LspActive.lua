local conditions = require 'heirline.conditions'

return {
  condition = conditions.lsp_attached,
  update = { 'LspAttach', 'LspDetach', 'WinEnter' },
  provider = ' [LSP]',
  -- provider  = function(self)
  --     local names = {}
  --     for i, server in pairs(vim.lsp.buf_get_active_clients({ bufnr = 0 })) do
  --         table.insert(names, server.name)
  --     end
  --     return " [" .. table.concat(names, " ") .. "]"
  -- end,
  hl = { fg = 'green', bold = true },
  on_click = {
    name = 'heirline_LSP',
    callback = function()
      vim.schedule(function()
        vim.cmd 'LspInfo'
      end)
    end,
  },
}
