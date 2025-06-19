return function(setup, name, needed)
  if not needed then
    return true
  end

  local f = io.open(setup .. name .. ".lua", "w")
  if not f then
    return false, "❌ Failed to create the " .. name .. " setup file"
  end
  f:write('require("' .. name .. '").setup({})\n')
  f:close()

  return true, ""
end
