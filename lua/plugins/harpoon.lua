return {
  "ThePrimeagen/harpoon",
  lazy = false,
  priority = 52,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("harpoon").setup({
      menu = {
        width = 80,
      },
    })
  end,
}
