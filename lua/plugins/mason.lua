return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"jay-babu/mason-nvim-dap.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
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

			require("mason-nvim-dap").setup({
				ensure_installed = { "node2" },
			})

			require("nikp.dap").setup()
		end,
	},
}
