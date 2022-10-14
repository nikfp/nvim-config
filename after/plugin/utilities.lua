-- require('auto-save').setup({
--   trigger_events = {"FocusLost"}
-- })

require('nvim-autopairs').setup()

vim.api.nvim_create_autocmd( "InsertLeave", {
  command = "w"
})

vim.api.nvim_create_autocmd( "TextChanged", {
  pattern = {"*.**"}, 
  command = "w"
})
