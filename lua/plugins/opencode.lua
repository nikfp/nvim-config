return {
  "nickjvandyke/opencode.nvim",
  version = "*",
  event = "UIEnter",
  config = function()
    vim.g.opencode_opts = {
      ask = {
        snacks = {
          win = {
            relative = "editor",
            width = 80,
            height = 12,
            border = "rounded",
            style = "minimal",
          },
        },
      },
      select = {
        snacks = {
          layout = {
            preset = "vscode",
          },
        },
      },
    }
  end,
}
