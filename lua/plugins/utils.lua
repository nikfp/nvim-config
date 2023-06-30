return {
  {
    "stevearc/oil.nvim",
    lazy = false,
    priority = 51,
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
  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "kyazdani42/nvim-web-devicons",
    },
    event = "VeryLazy",
    config = function()
      require("octo").setup()
    end,
  },
  { "MunifTanjim/nui.nvim",   event = "VeryLazy" },
  { "vigoux/notifier.nvim" },
  { "windwp/nvim-ts-autotag", event = "VeryLazy" },
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
          file = "",    -- File icon
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
    end,
  },
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    config = function()
      require("chatgpt").setup()
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end
  }  
}
