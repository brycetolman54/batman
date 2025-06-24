return function(buf, msg, boxed)
  -- default arg
  boxed = boxed or false

  -- set up a table for the lines
  local lines = {}

  -- get num of cols in window
  local cols = vim.api.nvim_win_get_width(0)

  -- set up the box if needed
  for _, line in ipairs(msg) do
    if boxed then
      local spaces = cols - 6 - string.len(line)
      table.insert(lines, " | " .. line .. string.rep(" ", spaces + 1) .. " | ")
    else
      table.insert(lines, line)
    end
  end

  -- set the lines
  vim.bo[buf].modifiable = true
  vim.api.nvim_buf_set_lines(buf, -1, -1, false, lines)
  vim.bo[buf].modifiable = false
end
