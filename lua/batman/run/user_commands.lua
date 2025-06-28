-- grab the shared things
local s = require("batman.shared")

-- bring in the actions to use
local add = require("batman.add")
local update = require("batman.update")
local remove = require("batman.remove")

-- get the buffer functions
local buff = require("batman.run.buffer")

vim.api.nvim_create_user_command("BatLoad", function()
  local buf = buff.openBuf()
  vim.schedule(function()
    add(s.plugs, s.setup, buf, function(posted)
      if posted then
        buff.finishBuf(buf)
      else
        vim.cmd("tabclose")
      end
      print("BatLoad Finished!")
    end)
  end)
end, {})
vim.api.nvim_create_user_command("BatKill", function()
  local buf = buff.openBuf()
  vim.schedule(function()
    remove(s.plugs, s.setup, buf, function(posted)
      if posted then
        buff.finishBuf(buf)
      else
        vim.cmd("tabclose")
      end
      print("BatKill Finished!")
    end)
  end)
end, {})
vim.api.nvim_create_user_command("BatFull", function()
  local buf = buff.openBuf()
  vim.schedule(function()
    add(plugs, setup, buf, function(posted_add)
      remove(plugs, setup, buf, function(posted_remove)
        if posted_add or posted_remove then
          buff.finishBuf(buf)
        else
          vim.cmd("tabclose")
        end
        print("BatFull Finished!")
      end)
    end)
  end)
end, {})
