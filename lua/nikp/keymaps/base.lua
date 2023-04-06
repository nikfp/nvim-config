local popup = require("nikp.utils.popup")
local map = require("nikp.keymaps.utils").map
local M = {}

local wk = require("which-key")
wk.register({
  c = { name = "Changing things" },
  d = { name = "Debugging" },
  f = { name = "Finding things" },
  g = { name = "Going places" },
  h = { name = "Harpoon" },
  r = { name = "Run things" },
  s = { name = "Controls splits" },
  u = {
    name = "Utilities",
  },
  w = { name = "Workspace" },
}, { prefix = "<leader>" })

wk.setup()

M.initialize = function()
  -- <<< FINDING THINGS >>>
  --shortcuts for Telescope

  map("n", "<leader>ff", ":Telescope find_files hidden=true<CR>", { desc = "Find files with Telescope" })
  map("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Live grep files in starting directory" })
  map("n", "<leader>fb", ":Telescope buffers<CR>", { desc = "Search for active buffers" })
  map("n", "<leader>fh", ":Telescope help_tags<CR>", { desc = "Search for help tags" })
  map("n", "<leader>ft", ":Telescope file_browser path=%:p:h<CR>", { desc = "Telescope File Browser" })
  -- where the heck am I?
  map("n", "<leader>fl", ":lua print(vim.fn.expand('%'))<cr>", { desc = "Print CWD relative to project root" })
  -- <<<Harpoon>>>
  map("n", "<leader>ht", require("harpoon.ui").toggle_quick_menu, { desc = "Toggle Harpoon Menu" })
  map("n", "<leader>ha", require("harpoon.mark").add_file, { desc = "Add file to harpoon list" })
  for pos = 0, 9 do
    map("n", "<leader>h" .. pos, function()
      require("harpoon.ui").nav_file(pos)
    end, { desc = "Move to harpoon mark #" .. pos })
  end
  -- <<< GIT Stuff >>>
  map("n", "<leader>ug", ":LazyGit<cr>", { desc = "Start LazyGit" })

  -- <<< SHOWING THINGS >>>
  vim.keymap.set("n", "<leader>fm", ":Telescope keymaps<cr>", { desc = "Show list of current user keymaps" })
  vim.keymap.set("n", "<leader>ch", function()
    popup.output_command(":!~/.config/bash/cht.sh")
  end, { desc = "Run cht.sh" })

  -- <<< Window / Split Management >>>
  map("n", "<leader>ss", "<C-w>s", { desc = "Split horizontal" })
  map("n", "<leader>sv", "<C-w>v", { desc = "Split Vertical" })
  map("n", "<leader>sh", "<C-w>h", { desc = "Move left by one split" })
  map("n", "<leader>sj", "<C-w>j", { desc = "Move down by one split" })
  map("n", "<leader>sk", "<C-w>k", { desc = "Move up by one split" })
  map("n", "<leader>sl", "<C-w>l", { desc = "Move right by one split" })
  for pos = 1, 9 do
    local lhs = "<leader>s" .. pos
    local rhs = pos .. "<C-W>w"
    map("n", lhs, rhs, { desc = "Move to window " .. pos })
  end
  map("n", "<leader>sru", require("nikp.utils.resize").inc_height, { desc = "Increase window height" })
  map("n", "<leader>sc", function() 
    vim.cmd("only")
    require("no-neck-pain").disable()
  end, { desc = "Close all but current windows" })
  map("n", "<leader>sz", ":NoNeckPain<cr>", { desc = "Toggle NoNeckPain" })
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
  map("n", "<A-k>", ":m .-2<cr>", { desc = "Move current line up" })          -- up
  map("n", "<A-j>", ":m .+1<cr>", { desc = "Move current line down" })        -- down
  map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move selected lines up" })  -- up
  map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "move selected lines down" }) -- down
  -- make sure cursor stays centered in screen
  map("n", "J", "mzJ`z", { desc = "Join lines but keep cursor position" })
  map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center cursor" })
  map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center cursor" })
  map("n", "n", "nzzzv", { desc = "Jump to next search position and center cursor" })
  map("n", "N", "Nzzzv", { desc = "Jump to previous search position and center cursor" })
  -- Easy open file explorer
  map("n", "<leader>fe", vim.cmd.Ex, { desc = "Easy open file explorer" })
  -- Easy open oil.nvim
  map("n", "<leader>fo", function()
    local oil = require("oil")
    oil.open(oil.get_current_dir())
  end, { desc = "Open Oil file manager in directory of current buffer" })
  -- Make pasting easier
  map("n", "<leader>p", '"_diwhp', { desc = "Paste over word and discard deleted word" })
  -- Disable Ex mode
  map("n", "Q", "<nop>", { desc = "Get rid of Ex mode" })
  -- change word under cursor
  map(
    "n",
    "<leader>w",
    ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
    { desc = "Change all occurences of word undor cursor" }
  )
  -- Goto alternate file
  map("n", "<leader>ga", "<c-^>", { desc = "Go to alternate file" })
  map("n", "<leader>shaye", ":echo 'shaye is awesome'<cr>", { desc = "Tell the truth" })
  -- ChatGPT maps
  map("n", "<leader>uc", ":ChatGPT<cr>", { desc = "Open ChatGPT" })
  -- <<< BASE LSP KEYMAPS >>>
  map("n", "<space>e", vim.diagnostic.open_float, { desc = "Open Diagnostic Float" })
  map("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic item" })
  map("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic item" })
  map("n", "<space>q", vim.diagnostic.setloclist, { desc = "Set location list" })
  -- Stub for run command
  map("n", "<leader>ru", function()
    popup.output_command(":echo 'run command not set up for this file type'")
  end, { desc = "Default run command" })
end

return M
