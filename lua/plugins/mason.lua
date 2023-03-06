return {
	{
		"williamboman/mason.nvim",
    event = "UIEnter",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
    config = true
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
    event = "UIEnter",
		config = function()
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

		end,
	},
}
