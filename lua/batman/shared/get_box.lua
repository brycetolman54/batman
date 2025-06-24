return function(msg)
  -- get the window size
  local cols = vim.api.nvim_win_get_width(0)

  -- get the number of dashes
  local dashes = (cols - string.len(msg) - 6) / 2

  -- make the lines
  local top_line = " +" .. string.rep("-", dashes) .. " " .. msg .. " " .. string.rep("-", dashes) .. "+ "
  local bottom_line = " +" .. string.rep("-", cols - 4) .. "+ "

  return top_line, bottom_line
end
