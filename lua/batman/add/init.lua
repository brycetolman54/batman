return function(plugs, setup, buf, on_done)
  -- set up a bool to track the return
  local posted = false

  -- get our functions
  local s = require("batman.shared")
  local add_repo = require("batman.add.add_repository")
  local add_setup = require("batman.add.add_setup")
  local update_init = require("batman.add.update_init")

  -- pull the values
  local names, repos, setups = s.read_repos()
  local dirs = s.read_dirs(plugs)

  -- compare the lists and add repos if needed
  local co = coroutine.create(function()
    for i, name in ipairs(names) do
      if not s.find_repo(dirs, name) then
        local ok_1, msg_1 = add_repo(plugs, setup, repos[i], name)
        if ok_1 then
          local ok_2, msg_2 = add_setup(setup, name, setups[i])
          if ok_2 then
            local ok_3, msg_3 = update_init(setup, name, setups[i])
            if ok_3 then
              s.write(buf, { "\u{2705} " .. name .. " added successfully" })
              if msg_2 ~= "" then
                s.write(buf, { msg_2 })
              end
              if msg_3 ~= "" then
                s.write(buf, { msg_3 })
              end
            else
              s.write(buf, { msg_3 })
            end
          else
            s.write(buf, { msg_2 })
          end
        else
          s.write(buf, { msg_1 })
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
