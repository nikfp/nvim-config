local M = {}

local get_cursor_position = function()
  local rowcol = vim.api.nvim_win_get_cursor(0)
  local row = rowcol[1] - 1
  local col = rowcol[2]

  return row, col
end

M.test = function(command)
  local row, _col = get_cursor_position()
  local args = command.arguments[1]

  local cmd = "mix test " .. args.filePath

  -- add the line number if it's for a specific describe/test block
  if args.describe or args.testName then
    cmd = cmd .. ":" .. (row + 1)
  end

  return cmd
end

return M
