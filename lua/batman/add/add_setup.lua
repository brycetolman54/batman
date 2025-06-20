return function(setup, name, needed)
  if not needed then
    return true
  end

  -- check to see if the file exists
  local f = io.open(setup .. name .. ".lua", "r")
  if f then
    return true, "    \u{2611} Using existing setup file"
  end

  -- else make the file
  f = io.open(setup .. name .. ".lua", "w")
  if not f then
    return false, "\u{274c} Failed to create the " .. name .. " setup file"
  end
  f:write('require("' .. name .. '").setup({})\n')
  f:close()

  return true, ""
end
