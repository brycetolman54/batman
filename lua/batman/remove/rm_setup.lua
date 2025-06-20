return function(setup, name, del_cmd)
  -- try removing the setup file
  table.insert(del_cmd, setup .. name .. ".lua")
  vim.fn.system(del_cmd)

  -- check if it works
  if vim.v.shell_error ~= 0 then
    return false, "\u{274c} Failed to remove the " .. name .. " setup file"
  end

  return true, ""
end
