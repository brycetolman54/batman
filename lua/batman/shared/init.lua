local M = {}

M.read_dirs = require("batman.shared.read_directories")
M.read_repos = require("batman.shared.read_plugins")
M.find_repo = require("batman.shared.find_repository")
M.write = require("batman.shared.write")
M.get_box = require("batman.shared.get_box")

return M
