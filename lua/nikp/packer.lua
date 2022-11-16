
-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  -- Theme - managed in plugins/theme.lua
  use 'folke/tokyonight.nvim'
  -- use 'Mofiqul/dracula.nvim'
  -- Enable this if the theme doesn't have a transparent option
  -- use 'xiyaowong/nvim-transparent'
  use 'kyazdani42/nvim-web-devicons'
  -- Telescope and Fuzzy finder
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'natecraddock/telescope-zf-native.nvim'
  -- Language service - core
  use 'onsails/lspkind.nvim'
  use 'nvim-treesitter/nvim-treesitter'
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-nvim-lsp-signature-help'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/vim-vsnip-integ'
  use 'jose-elias-alvarez/null-ls.nvim'
  -- Language service - Plugin manager
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  -- Language service - UI
  -- use 'MunifTanjim/nui.nvim'
  use({
    "folke/noice.nvim",
    config = function()
      require("noice").setup()
    end,
    requires = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "muniftanjim/nui.nvim",
      -- optional:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   if not available, we use `mini` as the fallback
      -- "rcarriga/nvim-notify",
      }
  })
  use ({
    "glepnir/lspsaga.nvim",
    branch = "main",
  })
  use 'lewis6991/gitsigns.nvim'
  -- language service - svelte
  use 'windwp/nvim-ts-autotag'
  use 'leafoftree/vim-svelte-plugin'
  -- language service - rust
  use 'simrat39/rust-tools.nvim'
  -- language service - formatting
  use 'sbdchd/neoformat'
  -- utilities
  use 'nvim-lualine/lualine.nvim'
  use 'windwp/nvim-autopairs'
  use 'kylechui/nvim-surround'
  use 'terrortylor/nvim-comment'
  use 'kdheepak/lazygit.nvim'
end)
