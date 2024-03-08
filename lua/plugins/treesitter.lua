return {
  "nvim-treesitter/nvim-treesitter",
  event = "BufAdd",
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring"
  },
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "bash",
        "css",
        "html",
        "javascript",
        "lua",
        "markdown",
        "markdown_inline",
        "regex",
        "rust",
        "svelte",
        "toml",
        "tsx",
        "typescript",
        "vim",
      },
      auto_install = true,
      sync_install = false,
      ignore_install = {},
      modules = {},
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
      rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
      },
      autotag = {
        enable = true,
        enable_close_on_slash = false
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn", -- set to `false` to disable one of the mappings
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
      },
    })

    require("ts_context_commentstring").setup({})
  end,
}
