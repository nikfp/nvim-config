local map = require("nikp.keymaps.utils").map
local dap = require("dap")
local dapui = require("dapui")
-- local telescope = require("telescope.builtin")

local M = {}
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
M.on_attach = function(_, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Auto save in LSP buffers
  vim.api.nvim_create_autocmd("InsertLeave", {
    command = "w",
    buffer = bufnr,
    nested = true
  })
  vim.api.nvim_create_autocmd("TextChanged", {
    command = "w",
    buffer = bufnr,
    nested = true
  })

  -- Cancel luasnip snippets when exiting insert mode
  local ls = require("luasnip")

  vim.api.nvim_create_autocmd("InsertLeave", {
    callback = function()
      ls.session.current_nodes[vim.api.nvim_get_current_buf()] = nil
    end,
    buffer = bufnr,
  })

  -- LSP Goto's
  map("n", "<leader>gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "Go to symbol declaration" })
  map("n", "<leader>gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to symbol definition" })
  map("n", "K", "<cmd>Lspsaga hover_doc<CR>", { desc = "Show symbol information" })
  map("n", "<leader>gi", vim.lsp.buf.implementation, { buffer = bufnr, desc = "Go to symbol implementation" })
  map("n", "<space>D", vim.lsp.buf.type_definition, { buffer = bufnr })

  -- Lsp finder find the symbol definition implement reference
  -- if there is no implement it will hide
  -- when you use action in finder like open vsplit then you can
  -- use <C-t> to jump back
  map("n", "<leader>gh", "<cmd>Lspsaga lsp_finder<CR>", { desc = "Open LSP symbol help information" })

  -- View references through telescope search
  map("n", "<leader>gr", ":Telescope lsp_references", { buffer = bufnr, desc = "Open LSP references in Telescope" })

  -- Signature help
  map("n", "<C-k>", vim.lsp.buf.signature_help, { buffer = bufnr })

  -- Workspace activities
  map("n", "<space>wa", vim.lsp.buf.add_workspace_folder, { buffer = bufnr })
  map("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, { buffer = bufnr })
  map("n", "<space>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, { buffer = bufnr })

  -- Access available code actions
  map({ "n", "v" }, "<leader>fa", "<cmd>Lspsaga code_action<CR>", { desc = "Execute code actions " })

  -- Trigger default formatter
  map("n", "<leader>cf", function()
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
