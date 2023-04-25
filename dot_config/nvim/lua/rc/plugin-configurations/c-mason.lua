-- ~/.cache/nvim/ が存在しないとエラーになる
local cache_dir = vim.fn.stdpath 'cache'
if not vim.bool_fn.isdirectory(cache_dir) then
  os.execute(('mkdir %s'):format(cache_dir))
end
require('mason').setup()
