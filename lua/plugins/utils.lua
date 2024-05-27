return {
  { "tpope/vim-sleuth" },
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
  { "MunifTanjim/nui.nvim",   event = "VeryLazy" },
  { "vigoux/notifier.nvim" },
  { "windwp/nvim-ts-autotag", event = "VeryLazy" },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufAdd",
    config = function()
      require("ibl").setup({
        scope = {
          show_start = false,
          show_end = false
        }
      })
    end,
    main = "ibl"
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
      require("nvim_comment").setup({
        hook = function()
          if vim.api.nvim_buf_get_option(0, "filetype") == "svelte" then
            require("ts_context_commentstring.internal").update_commentstring()
          end
        end
      })
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
    "folke/which-key.nvim",
    event = "UIEnter",
    config = function()
      require("nikp.keymaps.base").initialize()
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
    "aserowy/tmux.nvim",
    config = function()
      local os_tmux = vim.env.TMUX

      if os_tmux == nil then
        vim.notify("Tmux not detected, skipping integration setup", 2)
        return
      else
        vim.notify("Tmux detected, setting up integration", 2)
        require("tmux").setup({
          navigation = {
            enable_default_keybindings = false,
          },
          resize = {
            enable_default_keybindings = false,
          }
        })
      end
    end,
    event = "VeryLazy"
  }
}
