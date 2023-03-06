return {
  "mfussenegger/nvim-dap",
  event = "BufAdd",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
    "jay-babu/mason-nvim-dap.nvim",
    "nvim-telescope/telescope-dap.nvim",
  },
  config = function()
    require("mason-nvim-dap").setup({
      ensure_installed = { "node2" },
    })

    require("nikp.dap").setup()
    require("telescope").load_extension("dap")
  end,
}
