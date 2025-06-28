return function(path)
  -- setup return table
  local files = {}

  -- scan the directory for files
  local handle, err = vim.loop.fs_scandir(path)
  if not handle then
    return files
  end

  -- loop to find files
  while true do
    local name, type = vim.loop.fs_scandir_next(handle)
    if not name then
      break
    end
    if type == "file" then
      table.insert(files, name)
    end
  end

  return files
end
