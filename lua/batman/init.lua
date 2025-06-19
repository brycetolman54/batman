local M = {}

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

-- set up a function to open a buffer
local function openBuf()
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
    "",
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

  return buf
end

-- set up a function for finishing the buffer
local function finishBuf(buf)
  vim.api.nvim_buf_set_lines(buf, -1, -1, false, { "", "Press Enter or q to close this window" })

  vim.bo[buf].modifiable = false

  vim.keymap.set("n", "q", "<cmd>tabclose<cr>", { buffer = buf, noremap = true, silent = true })
  vim.keymap.set("n", "<cr>", "<cmd>tabclose<cr>", { buffer = buf, noremap = true, silent = true })
end

-- set up the path
local home = vim.fn.expand("~/.config/nvim")
local plugs = home .. "/pack/plugins/start/"
local setup = home .. "/lua/setup/"

-- bring in the actions to use
local add = require("batman.add")
local update = require("batman.update")
local remove = require("batman.remove")

-- set up the user commands
vim.api.nvim_create_user_command("BatLoad", function()
  local buf = openBuf()
  vim.schedule(function()
    add(plugs, setup, buf, function(posted)
      if posted then
        finishBuf(buf)
      else
        vim.cmd("tabclose")
      end
    end)
  end)
end, {})

-- add the rest of the plugins' setups
require("setup")

-- allow for options
function M.setup(opts)
  -- do stuff with options here
end

return M
