return {
  init = function(self)
    self.mode = vim.fn.mode(1)
  end,
  static = {
    mode_names = {
      n = 'N',
      no = 'N?',
      nov = 'N?',
      noV = 'N?',
      ['no\22'] = 'N?',
      niI = 'Ni',
      niR = 'Nr',
      niV = 'Nv',
      nt = 'Nt',
      v = 'V',
      vs = 'Vs',
      V = 'V_',
      Vs = 'Vs',
      ['\22'] = '^V',
      ['\22s'] = '^V',
      s = 'S',
      S = 'S_',
      ['\19'] = '^S',
      i = 'I',
      ic = 'Ic',
      ix = 'Ix',
      R = 'R',
      Rc = 'Rc',
      Rx = 'Rx',
      Rv = 'Rv',
      Rvc = 'Rv',
      Rvx = 'Rv',
      c = 'C',
      cv = 'Ex',
      r = '...',
      rm = 'M',
      ['r?'] = '?',
      ['!'] = '!',
      t = 'T',
    },
  },
  provider = function(self)
    return '%2(' .. self.mode_names[self.mode] .. '%)'
  end,
  --    
  hl = function(self)
    local color = self:mode_color()
    return { fg = color, bold = true }
  end,
  update = {
    'ModeChanged',
    pattern = '*:*',
    callback = vim.schedule_wrap(function()
      vim.cmd 'redrawstatus'
    end),
  },
}
