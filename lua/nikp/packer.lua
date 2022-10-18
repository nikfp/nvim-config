-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  -- Theme - managed in plugins/theme.lua
  --   use 'folke/tokyonight.nvim'
  use 'Mofiqul/dracula.nvim'
  use 'xiyaowong/nvim-transparent'
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
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp-signature-help'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/vim-vsnip-integ'
  -- Language service - Plugin manager
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  -- Language service - UI
  use ({
    "glepnir/lspsaga.nvim", 
    branch = "main", 
  })
  use 'lewis6991/gitsigns.nvim'
  -- Language service - Svelte
  use 'windwp/nvim-ts-autotag'
  use 'leafOfTree/vim-svelte-plugin'
  -- Language service - Rust
  use 'simrat39/rust-tools.nvim'
  -- Language service - formatting
  use 'sbdchd/neoformat'
  -- Utilities
  use 'nvim-lualine/lualine.nvim'
  use 'windwp/nvim-autopairs'
  -- Nik makes a plugin
  use '~/Documents/Github/stackmap.nvim/'
end)
