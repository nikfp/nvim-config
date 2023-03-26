local M = {}

M.inc_height = function()
  local height = vim.api.nvim_win_get_height(0)
  vim.api.nvim_win_set_height(0, height + 2)
end

M.dec_height = function()
  local height = vim.api.nvim_win_get_height(0)
  vim.api.nvim_win_set_height(0, height - 2)
end

return M
