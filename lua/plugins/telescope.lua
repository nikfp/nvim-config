return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "natecraddock/telescope-zf-native.nvim",
  },
  event = "VeryLazy",
  config = function()
    local ts = require("telescope")
    local actions = require("telescope.actions")
    ts.setup({
      defaults = {
        file_ignore_patterns = {
          "node_modules",
          ".git/",
        },
        mappings = {
          i = {
            ["<esc>"] = actions.close,
          }
        }
      },
      extensions = {
        file_browser = {},
      },
    })
    ts.load_extension("zf-native")
  end,
}
