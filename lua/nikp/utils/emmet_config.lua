local M = {}

M.build_config = function()
  local on_attach = require("nikp.keymaps.lsp").on_attach

  local capabilities =
      require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  local config = {
    name = "emmet_ls",
    capabilities = capabilities,
    on_attach = on_attach,
    -- autostart = false,
    cmd = { "emmet-ls", "--stdio" },
    filetypes = {
      "css",
      "eelixir",
      "elixir",
      "eruby",
      "heex",
      "html",
      "htmldjango",
      "javascriptreact",
      "less",
      "pug",
      "sass",
      "scss",
      "svelte",
      "typescriptreact" },
    init_options = {
      userLanguages = {
        elixir = "html-eex",
        eelixir = "html-eex",
        heex = "html-eex",
      }
    }
  }

  return config
end

return M
