require('orgmode').setup_ts_grammar()

require('orgmode').setup {
  mappings = {
    disable_all = true,
  },
}

local function setupCmpSource()
  local ok, cmp = pcall(require, 'cmp')
  if not ok then
    local dein = require 'dein'
    if dein.is_available 'nvim-cmp' then
      dein.source 'nvim-cmp'
    else
      return
    end
    cmp = require 'cmp'
  end

  cmp.setup.filetype('org', {
    sources = {
      { name = 'orgmode' },
      { name = 'buffer' },
    },
  })
end
setupCmpSource()
