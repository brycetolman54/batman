return function(path)
  -- set up the return table
  local dirs = {}

  -- scan the directory for repos
  local handle, err = vim.loop.fs_scandir(path)
  if not handle then
    return dirs
  end

  -- loop the output to add all repos to the table
  while true do
    local name, type = vim.loop.fs_scandir_next(handle)
    if not name then
      break
    end
    if type == "directory" then
      table.insert(dirs, name)
    end
  end

  return dirs
end
