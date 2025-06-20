return function(setup, name)
  -- setup the line to add/look for and init file
  local line = 'require("setup.' .. name .. '")'
  local init = setup .. "init.lua"

  -- keep all but the line we want to get rid of
  local file_contents = {}
  for l in io.lines(init) do
    if l ~= line then
      table.insert(file_contents, l)
    end
  end

  -- write to the file
  local f = io.open(init, "w")
  if not f then
    return false, "\u{274c} Failed to update the init.lua file"
  end
  f:write(table.concat(file_contents, "\n") .. "\n")
  f:close()

  return true, ""
end
