---@package "$(getcwd())/.env" を読み込んで環境変数を定義する
return {
  setup = function()
    vim.uv.new_thread(function()
      local uv = vim.uv
      local file = uv.fs_open(vim.fs.joinpath(uv.cwd(), '.env'), 'r', 438)
      if file == nil then
        return
      end
      local stats = uv.fs_fstat(file)
      local data = uv.fs_read(file, stats.size, 0)
      uv.fs_close(file)

      for line in data:gmatch '[^\r\n]+' do
        local k, v = line:match '([^=]*)=([^=]*)'
        uv.os_setenv(k, v)
      end
    end)
  end,
}
