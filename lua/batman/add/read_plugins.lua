return function()
  -- start some tables
  local names = {}
  local repos = {}

  -- read in the plugins
  local ok, plugins = pcall(require, "setup.batman")
  if not ok then
    vim.notify("Error requiring setup.batman: " .. plugins, vim.log.levels.ERROR)
    return names, repos
  end

  -- separate out the names and repos
  for _, plug in ipairs(plugins) do
    table.insert(names, plug[1])
    table.insert(repos, plug[2])
  end

  return names, repos
end
