return {
  pick = function(list)
    math.randomseed(os.time())
    return list[math.random(#list)]
  end,
  nilOrEmpty = function(string)
    return string == nil or string == ''
  end,
}
