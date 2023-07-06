return {
  "nvim-treesitter/nvim-treesitter",
  event = "BufAdd",
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
        enable = true
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
  end,
}
