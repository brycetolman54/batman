return function(msg)
  -- get the window size
  local cols = vim.api.nvim_win_get_width(0)

  -- get the number of dashes
  local dashes_1 = math.ceil((cols - string.len(msg) - 6) / 2)
  local dashes_2 = math.floor((cols - string.len(msg) - 6) / 2)

  -- make the lines
  local top_line = " +" .. string.rep("-", dashes_1) .. " " .. msg .. " " .. string.rep("-", dashes_2) .. "+ "
  local bottom_line = " +" .. string.rep("-", cols - 4) .. "+ "

  return top_line, bottom_line
end
