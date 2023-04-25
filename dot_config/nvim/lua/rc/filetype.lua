---@param bufnr integer
---@param options { [string]: any }
local function setWindowLocalOptionForBuffer(bufnr, options)
  vim.autocmd.create('BufWinEnter', {
    group = vim.augroup.GetOrAdd 'VimRc',
    buffer = bufnr,
    desc = 'バッファーに対してWindow-Localオプションを設定する',
    callback = function()
      local winid = vim.api.nvim_get_current_win()
      if not vim.api.nvim_win_is_valid(winid) then
        return
      end

      local opt_save = {}
      for opt, _ in pairs(options) do
        opt_save[opt] = vim.wo[winid][opt]
      end

      for opt, value in pairs(options) do
        vim.wo[winid][opt] = value
      end

      vim.autocmd.create('BufWinLeave', {
        group = vim.augroup.GetOrAdd 'VimRc',
        buffer = bufnr,
        once = true,
        desc = 'Restore window options',
        callback = function()
          if not vim.api.nvim_win_is_valid(winid) then
            return
          end
          for opt, value in pairs(opt_save) do
            vim.wo[winid][opt] = value
          end
        end,
      })
    end,
  })
end

return {
  setup = function()
    ---@type { [string]: fun(ctx: vim.AutocmdArgs): nil }
    local ftplugins = {
      ['cs'] = function(ctx)
        vim.cmd.compiler 'dotnet'
        setWindowLocalOptionForBuffer(ctx.buf, {
          foldmarker = '#region,#endregion',
          foldmethod = 'marker',
          foldenable = true,
          foldlevel = 0,
        })
      end,
      ['gitcommit'] = function(ctx)
        vim.bo[ctx.buf].spelllang = 'en_us'
        setWindowLocalOptionForBuffer(ctx.buf, {
          spell = true,
        })
      end,
      ['help'] = function(ctx)
        vim.keymap.set('n', 'K', 'K', { buffer = ctx.buf })
      end,
      ['qf'] = function(ctx)
        vim.bo[ctx.buf].buflisted = false
      end,
      ['razor'] = function()
        vim.cmd.compiler 'dotnet'
      end,
      ['vim'] = function(ctx)
        vim.keymap.set('n', 'K', 'K', { buffer = ctx.buf })
        vim.keymap.set('x', '<space>x', ':source<CR>', { buffer = ctx.buf })
        vim.keymap.set('n', '<space>x', '^v$:source<CR>', { buffer = ctx.buf })
      end,
    }

    for ft, callback in pairs(ftplugins) do
      vim.autocmd.create('FileType', {
        group = vim.augroup.GetOrAdd 'VimRc',
        pattern = ft,
        callback = callback,
      })
    end
  end,
}
