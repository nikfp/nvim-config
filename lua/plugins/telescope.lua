return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "natecraddock/telescope-zf-native.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
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
            ["jj"] = actions.close
          }
        }
      },
      extensions = {
        file_browser = {},
      },
    })
    ts.load_extension("zf-native")
    ts.load_extension("file_browser")
  end,
}