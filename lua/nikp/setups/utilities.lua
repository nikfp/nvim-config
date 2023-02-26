require("nvim-autopairs").setup()

require("nvim-surround").setup()

require("nvim_comment").setup()

require("indent_blankline").setup()

require("oil").setup({
  view_options = {
    show_hidden = true
  }
})

require("chatgpt").setup({
	yank_register = "r",
})

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

require("mason-nvim-dap").setup({
	ensure_installed = { "node2" },
})

require("nikp.dap").setup()

