return function(plugs, dir, del_cmd)
  -- try removing the repo
  table.insert(del_cmd, plugs .. dir)
  vim.fn.system(del_cmd)

  -- check if it works
  if vim.v.shell_error ~= 0 then
    return false, "\u{274c} Failed to remove the " .. name .. " repository"
  end

  return true, ""
end
