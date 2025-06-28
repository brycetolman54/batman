-- get the shared module
local s = require("batman.shared")

-- get the dirs and names
local files = s.read_files(s.setup)
local dirs = s.read_dirs(s.plugs)

-- require the right plugins
for _, dir in ipairs(dirs) do
  if s.find_repo(files, dir .. ".lua") then
    require("setup." .. dir)
  end
end
