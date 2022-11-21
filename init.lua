require("nikp.packer")
require("nikp.set");
vim.api.nvim_set_keymap("n", "<space>", "<Nop>", {noremap = true})
vim.g.mapleader = " "

P = function(v)
  print(vim.inspect(v))
  return v
end

