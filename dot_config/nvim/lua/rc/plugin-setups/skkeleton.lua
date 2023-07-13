vim.api.nvim_create_autocmd('User', {
  group = 'VimRc',
  once = true,
  pattern = 'DenopsPluginPost:skkeleton',
  callback = function()
    vim.keymap.set({ 'i', 'c' }, '<C-j>', '<Plug>(skkeleton-enable)')
    vim.fn['skkeleton_azik#setup'] {
      keys = {
        katakana = '[',
      },
    }
    local skkDataDir = vim.fs.joinpath(vim.env['XDG_DATA_HOME'], 'skk')
    vim.fn['skkeleton#register_keymap']('henkan', 'p', 'purgeCandidate')
    vim.fn['skkeleton#config'] {
      eggLikeNewline = true,
      globalDictionaries = vim.fn['GetDictPath'] { 'L', 'geo', 'jinmei', 'emoji' },
      userJisyo = vim.fs.joinpath(skkDataDir, 'user-jisyo'),
      completionRankFile = vim.fs.joinpath(skkDataDir, 'rank.json'),
      kanaTable = 'azik',
      immediatelyCancel = false,
      registerConvertResult = true,
    }
  end,
})
