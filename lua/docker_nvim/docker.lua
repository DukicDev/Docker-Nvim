local M = {}
local terminal = require('docker_nvim.terminal')
local project = require('docker_nvim.project')
local status = require("docker_nvim.status")

local function create_container_name(project_root)
  return vim.fn.fnamemodify(project_root, ":t") .. "_container"
end

local function create_image_name(project_root)
  return vim.fn.fnamemodify(project_root, ":t") .. "_image"
end

function M.build_image(tag)
  local project_root = project.get_project_root()
  if not project_root then
    print("No Dockerfile found in project root")
    return
  end

  if not tag or tag == "" then
    tag = create_image_name(project_root)
  end

  local cmd = "docker build -t " .. tag .. " " .. project_root
  terminal.run_command(cmd)
end

function M.run(tag, rebuild)
  rebuild = rebuild or false
  local project_root = project.get_project_root()
  if not project_root then
    print("No Dockerfile found in project root.")
    return
  end

  if not tag or tag == "" then
    tag = create_image_name(project_root)
  end

  local ports = vim.fn.input("Ports to map? xxxx:xxxx ")
  local cmd = ""
  if rebuild then
    cmd = "docker build -t " .. tag .. " " .. project_root .. " && "
  end
  cmd = cmd .. "docker run --name " ..
      create_container_name(project_root) .. " " .. "-p " .. ports .. ":" .. ports .. " --rm " .. tag
  terminal.run_command(cmd)
end

function M.logs(name)
  local project_root = project.get_project_root()
  if not project_root then
    print("No Dockerfile found in project root.")
    return
  end

  if not name or name == "" then
    name = create_container_name(project_root)
  end

  local cmd = "docker logs -f " .. name
  terminal.run_command(cmd)
end

function M.stop(tag)
  local project_root = project.get_project_root()
  if not project_root then
    print("No Dockerfile found in project root.")
    return
  end

  if not tag or tag == "" then
    tag = vim.fn.fnamemodify(project_root, ":t") .. "_image"
  end

  local cmd = "docker stop " .. create_container_name(project_root)
  terminal.run_command(cmd)
end

function M.shell()
  local project_root = project.get_project_root()
  if not project_root then
    print("No Dockerfile found in project root.")
    return
  end
  local cmd = "docker exec -it " .. create_container_name(project_root) .. " bash"
  terminal.run_command(cmd, true)
end

return M
