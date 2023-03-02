return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"natecraddock/telescope-zf-native.nvim",
    "nvim-telescope/telescope-dap.nvim",
	"nvim-telescope/telescope-file-browser.nvim"
	},
	config = function()
    local ts = require("telescope")
		ts.setup({
			defaults = {
				file_ignore_patterns = {
					"node_modules",
					".git/",
				},
			},
			extensions = {
				file_browser = {},
			},
		})
		ts.load_extension("zf-native")
		ts.load_extension("dap")
		ts.load_extension("file_browser")
	end,
}
