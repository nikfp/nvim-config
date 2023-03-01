return {
	{
		"shaunsingh/nord.nvim",
		dependencies = {
			"nvim-lualine/lualine.nvim",
			"kyazdani42/nvim-web-devicons",
		},
		lazy = false,
		priority = 1000,
		config = function()
			local theme = "nord"
			vim.cmd("colorscheme " .. theme)

			-- <<< NORD THEME >>>
			vim.g.nord_borders = true
			vim.g.nord_disable_background = true
			require("nord").set()

			-- <<< Transparent background in Telescope >>>
			vim.api.nvim_set_hl(0, "TelescopeNormal", { fg = "#c0caf5" })

			require("lualine").setup({
				options = {
					theme = theme,
				},
			})
		end,
	},
}
