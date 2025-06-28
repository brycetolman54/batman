local M = {}

local write = require("batman.shared").write

-- set up a function to open a buffer
function M.openBuf()
  vim.cmd("tabnew")
  local buf = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_set_name(buf, "BatMan")
  vim.o.showtabline = 0

  local cols = vim.api.nvim_win_get_width(0)
  local spaces = (cols - 14) / 2
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, {
    string.rep("=", cols),
    string.rep(" ", spaces) .. "BatMan Results" .. string.rep(" ", spaces),
    string.rep("=", cols),
  })
  vim.api.nvim_set_current_buf(buf)
  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].swapfile = false
  vim.bo[buf].buflisted = false

  vim.opt_local.number = false
  vim.opt_local.relativenumber = false
  vim.opt_local.list = false
  vim.opt_local.signcolumn = "no"
  vim.opt_local.foldcolumn = "0"
  vim.opt_local.cursorline = false
  vim.opt_local.wrap = false
  vim.opt_local.scrolloff = 0
  vim.opt_local.sidescrolloff = 0
  vim.opt_local.spell = false

  return buf
end

-- set up a function for finishing the buffer
function M.finishBuf(buf)
  write(buf, { "", "  Press Enter or q to close this window" })

  vim.keymap.set("n", "q", "<cmd>tabclose<cr>", { buffer = buf, noremap = true, silent = true })
  vim.keymap.set("n", "<cr>", "<cmd>tabclose<cr>", { buffer = buf, noremap = true, silent = true })
end

return M
