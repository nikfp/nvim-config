require("nikp.packer")
require("nikp.set")
require("mason").setup()
require("mason-tool-installer").setup({
	ensure_installed = {
		"bash-language-server",
		"codelldb",
		"css-lsp",
		"cssmodules-language-server",
		"eslint-lsp",
		"gopls",
		"html-lsp",
		"lua-language-server",
    "node-debug2-adapter",
		"prettierd",
		"prisma-language-server",
		"rust-analyzer",
		"stylua",
		"svelte-language-server",
	},
	auto_update = true,
})
require("chatgpt").setup({
	yank_register = "r",
})
require("which-key").setup()
require("mason-nvim-dap").setup({
	ensure_installed = { "node2" },
})
require("nikp.dap").setup()

P = function(v)
	print(vim.inspect(v))
	return v
end

Print = function(item)
	vim.pretty_print(item)
	return item
end
