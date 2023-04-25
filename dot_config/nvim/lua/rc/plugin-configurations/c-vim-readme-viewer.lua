vim.g['readme_viewer#plugin_manager'] = 'dein.vim'

vim.fn['ddu#custom#patch_global'] {
  kindOptions = {
    readme_viewer = {
      defaultAction = 'open',
    },
  },
}
