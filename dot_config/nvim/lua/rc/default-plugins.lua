local plugins = {
  disableable = {
    gzip = 'loaded_gzip',
    matchit = 'loaded_matchit',
    matchparen = 'loaded_matchparen',
    netrw = 'loaded_netrwPlugin',
    rplugin = 'loaded_remote_plugins',
    shada = 'loaded_shada_plugin',
    spellfile = 'loaded_spellfile_plugin',
    tar = 'loaded_tarPlugin',
    tohtml = 'loaded_2html_plugin',
    tutor = 'loaded_tutor_mode_plugin',
    zip = 'loaded_zipPlugin',
    --editorconfig = 'editorconfig_enable',
    man = 'loaded_man',
  },
}

return setmetatable(plugins, {
  __index = {
    use = function(use)
      use = use or {}

      for _, plugin_loaded in pairs(plugins.disableable) do
        vim.g[plugin_loaded] = true
      end

      for _, plugin in ipairs(use) do
        vim.api.nvim_del_var(plugins.disableable[plugin])
      end
    end,
  },
})
