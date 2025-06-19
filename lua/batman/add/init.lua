return function(plugs, setup, buf, on_done)
  -- set up a bool to track the return
  local posted = false

  -- get our functions
  local s = require("batman.shared")
  local find_repo = require("batman.add.find_repository")
  local add_repo = require("batman.add.add_repository")
  local add_setup = require("batman.add.add_setup")
  local update_init = require("batman.add.update_init")

  -- pull the values
  local names, repos, setups = s.read_repos()
  local dirs = s.read_dirs(plugs)

  -- compare the lists and add repos if needed
  local co = coroutine.create(function()
    for i, name in ipairs(names) do
      if not find_repo(dirs, name) then
        local ok, msg = add_repo(plugs, setup, repos[i], name)
        if ok then
          ok, msg = add_setup(setup, name, setups[i])
          if ok then
            ok, msg = update_init(setup, name, setup[i])
            if ok then
              vim.bo[buf].modifiable = true
              vim.api.nvim_buf_set_lines(buf, -1, -1, false, { "✅ " .. name .. " added successfully" })
              vim.bo[buf].modifiable = false
            else
              vim.bo[buf].modifiable = true
              vim.api.nvim_buf_set_lines(buf, -1, -1, false, { msg })
              vim.bo[buf].modifiable = false
            end
          else
            vim.bo[buf].modifiable = true
            vim.api.nvim_buf_set_lines(buf, -1, -1, false, { msg })
            vim.bo[buf].modifiable = false
          end
        else
          vim.bo[buf].modifiable = true
          vim.api.nvim_buf_set_lines(buf, -1, -1, false, { msg })
          vim.bo[buf].modifiable = false
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
