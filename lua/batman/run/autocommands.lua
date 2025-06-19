vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "BatMan",
  callback = function()
    vim.o.showtabline = 0
  end,
})
vim.api.nvim_create_autocmd("BufLeave", {
  pattern = "BatMan",
  callback = function()
    vim.o.showtabline = 2
  end,
})
