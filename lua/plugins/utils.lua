return {
  {
    "stevearc/oil.nvim",
    config = function()
      require("oil").setup({
        view_options = {
          show_hidden = true,
        },
        buf_options = {
          buflisted = true,
        },
      })
    end,
  },
  { "MunifTanjim/nui.nvim" },
  { "vigoux/notifier.nvim", lazy = false },
  { "windwp/nvim-ts-autotag", config = true },
  { "mfussenegger/nvim-dap" },
  { "rcarriga/nvim-dap-ui" },
  { "theHamsta/nvim-dap-virtual-text" },
  {
    "utilyre/barbecue.nvim",
    dependencies = {
      "SmiteshP/nvim-navic",
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufAdd",
    config = true,
  },
  {
    "windwp/nvim-autopairs",
    event = "BufAdd",
    config = true,
  },
  {
    "kylechui/nvim-surround",
    event = "BufAdd",
    config = true,
  },
  {
    "terrortylor/nvim-comment",
    event = "BufAdd",
    config = function()
      require("nvim_comment").setup()
    end,
  },
  { "folke/neodev.nvim" },
  { "kdheepak/lazygit.nvim" },
  { "lewis6991/gitsigns.nvim", event = "BufAdd" },
  { "folke/neodev.nvim", event = "Bufadd *.lua" },
  {
    "nvim-zh/colorful-winsep.nvim",
    event = "BufAdd",
    config = true,
  },
  {
    "prichrd/netrw.nvim",
    lazy = false,
    config = function()
      require("netrw").setup({
        icons = {
          symlink = "", -- Symlink icon (directory and file)
          directory = "", -- Directory icon
          file = "", -- File icon
        },
        use_devicons = true,
      })
    end,
  },
  { "folke/which-key.nvim" },
  {
    "MaximilianLloyd/patternvault.nvim",
    event = "VeryLazy", -- Customize here as wanted
    config = function()
      require("patternvault").setup()
    end,
  },
}
