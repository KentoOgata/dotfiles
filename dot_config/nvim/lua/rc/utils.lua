return {
  pick = function(list)
    math.randomseed(os.time())
    return list[math.random(#list)]
  end,
}
