return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup {
      hijack_cursor = true,
      update_focused_file = {
        enable = true
      },
      hijack_directories = {
        enable = false
      }
    }
  end,
}
