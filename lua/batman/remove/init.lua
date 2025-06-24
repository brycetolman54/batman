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
  local top_line, bottom_line = s.get_box("Remove")

  -- compare the lists and remove repos if needed
  local co = coroutine.create(function()
    for _, dir in ipairs(dirs) do
      if not s.find_repo(names, dir) then
        local ok, msg = rm_repo(plugs, dir, del_cmd)
        if ok then
          ok, msg = rm_setup(setup, dir, del_cmd)
          if ok then
            ok, msg = update_init(setup, dir)
            if ok then
              s.write(buf, { "\u{2705} " .. dir .. " removed successfully" }, true)
            else
              s.write(buf, { msg }, true)
            end
          else
            s.write(buf, { msg }, true)
          end
        else
          s.write(buf, { msg }, true)
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
      s.write(buf, { bottom_line })
      if on_done then
        on_done(posted)
      end
    end
  end

  s.write(buf, { "", top_line })
  step()
end
