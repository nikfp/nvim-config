require("nikp.packer")
require("nikp.set")
require("mason").setup()

P = function(v)
	print(vim.inspect(v))
	return v
end
