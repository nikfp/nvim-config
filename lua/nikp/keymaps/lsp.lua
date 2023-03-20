local map = require("nikp.keymaps.utils").map
local dap = require("dap")
local dapui = require("dapui")
-- local telescope = require("telescope.builtin")

local M = {}
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
M.on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions

	-- Auto save in LSP buffers
	vim.api.nvim_create_autocmd("InsertLeave", {
		command = "w",
		buffer = bufnr,
	})
	vim.api.nvim_create_autocmd("TextChanged", {
		command = "w",
		buffer = bufnr,
	})

	-- LSP Goto'skeylsp
	map(
		"n",
		"<leader>gD",
		vim.lsp.buf.declaration,
		{ buffer = bufnr, desc = "Go to symbol declaration" }
	)
	map(
		"n",
		"<leader>gd",
		vim.lsp.buf.definition,
		{ buffer = bufnr, desc = "Go to symbol definition" }
	)
	map("n", "K", "<cmd>Lspsaga hover_doc<CR>", { desc = "Show symbol information" })
	map(
		"n",
		"<leader>gi",
		vim.lsp.buf.implementation,
		{ buffer = bufnr, desc = "Go to symbol implementation" }
	)
	map("n", "<space>D", vim.lsp.buf.type_definition, { buffer = bufnr })

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
		end)
	end, { buffer = bufnr })

	-- Lsp finder find the symbol definition implement reference
	-- if there is no implement it will hide
	-- when you use action in finder like open vsplit then you can
	-- use <C-t> to jump back
	map("n", "<leader>gh", "<cmd>Lspsaga lsp_finder<CR>", { desc = "Open LSP symbol help information" })

	-- View references through telescope search
	map(
		"n",
		"<leader>gr",
		":Telescope lsp_references",
		{ buffer = bufnr, desc = "Open LSP references in Telescope" }
	)
	-- Signature help
	map("n", "<C-k>", vim.lsp.buf.signature_help, { buffer = bufnr })

	-- Worspace activities
	map("n", "<space>wa", vim.lsp.buf.add_workspace_folder, { buffer = bufnr })
	map("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, { buffer = bufnr })
	map("n", "<space>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, { buffer = bufnr })

	-- Access available code actions
	map({ "n", "v" }, "<leader>fa", "<cmd>Lspsaga code_action<CR>", { desc = "Execute code actions "})

	-- Trigger default formatter
	map("n", "<leader>fmt", function()
		vim.lsp.buf.format({ async = true })
	end, { buffer = bufnr, desc = "Format buffer with default formatter" })

	-- Activate LSP Rename
	map("n", "<leader>cr", "<cmd>Lspsaga rename<CR>", { desc = "Rename current symbol" })

	-- DEBUG ADAPTER ITEMS
	map("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
	map("n", "<leader>dc", dap.continue, { desc = "DAP continue" })
	map("n", "<leader>do", dap.step_over, { desc = "DAP Step over" })
	map("n", "<leader>di", dap.step_into, { desc = "DAP step into" })
	map("n", "<leader>du", dapui.toggle, { desc = "DAP UI toggle" })
	map("n", "<leader>dt", ":DapStepOut<cr>", { desc = "DAP step out" })
	map("n", "<leader>ds", ":DapTerminate<cr>", { desc = "Terminate debugging session" })
end

return M
