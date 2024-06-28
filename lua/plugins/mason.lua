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
          -- "elixir-ls",
          "emmet-language-server",
          "eslint-lsp",
          "gopls",
          "html-lsp",
          "json-lsp",
          "lua-language-server",
          -- "nextls",
          "prettier",
          "prisma-language-server",
          "rust-analyzer",
          "svelte-language-server",
          {"tailwindcss-language-server", version = "0.0.16"},
          "typescript-language-server"
        },
        auto_update = true,
      })
    end,
  },
}
