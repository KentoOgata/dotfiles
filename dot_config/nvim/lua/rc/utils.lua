return {
  pick = function(list)
    math.randomseed(os.time())
    return math.random(#list)
  end,
}
