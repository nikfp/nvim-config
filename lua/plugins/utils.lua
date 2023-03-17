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
  { "MunifTanjim/nui.nvim", event = "VeryLazy" },
  { "vigoux/notifier.nvim" },
  { "windwp/nvim-ts-autotag", event = "VeryLazy", config = true },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufAdd",
    config = true,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },
  {
    "kylechui/nvim-surround",
    event = "InsertEnter",
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
  { "kdheepak/lazygit.nvim", event = "VeryLazy" },
  {
    "lewis6991/gitsigns.nvim",
    event = "BufAdd",
    config = function()
      require("gitsigns").setup()
    end,
  },
  { "folke/neodev.nvim", event = "Bufadd *.lua" },
  {
    "prichrd/netrw.nvim",
    event = "UIEnter",
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
  {
    "folke/which-key.nvim",
    event = "UIEnter",
    config = function()
      require("nikp.keymaps.base").initialize()
    end,
  },
  {
    "MaximilianLloyd/patternvault.nvim",
    event = "VeryLazy", -- Customize here as wanted
    config = function()
      require("patternvault").setup()
    end,
  },
  {
    "shortcuts/no-neck-pain.nvim",
    event = "UIEnter",
    config = function()
      require("no-neck-pain").setup()
    end
  }
}
