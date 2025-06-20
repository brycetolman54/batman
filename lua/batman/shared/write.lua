return function(buf, msg)
  vim.bo[buf].modifiable = true
  vim.api.nvim_buf_set_lines(buf, -1, -1, false, msg)
  vim.bo[buf].modifiable = false
end
