-- get the shared module
local s = require("batman.shared")

-- get the dirs and names
local files = s.read_files(s.setup)
local names, _, _ = s.read_repos()

-- require the right plugins
for _, name in ipairs(names) do
  if s.find_repo(files, name .. ".lua") then
    require("setup." .. name)
  end
end
