return function(plugs, setup, repo, name)
  -- try the cloning
  vim.fn.system({ "git", "clone", "https://github.com/" .. repo, plugs .. name })

  -- check if it works
  if vim.v.shell_error ~= 0 then
    return false, "❌ Failed to clone the " .. name .. " repository"
  else
    -- make a new file in the setup folder
    local f = io.open(setup .. name .. ".lua", "w")
    if not f then
      return false, "❌ Failed to create the " .. name .. " setup file"
    end
    f:write('require("' .. name .. '").setup({})\n')
    f:close()
  end

  -- add to the setup folder's init.lua
  local f = io.open(setup .. "init.lua", "a")
  if not f then
    return false, "❌ Failed to update the init.lua file"
  end
  f:write('require("setup.' .. name .. '")')
  f:close()

  return true, ""
end
