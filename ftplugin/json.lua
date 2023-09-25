require("lspconfig")
vim.cmd(":LspStart jsonls")
local keymaps = require("nikp.keymaps.lsp")
keymaps.on_attach({}, 0)
