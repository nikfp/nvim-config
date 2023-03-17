vim.g.mapleader = " "
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.opt.autoindent = true
vim.opt.backup = false
vim.opt.cindent = true
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = "menu,noselect"
vim.opt.expandtab = true
vim.opt.guicursor = "n:blinkon500-blinkoff500"
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 2
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 8
vim.opt.softtabstop = 2
vim.opt.swapfile = false
vim.opt.tabstop = 2
vim.opt.timeoutlen = 300
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
-- vim.opt.mouse = 'a'
-- vim.opt.cursorline = true:

-- disable fsync on windows
local system = vim.loop.os_uname().sysname

if system == "Windows_NT" then
  print("Setup detected windows - disabling fsync")
  vim.g.nofsync = true
end

vim.api.nvim_create_autocmd("BufWinEnter", {
    group = vim.api.nvim_create_augroup("help_window_right", {}),
    pattern = { "*.txt" },
    callback = function()
        if vim.o.filetype == 'help' then vim.cmd.wincmd("L") end
    end
})
