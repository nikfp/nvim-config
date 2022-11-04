function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

--shortcuts for Telescope

map("n", "<leader>ff", ":Telescope find_files<CR>")
map("n", "<leader>fg", ":Telescope live_grep<CR>")
map("n", "<leader>fb", ":Telescope buffers<CR>")
map("n", "<leader>fh", ":Telescope help_tags<CR>")
map("n", "<leader>fi", ":Telescope file_browser<CR>")

-- <<< GIT Stuff >>>

map('n', '<leader>gg', ':LazyGit<cr>')
-- <<< QUALITY OF LIFE >>>

-- Easier reach to beginning and end of lines
map("n", "H", "^")
map("n", "L", "g_")
map("v", "L", "g_")
-- remap escape to a closer key
map("i", "jj", "<Esc>")
-- Get down key function closer
map("i", "<C-j>", "<Down>")
map("i", "<C-K", "<Up>")
-- move lines up and down
map('n', '<A-k>', ":m .-2<cr>") -- up
map('v', '<A-k>', ":m .-2<cr>") -- up
map('n', "<A-j>", ":m .+1<cr>") -- down
map('v', "<A-j>", ":m .+1<cr>") -- down
-- Save and source current buffer
map('n', '<leader><leader>x', ":w<cr>:source %<cr>")
-- Format with prettier
map('n', '<leader>fmt', ":Neoformat prettier<cr>")
map('n', '<leader>shaye', ':echo "shaye is awesome"<cr>')
-- Mind.nvim maps
map('n', '<leader>mi', ':MindOpenSmartProject<cr>')
map('n', '<leader>mc', ':MindClose<cr>')
-- <<< rther locations for keymaps >>>
-- Tried to avoid, but sometimes it makes sense in the modules
-- All paths relative to here
--
-- Completion engine at ./completion_engine.lua
--
-- LSP configurations at ./lspconfig.lua
--
-- Snippets controls at ./snippets.vim
