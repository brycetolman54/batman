return function(setup, name, needed)
  if not needed then
    return true
  end

  -- setup the line to add/look for and init file
  local line = 'require("setup.' .. name .. '")'
  local init = setup .. "init.lua"

  -- see if a require line is already in the init file
  for l in io.lines(init) do
    if l == line then
      return true, "  \u{2611}  root init already requires setup file"
    end
  end

  -- add to the file else
  local f = io.open(init, "a")
  if not f then
    return false, "\u{274c} Failed to update the init.lua file"
  end
  f:write(line)
  f:close()

  return true, ""
end
