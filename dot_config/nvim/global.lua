-- ORIGINAL:
-- https://scrapbox.io/vim-jp/boolean%E3%81%AA%E5%80%A4%E3%82%92%E8%BF%94%E3%81%99vim.fn%E3%81%AEwrapper_function
vim.bool_fn = setmetatable({}, {
  __index = function(_, key)
    return function(...)
      return not vim.fn.empty(vim.fn[key](...))
    end
  end,
})

---@param config { mode: string|table, maps: table, opts: table|nil }
---@diagnostic disable-next-line: duplicate-set-field
function vim.keymap.set_table(config)
  local u = require 'rc.utils'
  for _, map in ipairs(config.maps) do
    local lhs, rhs = map[1], map[2]

    local opts
    if (map[3] ~= nil) and (config.opts ~= nil) then
      opts = vim.tbl_deep_extend('error', config.opts, map[3])
    else
      opts = config.opts or map[3]
    end

    vim.keymap.set(config.mode, lhs, rhs, opts)
  end
end
