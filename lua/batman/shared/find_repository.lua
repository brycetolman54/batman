return function(list, item)
  for _, l in ipairs(list) do
    if l == item then
      return true
    end
  end
  return false
end
