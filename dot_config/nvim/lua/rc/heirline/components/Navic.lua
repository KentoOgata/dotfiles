local utils = require 'heirline.utils'

--- Blend two rgb colors using alpha
---@param color1 string  first color
---@param color2 string  second color
---@param alpha number (0, 1) float determining the weighted average
---@return string color hex string of the blended color
local function blend(color1, color2, alpha)
  color1 = type(color1) == 'number' and string.format('#%06x', color1) or color1
  color2 = type(color2) == 'number' and string.format('#%06x', color2) or color2
  local r1, g1, b1 = color1:match '#(%x%x)(%x%x)(%x%x)'
  local r2, g2, b2 = color2:match '#(%x%x)(%x%x)(%x%x)'
  local r = tonumber(r1, 16) * alpha + tonumber(r2, 16) * (1 - alpha)
  local g = tonumber(g1, 16) * alpha + tonumber(g2, 16) * (1 - alpha)
  local b = tonumber(b1, 16) * alpha + tonumber(b2, 16) * (1 - alpha)
  return '#'
    .. string.format('%02x', math.min(255, math.max(r, 0)))
    .. string.format('%02x', math.min(255, math.max(g, 0)))
    .. string.format('%02x', math.min(255, math.max(b, 0)))
end

local function dim(color, n)
  return blend(color, '#000000', n)
end

return {
  condition = function()
    local ok, navic = pcall(require, 'nvim-navic')
    return ok and navic.is_available()
  end,
  static = {
    type_hl = {
      File = dim(utils.get_highlight('Directory').fg, 0.75),
      Module = dim(utils.get_highlight('@include').fg, 0.75),
      Namespace = dim(utils.get_highlight('@namespace').fg, 0.75),
      Package = dim(utils.get_highlight('@include').fg, 0.75),
      Class = dim(utils.get_highlight('@type').fg, 0.75),
      Method = dim(utils.get_highlight('@method').fg, 0.75),
      Property = dim(utils.get_highlight('@property').fg, 0.75),
      Field = dim(utils.get_highlight('@field').fg, 0.75),
      Constructor = dim(utils.get_highlight('@constructor').fg, 0.75),
      Enum = dim(utils.get_highlight('@field').fg, 0.75),
      Interface = dim(utils.get_highlight('@type').fg, 0.75),
      Function = dim(utils.get_highlight('@function').fg, 0.75),
      Variable = dim(utils.get_highlight('@variable').fg, 0.75),
      Constant = dim(utils.get_highlight('@constant').fg, 0.75),
      String = dim(utils.get_highlight('@string').fg, 0.75),
      Number = dim(utils.get_highlight('@number').fg, 0.75),
      Boolean = dim(utils.get_highlight('@boolean').fg, 0.75),
      Array = dim(utils.get_highlight('@field').fg, 0.75),
      Object = dim(utils.get_highlight('@type').fg, 0.75),
      Key = dim(utils.get_highlight('@keyword').fg, 0.75),
      Null = dim(utils.get_highlight('@comment').fg, 0.75),
      EnumMember = dim(utils.get_highlight('@field').fg, 0.75),
      Struct = dim(utils.get_highlight('@type').fg, 0.75),
      Event = dim(utils.get_highlight('@keyword').fg, 0.75),
      Operator = dim(utils.get_highlight('@operator').fg, 0.75),
      TypeParameter = dim(utils.get_highlight('@type').fg, 0.75),
    },
    -- line: 16 bit (65536); col: 10 bit (1024); winnr: 6 bit (64)
    -- local encdec = function(a,b,c) return dec(enc(a,b,c)) end; vim.pretty_print(encdec(2^16 - 1, 2^10 - 1, 2^6 - 1))
    enc = function(line, col, winnr)
      return bit.bor(bit.lshift(line, 16), bit.lshift(col, 6), winnr)
    end,
    dec = function(c)
      local line = bit.rshift(c, 16)
      local col = bit.band(bit.rshift(c, 6), 1023)
      local winnr = bit.band(c, 63)
      return line, col, winnr
    end,
  },
  init = function(self)
    local data = require('nvim-navic').get_data() or {}
    local children = {}
    for i, d in ipairs(data) do
      local pos = self.enc(d.scope.start.line, d.scope.start.character, self.winnr)
      local child = {
        {
          provider = d.icon,
          hl = { fg = self.type_hl[d.type] },
        },
        {
          provider = d.name:gsub('%%', '%%%%'):gsub('%s*->%s*', ''),
          hl = { fg = self.type_hl[d.type] },
          -- hl = self.type_hl[d.type],
          on_click = {
            callback = function(_, minwid)
              local line, col, winnr = self.dec(minwid)
              vim.api.nvim_win_set_cursor(vim.fn.win_getid(winnr), { line, col })
            end,
            minwid = pos,
            name = 'heirline_navic',
          },
        },
      }
      if #data > 1 and i < #data then
        table.insert(child, {
          provider = ' → ',
          hl = { fg = 'bright_fg' },
        })
      end
      table.insert(children, child)
    end
    self[1] = self:new(children, 1)
  end,
  update = 'CursorMoved',
  hl = { fg = 'gray' },
}
