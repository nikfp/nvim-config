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
  local cli_term = "one-thing"
  local cli_test_command = ":! " .. cli_term .. " --version"
  local cli_test = vim.api.nvim_exec2(cli_test_command, { output = true })


  if string.find(cli_test.output, "command not found") then
    print("CLI command: '" .. cli_term .. "' not found, unable to complete action")
  else
    -- Get the current line
    local line = vim.api.nvim_get_current_line()

    -- Strip leading whitespace and remove leading '-' if present
    line = line:gsub("^%s+", "") -- Strip leading whitespace
    line = line:gsub("^-", "")   -- Remove leading '-'

    -- Strip whitespace again
    line = line:gsub("%s+", " ") -- Replace multiple spaces with one space

    -- Wrap the string in single quotes and escape any existing single quotes
    line = "'" .. line:gsub("'", "'\\''") .. "'"

    -- Execute a shell command using the modified string
    local command = cli_term .. " " .. line

    -- Use vim.cmd to execute the command
    vim.cmd("! " .. command)
  end
end

return M
