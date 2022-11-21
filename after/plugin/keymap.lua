local popup = require'nikp.popup'
function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

-- <<< FINDING THINGS >>>
--shortcuts for Telescope

map("n", "<leader>ff", ":Telescope find_files hidden=true<CR>", {desc = "Find files with Telescope"})
map("n", "<leader>fg", ":Telescope live_grep<CR>", {desc = "Live grep files in starting directory"})
map("n", "<leader>fb", ":Telescope buffers<CR>", {desc = "Search for active buffers"})
map("n", "<leader>fh", ":Telescope help_tags<CR>", {desc = "Search for help tags"})
-- map("n", "<leader>fi", ":Telescope file_browser<CR>", {desc = "Browse for files"})

-- <<< GIT Stuff >>>
map("n", "<leader>gg", ":LazyGit<cr>", {desc = "Start LazyGit"})

-- <<< SHOWING THINGS >>>
vim.keymap.set("n", "<leader>sm", function() 
 popup.output_command(":map")
end, {desc = "Show list of current user keymaps"}
)
-- <<< QUALITY OF LIFE >>>

-- Easier reach to beginning and end of lines
map("n", "H", "^", {desc = "Move to beginning of text on current line"})
map("n", "L", "g_", {desc = "Move to end of text on current line"})
map("v", "L", "g_", {desc = "Move to end of text on current line - Visual mode"})
-- remap escape to a closer key
map("i", "jj", "<Esc>", {desc = "Remap escape to 'j' key twice for ergonomics - Insert mod"})
-- Get down key function closer 
map("i", "<C-j>", "<Down>", {desc = "Remap escape to 'j' key twice for ergonomics - Insert mod"})
map("i", "<C-K", "<Up>", {desc = "Remap escape to 'j' key twice for ergonomics - Insert mod"})
-- move lines up and down
map("n", "<A-k>", ":m .-2<cr>", {desc = "Move current line up"}) -- up
map("v", "<A-k>", ":m .-2<cr>", {desc = "Move current line up"}) -- up
map("n", "<A-j>", ":m .+1<cr>", {desc = "Move current line down"}) -- down
map("v", "<A-j>", ":m .+1<cr>", {desc = "move current line down"}) -- down
-- Save and source current buffer
map("n", "<leader><leader>x", ":w<cr>:source %<cr>", {desc = "Source current buffer"})
-- Format with prettier
map("n", "<leader>fmt", ":echo 'formatting not set up for this file'<cr>", {desc = "Stub for formatting"})
map("n", "<leader>shaye", ":echo 'shaye is awesome'<cr>", {desc = "Tell the truth"})
-- <<< other locations for keymaps >>>
-- Tried to avoid, but sometimes it makes sense in the modules
-- All paths relative to here
--
-- Completion engine at ./completion_engine.lua
--
-- LSP configurations at ./lspconfig.lua
--
-- Snippets controls at ./snippets.vim
