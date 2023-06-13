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
      ident = { enable = true },
      rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
      },
      autotag = {
        enable = true
      }
    })
  end,
}
