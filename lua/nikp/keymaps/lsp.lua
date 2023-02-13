local map = require("nikp.keymaps.utils").map
local dap = require("dap")
local dapui = require("dapui")
local telescope = require("telescope.builtin")

local M = {}
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
M.on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	map(
		"n",
		"<leader>gD",
		vim.lsp.buf.declaration,
		{ noremap = true, silent = true, buffer = bufnr, desc = "Go to symbol declaration" }
	)
	map(
		"n",
		"<leader>gd",
		vim.lsp.buf.definition,
		{ noremap = true, silent = true, buffer = bufnr, desc = "Go to symbol definition" }
	)
	map("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true, desc = "Show symbol information" })
	map(
		"n",
		"<leader>gi",
		vim.lsp.buf.implementation,
		{ noremap = true, silent = true, buffer = bufnr, desc = "Go to symbol implementation" }
	)

	map("n", "gp", function()
		vim.api.nvim_open_win(0, true, {
			relative = "cursor",
			width = math.floor(0.4 * vim.o.columns),
			height = math.floor(0.35 * vim.o.lines),
			col = 0,
			row = 1,
			style = "minimal",
			border = "single",
		})
		vim.lsp.buf.definition()
    vim.wo.relativenumber = true
    local innerbufnr = vim.api.nvim_get_current_win()
    vim.keymap.set("n", "q", function()
        vim.api.nvim_win_close(innerbufnr, true)
        -- vim.keymap.del("n", "q", { buffer = bufnr })
    end)
	end, { buffer = bufnr })
	-- Lsp finder find the symbol definition implement reference
	-- if there is no implement it will hide
	-- when you use action in finder like open vsplit then you can
	-- use <C-t> to jump back
	map("n", "<leader>gh", "<cmd>Lspsaga lsp_finder<CR>", { silent = true, desc = "Open LSP symbol help information" })

	map("n", "<C-k>", vim.lsp.buf.signature_help, { noremap = true, silent = true, buffer = bufnr })
	map("n", "<space>wa", vim.lsp.buf.add_workspace_folder, { noremap = true, silent = true, buffer = bufnr })
	map("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, { noremap = true, silent = true, buffer = bufnr })
	map("n", "<space>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	map("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
	-- map('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
	map({ "n", "v" }, "<leader>fa", "<cmd>Lspsaga code_action<CR>", { silent = true })
	map(
		"n",
		"<leader>gr",
		telescope.lsp_references,
		{ noremap = true, silent = true, buffer = bufnr, desc = "Open LSP references in Telescope" }
	)
	map("n", "<leader>fmt", function()
		vim.lsp.buf.format({ async = true })
	end, { noremap = true, silent = true, buffer = bufnr, desc = "Format buffer with default formatter" })
	-- map('n', '<leader>rr', vim.lsp.buf.rename, bufopts)
	map("n", "<leader>cr", "<cmd>Lspsaga rename<CR>", { silent = true, desc = "Rename current symbol" })
	-- DEBUG ADAPTER ITEMS
	map("n", "<leader>db", dap.toggle_breakpoint, { silent = true, desc = "Toggle Breakpoint" })
	map("n", "<leader>dc", dap.continue, { silent = true, desc = "DAP continue" })
	map("n", "<leader>do", dap.step_over, { silent = true, desc = "DAP Step over" })
	map("n", "<leader>di", dap.step_into, { silent = true, desc = "DAP step into" })
	map("n", "<leader>du", dapui.toggle, { silent = true, desc = "DAP UI toggle" })
	map("n", "<leader>dt", ":DapStepOut<cr>", { silent = true, desc = "DAP step out" })
	map("n", "<leader>ds", ":DapTerminate<cr>", { silent = true, desc = "Terminate debugging session" })
end

return M
