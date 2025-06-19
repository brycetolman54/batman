return function(plugs, setup, repo, name)
  -- try the cloning
  vim.fn.system({ "git", "clone", "https://github.com/" .. repo, plugs .. name })

  -- check if it works
  if vim.v.shell_error ~= 0 then
    return false, "❌ Failed to clone the " .. name .. " repository"
  end

  return true, ""
end
