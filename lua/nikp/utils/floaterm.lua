local M = {}
-- Create new floating window with terminal running command
M.open_floating_terminal = function(cmd, window_opts)
  local local_window_opts = window_opts or {}

  local buf = vim.api.nvim_create_buf(false, true) -- create scratch buffer
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.4)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local opts = vim.tbl_extend('force', {
    style = "minimal",
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    border = "rounded",
    title_pos = "center"
  }, local_window_opts)

  local win = vim.api.nvim_open_win(buf, true, opts)

  vim.fn.termopen(cmd)

  -- Autocmd to scroll to bottom when buffer content changes
  vim.api.nvim_create_autocmd({ "BufEnter", "TextChanged", "TextChangedI" }, {
    buffer = buf,
    callback = function()
      local last_line = vim.api.nvim_buf_line_count(buf)
      vim.api.nvim_win_set_cursor(win, { last_line, 0 })
    end,
  })
end

return M
