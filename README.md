# docker-nvim

A Neovim plugin for Docker workflows, tightly integrated with your editor.  
Easily build images, run and stop containers, show logs, and track container status — all from within Neovim.

---

## Features

- Automatically detects your project root (based on `Dockerfile`)  
- Build Docker images with predictable names: `<project_name>_image`  
- Run containers named: `<project_name>_container`  
- Show container logs in a floating terminal  
- Stop running containers  
- Real-time container status shown in your statusline (e.g., with `lualine`)  
- Floating terminal for build logs and interactive shell access  

---

## Requirements

- Neovim 0.8 or newer  
- [plenary.nvim](https://github.com/nvim-lua/plenary.nvim)  
- Docker installed and available in your `$PATH`  

---

## Installation

**With [lazy.nvim](https://github.com/folke/lazy.nvim):**

```lua
{
  "DukicDev/docker-nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
}
```
---

## Suggested Keymaps
```lua
local docker = require("docker_nvim.docker")

vim.keymap.set("n", "<leader>db", function()
  docker.build_image()
end, { desc = "Docker Build" })

vim.keymap.set("n", "<leader>dr", function()
  docker.run()
end, { desc = "Docker Run" })

vim.keymap.set("n", "<leader>ds", function()
  docker.stop()
end, { desc = "Docker Stop" })

vim.keymap.set("n", "<leader>dl", function()
  docker.logs()
end, { desc = "Docker Logs" })
```

---

## Example setup with lualine
```lua
  lualine_c = { 'filename',
    function()
      local project = require("docker_nvim.project")
      local status = require("docker_nvim.status")

      if project.has_dockerfile() then
        return status.is_running() and '🐳 ✅ RUNNING' or '🐳 ❌ Stopped'
      end

      return ""
    end
  },

```

---

## Planned Features

[ ] Custom commands
[ ] Telescope Picker for running containers
[ ] Starting a shell inside a container

---

## License

MIT
