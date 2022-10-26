require("nikp.set");
vim.api.nvim_set_keymap("n", "<space>", "<Nop>", {noremap = true})
vim.g.mapleader = " "
vim.api.nvim_create_user_command("Fmt", "Neoformat prettier", {nargs = 0})

P = function(v)
  print(vim.inspect(v))
  return v
end
