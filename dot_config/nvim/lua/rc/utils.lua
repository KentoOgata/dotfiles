return {
  pick = function(list)
    math.randomseed(os.time())
    return list[math.random(#list)]
  end,
  nilOrEmpty = function(string)
    return string == nil or string == ''
  end,
  iif = function(condition, ifTrue, ifFalse)
    if condition then
      return ifTrue
    else
      return ifFalse
    end
  end,
}
