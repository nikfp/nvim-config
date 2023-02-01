local popup = require("nikp.popup")
local status, nvim_lsp = pcall(require, "lspconfig")
local on_attach = require("nikp.keymaps.lsp").on_attach
-- Initialize LSPSaga
require("lspsaga").setup({
	symbol_in_winbar = {
    enable = false,
		--     show_file = true,
		-- folder_level = 4,
		-- respect_root = true,
	},
})

-- Mappings. See `:help vim.diagnostic.*` for documentation on any of the below functions
local keymap = vim.keymap.set

-- Common UI settings related to LSP

-- LSP Diagnostics Options Setup
local sign = function(opts)
	vim.fn.sign_define(opts.name, {
		texthl = opts.name,
		text = opts.text,
		numhl = "",
	})
end

sign({ name = "DiagnosticSignError", text = "" })
sign({ name = "DiagnosticSignWarn", text = "" })
sign({ name = "DiagnosticSignHint", text = "" })
sign({ name = "DiagnosticSignInfo", text = "" })

vim.diagnostic.config({
	virtual_text = false,
	signs = true,
	update_in_insert = true,
	underline = true,
	severity_sort = false,
	float = {
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
})

vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

-- LSP setup per language
--
-- Common flags
local lsp_flags = {
	-- This is the default in Nvim 0.7+
	debounce_text_changes = 50,
}

-- set up completion capabilities using nvim_cmp with LSP source
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true
-- C and Variants
nvim_lsp.clangd.setup({
	capabilities = capabilities,
	lsp_flags = lsp_flags,
})
-- TYPESCRIPT
nvim_lsp.tsserver.setup({
	on_attach = function(client, bufnr)
		on_attach(client, bufnr)
		keymap("n", "<leader>rr", ":lua vim.lsp.buf.rename()<cr>")
	end,
	flags = lsp_flags,
	filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript", "javascriptreact" },
	cmd = { "typescript-language-server", "--stdio" },
	capabilities = capabilities,
})

--SVELTE
require("lspconfig").svelte.setup({
	on_attach = on_attach,
	flags = lsp_flags,
})
vim.g.vim_svelte_plugin_use_typescript = 1

-- RUST
local rt = require("rust-tools")

rt.setup({
	server = {
		capabilities = capabilities,
		on_attach = function(client, bufnr)
			-- add keymaps for the rest of things
			on_attach(client, bufnr)
			-- Hover actions
			keymap("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
			-- Code action groups
			keymap("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
			-- easy run code
			keymap("n", "<leader>ru", function()
				popup.output_command(":!cargo run")
			end)
			-- easy format
			keymap("n", "<leader>fmt", ":!cargo fmt<cr><cr><cr>:echo 'Running rust formatter'<cr>")
			-- add semicolon easily
			keymap("n", "<leader>;", "$a;<esc>o")
		end,
	},
	["rust-analyzer"] = {
		checkOnSave = {
			allFeatures = true,
			overrideCommand = {
				"cargo",
				"clippy",
				"--workspace",
				"--message-format=json",
				"--all-targets",
				"--all-features",
			},
		},
	},

	flags = lsp_flags,
})

-- GOLANG
local util = require("lspconfig/util")
require("lspconfig").gopls.setup({
	cmd = { "gopls", "serve" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_dir = util.root_pattern("go.work", "go.mod", ".git"),
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		on_attach(client, bufnr)
		keymap("n", "<leader>ru", function()
			popup.output_command(":!go run .")
		end)
	end,
})

-- LUA
-- local stylua = require("stylua-nvim")
require("lspconfig").sumneko_lua.setup({
	cmd = { "/home/nikp/lua/bin/lua-language-server" },
	commands = {
		Format = {
			function()
				vim.lsp.buf.format()
			end,
		},
	},
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
			telemetry = {
				enable = false,
			},
		},
	},
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		on_attach(client, bufnr)

		keymap("n", "<leader>rr", vim.lsp.buf.rename, { noremap = true, buffer = bufnr })

		-- keymap("n", "<leader>fmt", stylua.format_file, { noremap = true, silent = true, buffer = bufnr })
	end,
})

-- print(require("lspconfig").util.available_servers())
nvim_lsp.cssls.setup({
	capabilities = capabilities,
})
nvim_lsp.cssmodules_ls.setup({})

nvim_lsp.prismals.setup({
	on_attach = on_attach,
})
--Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force to select one from the menu
-- shortness: avoid showing extra messages when using completion
-- updatetime: set updatetime for CursorHold
vim.opt.completeopt = { "menu", "menuone", "noselect", "noinsert" }
vim.opt.shortmess = vim.opt.shortmess + { c = true }
vim.api.nvim_set_option("updatetime", 300)

-- Fixed column for diagnostics to appear
-- Show autodiagnostic popup on cursor hover_range
-- Goto previous / next diagnostic warning / error
-- Show inlay_hints more frequently
vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

-- vim.diagnostic.config({
--   virtual_text = {
--     prefix = '●'
--   },
--   update_in_insert = true,
--   float = {
--     source = "always", -- Or "if_many"
--   },
-- })
