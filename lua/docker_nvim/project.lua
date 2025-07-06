local M = {}
local Path = require('plenary.path')

local project_root = nil

local function detect_project_root()
  local cwd = vim.fn.getcwd()
  if Path:new(cwd):joinpath("Dockerfile"):exists() then
    return cwd
  end
  return nil
end

function M.get_project_root()
  if project_root == nil then
    project_root = detect_project_root()
  end
  return project_root
end

function M.has_dockerfile()
  local cwd = vim.fn.getcwd()
  return Path:new(cwd):joinpath('Dockerfile'):exists()
end

return M
