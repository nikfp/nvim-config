require("nikp.packer")
require("nikp.utils.set")
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

local wk = require("which-key")

wk.register({
	c = { name = "Changing things" },
	d = { name = "Debugging" },
	f = { name = "Finding things" },
	g = { name = "Going places" },
	h = { name = "Harpoon" },
	r = { name = "Run things" },
	s = { name = "Controls splits" },
	u = { name = "Utilities" },
	w = { name = "Workspace" },
}, { prefix = "<leader>" })

wk.setup()

require("mason-nvim-dap").setup({
	ensure_installed = { "node2" },
})
require("nikp.dap").setup()

require("nikp.setups.utilities")
