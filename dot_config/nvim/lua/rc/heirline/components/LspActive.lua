local conditions = require 'heirline.conditions'

return {
  condition = conditions.lsp_attached,
  update = { 'LspAttach', 'LspDetach', 'WinEnter' },
  provider = function(_)
    local server_names = {}
    for _, server in pairs(vim.lsp.get_active_clients { bufnr = 0 }) do
      if server.name == 'null-ls' then
        -- null-lsの場合は実際に使っているソースを羅列して表示する
        local null_ls_sources = {}
        for _, source in ipairs(require('null-ls.sources').get_available(vim.o.filetype)) do
          table.insert(null_ls_sources, source.name)
        end
        table.insert(server_names, 'null-ls(' .. table.concat(null_ls_sources, ',') .. ')')
      else
        -- null-ls以外の場合はサーバー名をそのまま表示する
        table.insert(server_names, server.name)
      end
    end
    -- ' [lua_ls null-ls(stylua)]'
    return ' [' .. table.concat(server_names, ' ') .. ']'
  end,
  hl = { fg = 'green', bold = true },
}
