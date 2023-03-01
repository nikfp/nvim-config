local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

P = function(v)
	print(vim.inspect(v))
	return v
end

Print = function(item)
	vim.pretty_print(item)
	return item
end

require("lazy").setup("plugins");
require("nikp.core.startup")
