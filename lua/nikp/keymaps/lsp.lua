local map = require("nikp.keymaps.utils").map

local M = {}
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
M.on_attach = function(client, bufnr)
  -- Auto save in LSP buffers
  -- vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
  --   desc = "Autosave when lsp is attached for faster UI updates",
  --   group = vim.api.nvim_create_augroup("nikfp-lsp-save", { clear = true }),
  --   command = "w",
  --   buffer = bufnr,
  --   nested = true
  -- })

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
  map("n", "<leader>gh", "<cmd>Lspsaga finder<CR>", { desc = "Open LSP symbol help information" })

  -- View references through telescope search
  map("n", "<leader>gr", ":Telescope lsp_references<cr>", { buffer = bufnr, desc = "Open LSP references in Telescope" })

  -- Signature help
  map("n", "<C-k>", vim.lsp.buf.signature_help, { buffer = bufnr })

  -- Workspace activities
  map("n", "<space>wa", vim.lsp.buf.add_workspace_folder, { buffer = bufnr })
  map("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, { buffer = bufnr })
  map("n", "<space>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, { buffer = bufnr })

  -- Access available code actions
  map({ "n", "v" }, "<leader>fa", ":Lspsaga code_action<CR>", { desc = "Execute code actions " })

  -- Trigger default formatter
  map("n", "<leader>cf", function()
    require("conform").format({
      bufnr = bufnr,
      lsp_fallback = true,
      async = true
    })
  end, { buffer = bufnr, desc = "Format buffer with default formatter" })

  -- Activate LSP Rename
  map("n", "<leader>cr", "<cmd>Lspsaga rename<CR>", { desc = "Rename current symbol" })

  -- Toggle Tailwind LSP
  map("n", "<leader>ut", function()
    local toggler = require('nikp.utils.lsp_toggler')
    local tailwind_id = toggler.get_lsp_num("tailwindcss")
    if (tailwind_id == 0) then
      toggler.start_server("tailwindcss")
    else
      toggler.stop_server(tailwind_id)
    end
  end, { desc = "Toggle Tailwind LSP Active / Inactive" })
end

M.diagnostic_config = {
  virtual_text = {
    prefix = "●",
  },
  signs = true,
  update_in_insert = true,
  underline = true,
  severity_sort = false,
  severity = { min = vim.diagnostic.severity.HINT },
  float = {
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
}

return M
