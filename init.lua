require("nikp.packer")
require("nikp.set")
require("mason").setup()
require("chatgpt").setup({
	default_register = "r",
})

P = function(v)
	print(vim.inspect(v))
	return v
end
