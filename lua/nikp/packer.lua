local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/packer/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer.... please close and reopen Noevim")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})
return packer.startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")
	-- Theme - managed in plugins/theme.lua
	use("folke/tokyonight.nvim")
	-- use 'Mofiqul/dracula.nvim'
	-- Enable this if the theme doesn't have a transparent option
	-- use 'xiyaowong/nvim-transparent'
	use("kyazdani42/nvim-web-devicons")
	-- Telescope and Fuzzy finder
	use("nvim-lua/plenary.nvim")
	use("nvim-telescope/telescope.nvim")
	use("natecraddock/telescope-zf-native.nvim")
	-- Language service - core
	use("onsails/lspkind.nvim")
	use("nvim-treesitter/nvim-treesitter")
	use("neovim/nvim-lspconfig")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-nvim-lsp-signature-help")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-nvim-lua")
	use("hrsh7th/cmp-path")
	use("saadparwaiz1/cmp_luasnip")
	use({
		"L3MON4D3/LuaSnip",
		after = "nvim-cmp",
	})
	-- use({
	-- 	"mfussenegger/nvim-dap",
	-- 	opt = true,
	-- 	module = { "dap" },
	-- 	requires = {
	-- 		"theHamsta/nvim-dap-virtual-text",
	-- 		"rcarriga/nvim-dap-ui",
	-- 		"nvim-telescope/telescope-dap.nvim",
	-- 		{ "mxsdev/nvim-dap-vscode-js" },
	-- 		{
	-- 			"microsoft/vscode-js-debug"n,
	-- 			opt = true,
	-- 			run = "npm install --legacy-peer-deps && npm run compile",
	-- 		},
	-- 	},
	-- 	config = function()
	-- 		require("nikp.dap.javascript").setup()
	-- 	end,
	-- 	disable = false,
	-- })
	-- Language service - Plugin manager
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")
	-- Language service - UI
	use("MunifTanjim/nui.nvim")
	use("vigoux/notifier.nvim")
	use({
		"glepnir/lspsaga.nvim",
		branch = "main",
	})
	use("lewis6991/gitsigns.nvim")
	-- language service - svelte
	use("windwp/nvim-ts-autotag")
	use("leafoftree/vim-svelte-plugin")
	-- language service - rust
	use("simrat39/rust-tools.nvim")
	-- language service - formatting
	use("sbdchd/neoformat")
	use("ckipp01/stylua-nvim")
	-- utilities
	use("nvim-lualine/lualine.nvim")
	use("windwp/nvim-autopairs")
	use("kylechui/nvim-surround")
	use("terrortylor/nvim-comment")
	use("kdheepak/lazygit.nvim")
	-- Make NetRW pretty
	use("prichrd/netrw.nvim")

	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
