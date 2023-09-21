local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  print("Lazy package manager is installing, please wait.....")
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
  print("Finished installing lazy. Please close and reopen Neovim.")
else
  vim.opt.rtp:prepend(lazypath)

  require("nikp.utils.set")
  require("lazy").setup("plugins", {
    change_detection = {
      enabled = false
    }
  })
  require("nikp.utils")
end

local arg = vim.fn.argv()[1]

if arg ~= nil then
  if arg == "." then
    local oil = require("oil")
    oil.open(oil.get_current_dir())
  end
end

-- look at _G.arg and fs_stat
