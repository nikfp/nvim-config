require("telescope").setup({
	defaults = {
		file_ignore_patterns = {
			"node_modules",
			".git/",
		},
	},
	extensions = {
		file_browser = {
		},
	},
})
require("telescope").load_extension("zf-native")
require("telescope").load_extension("dap")
require("telescope").load_extension("file_browser")
