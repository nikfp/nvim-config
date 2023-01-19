local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.prettierd.with({
			extra_filetypes = { "svelte" },
		}),
		null_ls.builtins.diagnostics.eslint.with({
			extra_filetypes = { "svelte" },
      condition = function(utils)
        local check = utils.root_has_file({'.eslintrc.js', '.eslintrc.cjs', '.eslintrc.yaml', '.eslintrc.yml', '.eslintrc.json'})
        return check
      end
		}),
	},
})
