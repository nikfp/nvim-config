return {
	"nvim-treesitter/nvim-treesitter",
	event = "BufAdd",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"vim",
				"lua",
				"rust",
				"toml",
				"typescript",
				"javascript",
				"html",
				"css",
				"regex",
				"bash",
				"markdown",
				"markdown_inline",
			},
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			ident = { enable = true },
			rainbow = {
				enable = true,
				extended_mode = true,
				max_file_lines = nil,
			},
		})
	end,
}
