return {
  setup = function()
    local pick = require('rc.utils').pick

    vim.go.background = pick { 'dark', 'light' }
  end,
}
