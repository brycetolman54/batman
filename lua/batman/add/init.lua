return function(plugs, setup, buf, on_done)
  -- set up a bool to track the return
  local posted = false

  -- set up a table to hold the requires
  local pending = {}

  -- get our functions
  local s = require("batman.shared")
  local add_repo = require("batman.add.add_repository")
  local add_setup = require("batman.add.add_setup")

  -- pull the values
  local names, repos, setups = s.read_repos()
  local dirs = s.read_dirs(plugs)
  local top_line, bottom_line = s.get_box("Load")

  -- compare the lists and add repos if needed
  local co = coroutine.create(function()
    for i, name in ipairs(names) do
      if not s.find_repo(dirs, name) then
        local ok_1, msg_1 = add_repo(plugs, setup, repos[i], name)
        if ok_1 then
          local ok_2, msg_2 = add_setup(setup, name, setups[i])
          if ok_2 then
            s.write(buf, { "\u{2705} " .. name .. " added successfully" }, true)
            if msg_2 ~= "" then
              s.write(buf, { msg_2 }, true)
            end
            if setups[i] then
              table.insert(pending, name)
            end
          else
            s.write(buf, { msg_2 }, true)
          end
        else
          s.write(buf, { msg_1 }, true)
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
      for _, name in ipairs(pending) do
        vim.cmd("packadd " .. name)
        vim.schedule(function()
          require("setup." .. name)
        end)
      end
    end
  end

  s.write(buf, { "", top_line })
  step()
end
