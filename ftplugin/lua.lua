vim.keymap.set("n", "<leader><space>x", "<cmd>source %<CR", { desc = "Execute the current file", buffer = 0 })
vim.keymap.set("n", "<leader>x", ":.lua<CR>", { desc = "Execute the current line", buffer = 0 })
vim.keymap.set("v", "<leader>x", ":lua<CR>", { desc = "Execute selected lines", buffer = 0 })
