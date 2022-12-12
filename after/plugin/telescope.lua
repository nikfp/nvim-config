require("telescope").setup({
	defaults = {
		file_ignore_patterns = {
			"node_modules",
			".git/",
		},
	},
})
require("telescope").load_extension("zf-native")
