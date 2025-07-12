local M = {}

local term_buf = nil
local term_win = nil

local state = {
  floating = {
    buf = -1,
    win = -1,
  }
}

function M.open_terminal(set_input_mode)
  if term_win and vim.api.nvim_win_is_valid(term_win) then
    vim.api.nvim_set_current_win(term_win)
    return
  end

  term_buf = vim.api.nvim_create_buf(false, true)
  term_win = vim.api.nvim_open_win(term_buf, true, {
    relative = 'editor',
    width = math.floor(vim.o.columns * 0.8),
    height = math.floor(vim.o.lines * 0.6),
    row = math.floor(vim.o.lines * 0.2),
    col = math.floor(vim.o.columns * 0.1),
    style = 'minimal',
    border = 'single',
  })

  vim.fn.termopen("zsh")
  if set_input_mode then
    vim.cmd("startinsert")
  end
end

function M.run_command(cmd, set_input_mode)
  M.open_terminal(set_input_mode)
  vim.fn.chansend(vim.b.terminal_job_id, cmd .. "\n")
end

return M
