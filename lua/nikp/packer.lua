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
	print("Installing packer.... please close and reopen Neovim")
	vim.cmd([[packadd packer.nvim]])
end

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
	use("shaunsingh/nord.nvim")
	-- use("folke/tokyonight.nvim")
	-- use 'Mofiqul/dracula.nvim'
	-- Enable this if the theme doesn't have a transparent option
	-- use 'xiyaowong/nvim-transparent'
	use("kyazdani42/nvim-web-devicons")
	-- Telescope and Fuzzy finder
	use("nvim-lua/plenary.nvim")
	use("nvim-telescope/telescope.nvim")
	use("natecraddock/telescope-zf-native.nvim")
	use("nvim-telescope/telescope-file-browser.nvim")
	use("ThePrimeagen/harpoon")
	-- Language service - core
	-- use("onsails/lspkind.nvim")
	use("nvim-treesitter/nvim-treesitter")
	use("neovim/nvim-lspconfig")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-nvim-lsp-signature-help")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-nvim-lua")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("saadparwaiz1/cmp_luasnip")
	use({
		"L3MON4D3/LuaSnip",
		after = "nvim-cmp",
	})
	use({ "mfussenegger/nvim-dap" })
	use("rcarriga/nvim-dap-ui")
	use("nvim-telescope/telescope-dap.nvim")
	use("theHamsta/nvim-dap-virtual-text")
	-- Language service - Plugin manager
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")
	use("jay-babu/mason-nvim-dap.nvim")
	use("WhoIsSethDaniel/mason-tool-installer.nvim")
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
	use("jose-elias-alvarez/null-ls.nvim")
	-- utilities
	use("nvim-lualine/lualine.nvim")
	use("windwp/nvim-autopairs")
	use("kylechui/nvim-surround")
	use("terrortylor/nvim-comment")
	use("kdheepak/lazygit.nvim")
	use("folke/which-key.nvim")
	use("folke/neodev.nvim")
	use({
		"utilyre/barbecue.nvim",
		requires = {
			"SmiteshP/nvim-navic",
		},
	})
	-- Make NetRW pretty
	use("prichrd/netrw.nvim")

	-- Add OpeanAI Chat GPT
	use("jackMort/ChatGPT.nvim")
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
