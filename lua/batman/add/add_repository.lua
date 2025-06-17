return function(plugs, setup, repo, name)
  -- try the cloning
  vim.fn.system({ "git", "clone", "https://github.com/" .. repo, plugs .. name })

  -- check if it works
  if vim.v.shell_error ~= 0 then
    return false, "❌ Failed to clone the " .. name .. " repository"
  else
    -- make a new file
    local f = io.open(setup .. name .. ".lua", "w")
    if not f then
      return false, "❌ Failed to create the " .. name .. " setup file"
    end
    f:write('require("' .. name .. '").setup({})\n')
    f:close()
  end

  return true, ""
end
