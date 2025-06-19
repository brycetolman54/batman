local M = {
  opts = {
    start = {
      load = true,
    },
  },
}

function M.set(user_opts)
  M.opts = vim.tbl_deep_extend("force", M.opts, user_opts or {})
end

function M.get()
  return M.opts
end

return M
