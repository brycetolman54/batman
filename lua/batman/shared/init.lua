local M = {}

M.read_dirs = require("batman.shared.read_directories")
M.read_repos = require("batman.shared.read_plugins")
M.read_files = require("batman.shared.read_files")
M.find_repo = require("batman.shared.find_repository")
M.write = require("batman.shared.write")
M.get_box = require("batman.shared.get_box")

local home = vim.fn.expand("~/.config/nvim")
M.plugs = home .. "/pack/plugins/start/"
M.setup = home .. "/lua/setup/"

return M
