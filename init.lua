require("nikp.core.startup")

P = function(v)
	print(vim.inspect(v))
	return v
end

Print = function(item)
	vim.pretty_print(item)
	return item
end
