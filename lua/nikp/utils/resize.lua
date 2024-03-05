local M = {}

M.inc_height = function()
  local height = vim.api.nvim_win_get_height(0)
  vim.api.nvim_win_set_height(0, height + 2)
end

M.dec_height = function()
  local height = vim.api.nvim_win_get_height(0)
  vim.api.nvim_win_set_height(0, height - 2)
end

M.inc_width = function()
  local width =  vim.api.nvim_win_get_width(0)
  vim.api.nvim_win_set_width(0, width + 2)
end

M.dec_width = function()
  local width =  vim.api.nvim_win_get_width(0)
  vim.api.nvim_win_set_width(0, width - 2)
end

return M
