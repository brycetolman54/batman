local function read_file(path)
  local f = io.open(path, "r")
  if not f then
    error("Cannot open file")
  end
  local content = f:read("*a")
  f:close()
  return content
end

-- parse the json file
local json = read_file("plug-lock.json")
local repos = vim.fn.json_decode(json)

-- get the path for the plugins
local config_dir = os.getenv("HOME") .. "/.config/nvim/pack/plugins/start"
os.execute("mkdir -p " .. config_dir)

-- clone each repo if not already present
for _, repo in ipairs(repos) do
  local name, path = repo[1], repo[2]
  local target_path = config_dir .. "/" .. name
  local check = io.open(target_path, "r")
  if check then
    io.write("\27[32mSkipping (exists): \27[0m", name, "\n")
    check:close()
  else
    local cmd = string.format("git clone https://github.com%s %s", path, target_path)
    io.write("\27[34mCloning: \27[0m", path, "\n")
    os.execute(cmd)
  end
end

-- change the bool in my init file
local init_path = os.getenv("HOME") .. "/.config/nvim/init.lua"
local lines = {}

for line in io.lines(init_path) do
  table.insert(lines, line)
end

lines[1] = "plugs = true"

local f = io.open(init_path, "w")
for _, line in ipairs(lines) do
  f:write(line .. "\n")
end
f:close()

-- run with 'nvim --headless -c "luafile add-plugs.lua" -c "qa"'
