local M = {}
local running = false

function M.set_running(val)
  running = val
end

function M.is_running()
  return running
end

return M
