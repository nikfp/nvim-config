return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "antoinemadec/FixCursorHold.nvim",
      "jfpedroza/neotest-elixir",
      "marilari88/neotest-vitest"
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-elixir"),
          require("neotest-vitest")
        },
        floating = {
          border = "rounded"
        },
        status = {
          enabled = true,
          signs = false,
          virtual_text = true
        }
      })
    end
  },
  {

  }
}
