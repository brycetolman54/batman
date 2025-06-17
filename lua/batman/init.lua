local M = {}

-- set up the path
local home = vim.fn.expand("~/.config/nvim")
local plugs = home .. "/pack/plugins/start/"
local setup = home .. "/lua/setup/"

-- bring in the actions to use
local add = require("batman.add")
local update = require("batman.update")
local remove = require("batman.remove")

vim.api.nvim_create_user_command("BatLoad", function()
  add(plugs, setup)
end, {})

-- add the rest of the plugins' setups
require("setup")

return M
