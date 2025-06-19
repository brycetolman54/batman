return function(setup, name, needed)
  if not needed then
    return true
  end

  local f = io.open(setup .. "init.lua", "a")
  if not f then
    return false, "❌ Failed to update the init.lua file"
  end
  f:write('require("setup.' .. name .. '")\n')
  f:close()

  return true, ""
end
