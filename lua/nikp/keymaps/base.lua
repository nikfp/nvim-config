local popup = require("nikp.utils.popup")
local map = require("nikp.keymaps.utils").map
local M = {}
local builtin = require("telescope.builtin")

M.initialize = function()
  local wk = require("which-key")
  local icons = require("nikp.utils.system_icons")
  wk.add({
    { "<space>",   name = "Lua helpers" },
    { "<leader>a", name = "Code Companion",     icon = icons.AI },
    { "<leader>c", name = "Changing things",    icon = icons.Edit },
    { "<leader>d", name = "Diagnostics",        icon = icons.Stethoscope },
    { "<leader>f", name = "Finding things" },
    { "<leader>g", name = "Going places",       icon = icons.Travel },
    { "<leader>h", name = "Spelunk",            icon = icons.Bookmark },
    { "<leader>m", name = "Meta-functions",     icon = icons.Meta },
    { "<leader>q", name = "Quickfix" },
    { "<leader>r", name = "Run things",         icon = icons.Run },
    { "<leader>s", name = "Controls splits",    icon = icons.Split },
    { "<leader>t", name = "Tailwind utilities", icon = icons.Tailwind },
    { "<leader>u", name = "Utilities",          icon = icons.Utilities },
    { "<leader>w", name = "Workspace" },
  })
  wk.setup()

  -- <<< FINDING THINGS >>>

  --shortcuts for Telescope
  map("n", "<leader>ff", function() builtin.find_files({ hidden = true }) end, { desc = "Find files with Telescope" })
  map("n", "<leader>fg", builtin.live_grep, { desc = "Live grep files in starting directory" })
  map("n", "<leader>fb", builtin.buffers, { desc = "Search for active buffers" })
  map("n", "<leader>fh", builtin.help_tags, { desc = "Search for help tags" })
  map("n", "<leader>fd", function()
      builtin.find_files({ find_command = { "find", "-type", "d", "!", "-name", "'node_modules'" } })
    end,
    { desc = "Search for directories" })
  map("n", "<leader>f/", function()
    builtin.current_buffer_fuzzy_find(
      require("telescope.themes").get_dropdown {
        winblend = 0,
        previewer = false
      }
    )
  end, { desc = "Telescope search in current buffer" })

  -- where the heck am I?
  map("n", "<leader>fl", ":lua print(vim.fn.expand('%'))<cr>", { desc = "Print CWD relative to project root" })

  -- <<<Spelunk>>>
  for pos = 0, 9 do
    map("n", "<leader>h" .. pos, function()
      require("spelunk").goto_bookmark_at_index(pos)
    end, { desc = "Move to Spelunk index #" .. pos })
  end

  -- <<< GIT Stuff >>>
  map("n", "<leader>ug", ":LazyGit<cr>", { desc = "Start LazyGit" })

  -- <<< SHOWING THINGS >>>
  vim.keymap.set("n", "<leader>fm", ":Telescope keymaps<cr>", { desc = "Show list of current user keymaps" })
  vim.keymap.set("n", "<leader>ch", function()
    popup.output_command(":!~/.config/bash/cht.sh")
  end, { desc = "Run cht.sh" })

  -- <<< Terminal Management >>>
  map("n", "<leader>utr", "<C-w>v<C-w>l:term<cr>", { desc = "Open terminal in split to right" })
  map("n", "<leader>utl", "<C-w>v<C-w>r:term<cr>", { desc = "Open terminal in split to left" })
  map("t", "<esc>", "<C-\\><C-N>", { desc = "Exit to normal mode in terminal" })

  -- <<< Tailwind Things >>>
  map("n", "<leader>tc", ":TailwindConcealToggle", { desc = "Toggle Tailwind Concealing" })
  map("n", "<leader>ts", ":TailwindSort", { desc = "Sort Tailwind Classes" })

  -- <<< Window / Split Management >>>
  map("n", "<leader>ss", "<C-w>s", { desc = "Split horizontal" })
  map("n", "<leader>sv", "<C-w>v", { desc = "Split Vertical" })
  map("n", "<leader>sh", "<C-w>h", { desc = "Move left by one split" })
  map("n", "<leader>sj", "<C-w>j", { desc = "Move down by one split" })
  map("n", "<leader>sk", "<C-w>k", { desc = "Move up by one split" })
  map("n", "<leader>sl", "<C-w>l", { desc = "Move right by one split" })
  map("n", "<leader>so", "<C-w><C-r>", { desc = "Rotate windows in view" })
  for pos = 1, 9 do
    local lhs = "<leader>s" .. pos
    local rhs = pos .. "<C-W>w"
    map("n", lhs, rhs, { desc = "Move to window " .. pos })
  end
  map("n", "<leader>sru", require("nikp.utils.resize").inc_height, { desc = "Increase window height" })
  map("n", "<leader>srd", require("nikp.utils.resize").dec_height, { desc = "Decrease window height" })
  map("n", "<leader>srw", require("nikp.utils.resize").inc_width, { desc = "Increase window width" })
  map("n", "<leader>srn", require("nikp.utils.resize").dec_width, { desc = "Decrease window width" })
  map("n", "<leader>sc", function()
    vim.cmd("only")
    require("no-neck-pain").disable()
  end, { desc = "Close all but current windows" })
  map("n", "<leader>sz", ":NoNeckPain<cr>", { desc = "Toggle NoNeckPain" })

  -- <<< Quickfix list >>>
  map("n", "<leader>qo", ":copen<cr>", { desc = "Open quickfix list" })
  map("n", "<leader>qc", ":cclose<cr>", { desc = "Close quickfix list" })
  map("n", "<leader>qn", ":cn<cr>", { desc = "Next quickfix item" })
  map("n", "<leader>qp", ":cp<cr>", { desc = "Prev quickfix item" })

  -- <<< QUALITY OF LIFE >>>
  -- Easier reach to beginning and end of lines
  map("n", "H", "^", { desc = "Move to beginning of text on current line" })
  map("n", "L", "g_", { desc = "Move to end of text on current line" })
  map("v", "L", "g_", { desc = "Move to end of text on current line - Visual mode" })
  -- remap escape to a closer key
  map("i", "jj", "<Esc>", { desc = "Remap escape to 'j' key twice for ergonomics - Insert mod" })
  -- Get down key function closer
  map("i", "<C-j>", "<Down>", { desc = "Move down arrow key closer to home row" })
  map("i", "<C-k>", "<Up>", { desc = "Move up arrow key closer to home row" })
  -- move lines up and down
  map("n", "<A-k>", ":m .-2<cr>", { desc = "Move current line up" })           -- up
  map("n", "<A-j>", ":m .+1<cr>", { desc = "Move current line down" })         -- down
  map("n", "<M-k>", ":m .-2<cr>", { desc = "Move current line up" })           -- up
  map("n", "<M-j>", ":m .+1<cr>", { desc = "Move current line down" })         -- down
  map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move selected lines up" })   -- up
  map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "move selected lines down" }) -- down
  map("v", "<M-j>", ":m '>+1<cr>gv=gv", { desc = "Move selected lines up" })   -- up
  map("v", "<M-k>", ":m '<-2<cr>gv=gv", { desc = "move selected lines down" }) -- down
  -- make sure cursor stays centered in screen
  map("n", "J", "mzJ`z", { desc = "Join lines but keep cursor position" })
  map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center cursor" })
  map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center cursor" })
  map("n", "n", "nzzzv", { desc = "Jump to next search position and center cursor" })
  map("n", "N", "Nzzzv", { desc = "Jump to previous search position and center cursor" })
  -- Easy open oil.nvim
  map("n", "<leader>fo", function()
    local oil = require("oil")
    oil.open(oil.get_current_dir())
  end, { desc = "Open Oil file manager in directory of current buffer" })
  -- Make pasting easier - don't yank replaced word to register
  map("n", "<leader>mp", '"_diwp', { desc = "Paste over word and discard deleted word" })
  -- Yank to and Paste from system clipboard
  map("n", "<leader>y", '"+yy', { desc = "Yank to system clipboard" })
  map("v", "<leader>y", '"+yy', { desc = "Yank to system clipboard" })
  map("n", "<leader>p", '"+p', { desc = "Paste from system clipboard" })
  map("v", "<leader>p", '"+p', { desc = "Paste from system clipboard" })
  -- Disable Ex mode
  map("n", "Q", "<nop>", { desc = "Get rid of Ex mode" })
  -- change word under cursor
  map(
    "n",
    "<leader>cw",
    ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
    { desc = "Change all occurences of word under cursor" }
  )
  -- change contents of tag
  map('n', "<leader>mt", "T>ct<", { desc = "Change html tag contents" })
  -- Goto alternate file
  map("n", "<leader>ga", "<c-^>", { desc = "Go to alternate file" })
  -- Smart delete line with null register
  vim.keymap.set("n", "dd", function()
    ---@diagnostic disable-next-line: param-type-mismatch
    if vim.fn.getline(".") == "" then
      return '"_dd'
    end
    return "dd"
  end, { expr = true })

  -- <<<TMUX INTEGRATION >>>
  -- map('n', "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>")
  -- map('n', "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>")
  -- map('n', "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>")
  -- map('n', "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>")
  -- map('n', "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>")

  -- <<< CODEIUM >>>
  map('i', '<M-l>', function() return vim.fn['codeium#Accept']() end,
    { expr = true, silent = true, desc = "Accept Codeium Suggestion" })
  map('i', '<M-j>', function() return vim.fn['codeium#CycleCompletions'](1) end,
    { expr = true, silent = true, desc = "Next Codeium Suggestion" })
  map('i', '<M-k>', function() return vim.fn['codeium#CycleCompletions'](-1) end,
    { expr = true, silent = true, desc = "Previous Codeium Suggestion" })
  map('i', '<M-x>', function() return vim.fn['codeium#Clear']() end,
    { expr = true, silent = true, desc = "Clear Codeium" })
  map("n", "<leader>ucc", function() return vim.fn['codeium#Chat']() end,
    { expr = true, silent = true, desc = "Open Codeium Chat" })

  map("n", "<leader>uct", ":CodeiumToggle<cr>", { desc = "Toggle Codeium" })

  -- <<<CodeCompanion>>>
  map({ "n", "v" }, "<leader>aa", "<cmd>CodeCompanionActions<cr>",
    { noremap = true, silent = true, desc = "CodeCompanion Actions Pallete" })
  map({ "n", "v" }, "<leader>ai", "<cmd>CodeCompanion<cr>",
    { noremap = true, silent = true, desc = "CodeCompanion Inline Assistant" })
  map({ "n", "v" }, "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>",
    { noremap = true, silent = true, desc = "CodeCompanion Chat Window" })
  map("v", "<leader>ap", "<cmd>CodeCompanionChat Add<cr>",
    { noremap = true, silent = true, desc = "Add Vis Selection to Chat Window" })
  -- Expand 'cc' into 'CodeCompanion' in the command line
  vim.cmd([[cab cc CodeCompanion]])

  -- <<< INCLINE >>>
  map("n", "<leader>ui", function()
    require("incline").toggle()
  end, { desc = "Toggle Incline" })
  -- <<< BASE LSP KEYMAPS >>>
  map("n", "<leader>de", vim.diagnostic.open_float, { desc = "Open Diagnostic Float" })
  map("n", "<leader>dp", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic item" })
  map("n", "<leader>dn", vim.diagnostic.goto_next, { desc = "Go to next diagnostic item" })
  map("n", "<leader>dq", vim.diagnostic.setloclist, { desc = "Set location list" })
  -- Stub for run command
  map("n", "<leader>ru", function()
    popup.output_command(":echo 'run command not set up for this file type'")
  end, { desc = "Default run command" })
end
return M
