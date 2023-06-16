return {
  ---Pick a element of list
  ---@generic T
  ---@param list { [number]: T }
  ---@return T
  pick = function(list)
    math.randomseed(os.time())
    return list[math.random(#list)]
  end,
  ---Check string is nil or empty.
  ---@param string any
  ---@return boolean
  nilOrEmpty = function(string)
    return string == nil or string == ''
  end,
}
