vim.autocmd.create('User', {
  group = vim.augroup.GetOrAdd 'VimRc',
  once = true,
  pattern = 'DenopsPluginPost:skkeleton',
  callback = function()
    ---@type string
    local skkDataDir
    if vim.bool_fn.has 'win32' then
      skkDataDir = vim.env['APPDATA'] .. '\\skk\\'
    else
      skkDataDir = ('%s/skk/'):format(vim.env['XDG_DATA_HOME'])
    end
    local dictPath = skkDataDir .. 'SKK-JISYO.L'

    if not vim.bool_fn.filereadable(dictPath) then
      local dictUrl = 'https://raw.githubusercontent.com/skk-dev/dict/master/SKK-JISYO.L'
      os.execute('curl -fsSLo ' .. dictPath .. ' --create-dirs ' .. dictUrl)
    end

    vim.fn['skkeleton_azik#setup'] {
      keys = {
        katakana = '[',
      },
    }
    vim.fn['skkeleton#register_keymap']('henkan', 'p', 'purgeCandidate')
    vim.fn['skkeleton#config'] {
      eggLikeNewline = true,
      globalJisyo = dictPath,
      userJisyo = skkDataDir .. 'user-jisyo',
      completionRankFile = skkDataDir .. 'rank.json',
      kanaTable = 'azik',
      immediatelyCancel = false,
      registerConvertResult = true,
    }
  end,
})
