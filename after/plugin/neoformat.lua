vim.g.neoformat_try_node_exe = 1
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "javascript", "*.svelte", "javascriptreact", "typescript", "typescriptreact", "*.tsx"}, 
  command = "undojoin | Neoformat prettier"
})


