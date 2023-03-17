local Popup = require("nui.popup")
local event = require("nui.utils.autocmd").event

local M = {}

M.output_command = function(cmd)
	local popup = Popup({
		enter = true,
		focusable = true,
		border = {
			style = "rounded",
		},
		position = "50%",
		size = {
			width = "80%",
			height = "60%",
		},
	})

	-- mount/open the component
	popup:mount()

	-- unmount component when cursor leaves buffer
	popup:on(event.BufLeave, function()
		popup:unmount()
	end)

	vim.api.nvim_buf_set_keymap(popup.bufnr, "n", "<cr>", ":q<cr>", { noremap = true, silent = true })
	vim.api.nvim_buf_set_keymap(popup.bufnr, "n", "q", ":q<cr>", { noremap = true, silent = true })

	local stuff = vim.api.nvim_exec(cmd, true)

	local lines = {}

	for s in stuff:gmatch("([^\n]*)\n?") do
		table.insert(lines, s)
	end
	-- get buffer number
	-- -- set content
	vim.api.nvim_buf_set_lines(popup.bufnr, 0, 1, false, lines)
	-- bind keymap to buffer to close
end

return M
