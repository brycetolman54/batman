return function()
  -- start some tables
  local names = {}
  local repos = {}
  local setups = {}

  -- read in the plugins
  local ok, plugins = pcall(require, "setup.batman")
  if not ok then
    vim.notify("Error requiring setup.batman: " .. plugins, vim.log.levels.ERROR)
    return names, repos
  end

  -- separate out the names and repos
  for _, plug in ipairs(plugins) do
    table.insert(names, plug["name"])
    table.insert(repos, plug["repo"])
    table.insert(setups, plug["setup"])
  end

  return names, repos, setups
end
