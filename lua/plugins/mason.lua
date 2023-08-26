return {
  {
    "williamboman/mason.nvim",
    event = "UIEnter",
    dependencies = {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = true
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          "bash-language-server",
          "codelldb",
          "css-lsp",
          "cssmodules-language-server",
          "eslint-lsp",
          "gopls",
          "html-lsp",
          "json-lsp",
          "lua-language-server",
          "prettier",
          "prisma-language-server",
          "rust-analyzer",
          "svelte-language-server",
          "tailwindcss-language-server",
          "typescript-language-server"
        },
        auto_update = true,
      })
    end,
  },
}
