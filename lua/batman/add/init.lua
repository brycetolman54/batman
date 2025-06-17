return function(plugs, setup)
  -- set up an initial buffer
  vim.cmd("tabnew")
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_name(buf, "BatLoad")
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "", "BatMan is looking at your plugins" })
  vim.api.nvim_set_current_buf(buf)
  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].swapfile = false

  vim.schedule(function()
    -- get our functions
    local read_plugins = require("batman.add.read_plugins")
    local read_dirs = require("batman.add.read_directories")
    local find_repo = require("batman.add.find_repository")
    local add_repo = require("batman.add.add_repository")

    -- pull the values
    local names, repos = read_plugins()
    local dirs = read_dirs(plugs)

    -- compare the lists and add repos if needed
    local results = {}
    for i, name in ipairs(names) do
      if not find_repo(dirs, name) then
        local ok, msg = add_repo(plugs, setup, repos[i], name)
        if ok then
          table.insert(results, "✅ " .. name .. " added successfully")
          vim.api.nvim_buf_set_lines(buf, 0, -1, false, results)
        else
          table.insert(results, msg)
          vim.api.nvim_buf_set_lines(buf, 0, -1, false, results)
        end
      end
    end

    -- set up the buffer with the results
    if next(results) ~= nil then
      table.insert(results, "")
      table.insert(results, "Press Enter or q to close this window")
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, results)

      vim.bo[buf].modifiable = false

      vim.api.nvim_buf_set_keymap(buf, "n", "q", "<cmd>tabclose<cr>", { noremap = true, silent = true })
      vim.api.nvim_buf_set_keymap(buf, "n", "<cr>", "<cmd>tabclose<cr>", { noremap = true, silent = true })
    else
      vim.cmd("tabclose")
    end
  end)
end
