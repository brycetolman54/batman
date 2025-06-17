return function(dirs, name)
  for _, dir in ipairs(dirs) do
    if dir == name then
      return true
    end
  end
  return false
end
