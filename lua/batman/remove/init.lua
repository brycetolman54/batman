return function(plugs, setup, buf, on_done)
  -- set up a bool to track the return
  local posted = false

  -- get the delete command
  local del_cmd = vim.split(require("batman.setup").get().delete, "%s+")

  -- get our functions
  local s = require("batman.shared")
  local rm_repo = require("batman.remove.rm_repository")
  local rm_setup = require("batman.remove.rm_setup")
  local update_init = require("batman.remove.update_init")

  -- pull the values
  local names, _, _ = s.read_repos()
  local dirs = s.read_dirs(plugs)

  -- compare the lists and remove repos if needed
  local co = coroutine.create(function()
    for _, dir in ipairs(dirs) do
      if not s.find_repo(names, dir) then
        local ok, msg = rm_repo(plugs, dir, del_cmd)
        if ok then
          ok, msg = rm_setup(setup, dir, del_cmd)
          if ok then
            -- todo
          else
            s.write(buf, msg)
          end
        else
          s.write(buf, msg)
        end
        posted = true
        coroutine.yield()
      end
    end
  end)

  local function step()
    local ok, res = coroutine.resume(co)
    if ok and coroutine.status(co) ~= "dead" then
      vim.defer_fn(step, 10)
    else
      if on_done then
        on_done(posted)
      end
    end
  end

  step()
end
