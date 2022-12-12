local popup = require("nikp.popup")
local map = require("nikp.keymaps.utils").map
local M = {}

M.initialize = function()
	-- <<< FINDING THINGS >>>
	--shortcuts for Telescope

	map("n", "<leader>ff", ":Telescope find_files hidden=true<CR>", { desc = "Find files with Telescope" })
	map("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Live grep files in starting directory" })
	map("n", "<leader>fb", ":Telescope buffers<CR>", { desc = "Search for active buffers" })
	map("n", "<leader>fh", ":Telescope help_tags<CR>", { desc = "Search for help tags" })

	-- <<< GIT Stuff >>>
	map("n", "<leader>gg", ":LazyGit<cr>", { desc = "Start LazyGit" })

	-- <<< SHOWING THINGS >>>
	vim.keymap.set("n", "<leader>sm", function()
		popup.output_command(":map")
	end, { desc = "Show list of current user keymaps" })
	vim.keymap.set("n", "<leader>ch", function()
		popup.output_command(":!~/.config/bash/cht.sh")
	end, { desc = "Run cht.sh" })
	-- <<< QUALITY OF LIFE >>>

	-- Easier reach to beginning and end of lines
	map("n", "H", "^", { desc = "Move to beginning of text on current line" })
	map("n", "L", "g_", { desc = "Move to end of text on current line" })
	map("v", "L", "g_", { desc = "Move to end of text on current line - Visual mode" })
	-- remap escape to a closer key
	map("i", "jj", "<Esc>", { desc = "Remap escape to 'j' key twice for ergonomics - Insert mod" })
	-- Get down key function closer
	map("i", "<C-j>", "<Down>", { desc = "Move down arrow key closer to home row" })
	map("i", "<C-K", "<Up>", { desc = "Move up arrow key closer to home row" })
	-- move lines up and down
	map("n", "<A-k>", ":m .-2<cr>", { desc = "Move current line up" }) -- up
	map("v", "<A-k>", ":m .-2<cr>", { desc = "Move current line up" }) -- up
	map("n", "<A-j>", ":m .+1<cr>", { desc = "Move current line down" }) -- down
	map("v", "<A-j>", ":m .+1<cr>", { desc = "move current line down" }) -- down
	-- Save and source current buffer
	map("n", "<leader><leader>x", ":w<cr>:source %<cr>", { desc = "Source current buffer" })
	-- Format with prettier
	map("n", "<leader>fmt", ":Format<cr>", { desc = "Stub for formatting" })
	map("n", "<leader>shaye", ":echo 'shaye is awesome'<cr>", { desc = "Tell the truth" })
	-- <<< BASE LSP KEYMAPS >>>
	map("n", "<space>e", vim.diagnostic.open_float, { silent = true, desc = "Open Diagnostic Float" })
	map("n", "[d", vim.diagnostic.goto_prev, { silent = true, desc = "Go to previous diagnostic item" })
	map("n", "]d", vim.diagnostic.goto_next, { silent = true, desc = "Go to next diagnostic item" })
	map("n", "<space>q", vim.diagnostic.setloclist, { silent = true, desc = "Set location list" })
	map("n", "<leader>ru", function()
		popup.output_command(":echo 'run command not set up for this file type'")
	end, { noremap = true, silent = true, desc = "Default run command" })
end
return M
