local utils = require 'heirline.utils'

local get_bufs = function()
  return vim.tbl_filter(function(bufnr)
    return vim.api.nvim_get_option_value('buflisted', { buf = bufnr })
  end, vim.api.nvim_list_bufs())
end

local buflist_cache = {}

vim.api.nvim_create_autocmd({ 'BufAdd', 'BufDelete' }, {
  callback = function()
    vim.schedule(function()
      local buffers = get_bufs()
      for i, v in ipairs(buffers) do
        buflist_cache[i] = v
      end
      for i = #buffers + 1, #buflist_cache do
        buflist_cache[i] = nil
      end
    end)
  end,
})

local tablineBufferBlock = require 'rc.heirline.components.TabLineBufferBlock'

return utils.make_buflist(
  tablineBufferBlock,
  { provider = ' ', hl = { fg = 'gray' } },
  { provider = ' ', hl = { fg = 'gray' } },
  function()
    return buflist_cache
  end,
  false
)
