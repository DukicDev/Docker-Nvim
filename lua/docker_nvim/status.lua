local M = {}
local project = require("docker_nvim.project")


function M.is_running(name)
  local project_root = project.get_project_root()
  if not project_root then
    print("No Dockerfile found in project root.")
    return
  end

  if not name or name == "" then
    name = vim.fn.fnamemodify(project_root, ":t") .. "_container"
  end

  local handle = io.popen("docker ps --filter \"name=" .. name .. "\" --format \"{{.Names}}\"")
  if not handle then
    return false
  end

  local result = handle:read("*a"):gsub("%s+", "")
  handle:close()


  return result == name
end

return M
