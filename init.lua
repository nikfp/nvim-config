require("nikp.packer")
require("nikp.set")
require("mason").setup()
require("chatgpt").setup({
	yank_register = "r",
})
require("which-key").setup()
require("mason-nvim-dap").setup({
  ensure_installed = { "node2" }
})
require("nikp.dap").setup()

P = function(v)
	print(vim.inspect(v))
	return v
end
