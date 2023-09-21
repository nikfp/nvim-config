vim.g.formatoptions = "jcql"
vim.g.mapleader = " "
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.opt.autoindent = true
vim.opt.backup = false
vim.opt.cindent = true
-- vim.opt.clipboard = "unnamedplus"
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
vim.opt.jumpoptions = "stack"
vim.loader.enable()

-- disable fsync on windows
local system = vim.loop.os_uname().sysname

if system == "Windows_NT" then
  print("Setup detected windows - disabling fsync")
  vim.g.nofsync = true
end

-- Make help open to the right and close with "q"
vim.api.nvim_create_autocmd("BufWinEnter", {
  group = vim.api.nvim_create_augroup("help_window_right", {}),
  pattern = { "*.txt" },
  callback = function(opts)
    if vim.o.filetype == "help" then
      vim.cmd.wincmd("L")
      vim.keymap.set("n", "q", ":bd<cr>", { buffer = opts.buf })
      -- vim.keymap.del("n", "K", { buffer = opts.buf })
    end
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("json_lsp", {}),
  pattern = { "*.json", "*.jsonc" },
  callback = function(opts)
    require("lspconfig")
    vim.cmd(":LspStart jsonls")
    local keymaps = require("nikp.keymaps.lsp")
    keymaps.on_attach({}, opts.buf)
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("bash_lsp", {}),
  pattern = { "*.sh", "*.bash", "*.bashrc" },
  callback = function(opts)
    require("lspconfig")
    vim.cmd(":LspStart bashls")
    local keymaps = require("nikp.keymaps.lsp")
    keymaps.on_attach({}, opts.buf)
  end,
})

vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("term", {}),
  callback = function(opts)
    vim.opt.number = false
    vim.opt.relativenumber = false
    vim.opt.signcolumn = "no"
    vim.keymap.set("n", "q", ":q<cr>", { buffer = opts.buf })
  end,
})
