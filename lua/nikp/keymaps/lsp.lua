local map = require("nikp.keymaps.utils").map
local dap = require("dap")
local dapui = require'dapui'

local M = {}
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
M.on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	map("n", "gD", vim.lsp.buf.declaration, bufopts)
	map("n", "gd", vim.lsp.buf.definition, bufopts)
	-- map("n", "gd", "<cmd>Lspsaga peek_definition<CR>", { silent = true })
	-- map("n", "K", vim.lsp.buf.hover, bufopts)
	map("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
	map("n", "gi", vim.lsp.buf.implementation, bufopts)
	-- Lsp finder find the symbol definition implement reference
	-- if there is no implement it will hide
	-- when you use action in finder like open vsplit then you can
	-- use <C-t> to jump back
	map("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })
	map("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
	map("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	map("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	map("n", "<space>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	map("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
	-- map('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
	map({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })
	map("n", "gr", vim.lsp.buf.references, bufopts)
	map("n", "<leader>fmt", function()
		vim.lsp.buf.format({ async = true })
	end, bufopts)
	-- map('n', '<leader>rr', vim.lsp.buf.rename, bufopts)
	map("n", "<leader>rr", "<cmd>Lspsaga rename<CR>", { silent = true })
	-- DEBUG ADAPTER ITEMS
	map("n", "<leader>db", dap.toggle_breakpoint, { silent = true })
	map("n", "<leader>dc", dap.continue, { silent = true })
	map("n", "<leader>do", dap.step_over, { silent = true })
	map("n", "<leader>di", dap.step_into, { silent = true })
	map("n", "<leader>db", dap.toggle_breakpoint, { silent = true })
	map("n", "<leader>du", dapui.toggle, { silent = true })
end

return M
