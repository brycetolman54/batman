local M = {}

-- set up the code to run BatMan functions
require("batman.run")

-- add the rest of the plugins' setups
require("batman.setup.require")

-- allow for options
local config = require("batman.setup.opts")
function M.setup(opts)
  config.set(opts)

  if config.get().start.load then
    vim.schedule(function()
      vim.cmd("BatLoad")
    end)
  end
end

return M
