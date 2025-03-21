local M = {}

local map = function(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

M.map = map

M.setTodo = function()
  -- Get the current line
  local line = vim.api.nvim_get_current_line()

  -- Strip leading whitespace and remove leading '-' if present
  line = line:gsub("^%s+", "")   -- Strip leading whitespace
  line = line:gsub("^-", "")     -- Remove leading '-'

  -- Strip whitespace again
  line = line:gsub("%s+", " ")   -- Replace multiple spaces with one space

  -- Wrap the string in single quotes and escape any existing single quotes
  line = "'Current Active Task: " .. line:gsub("'", "'\\''") .. "'"

  -- Execute a shell command using the modified string
  local command = "one-thing " .. line

  -- Use vim.cmd to execute the command
  vim.cmd("! " .. command)
end

return M
