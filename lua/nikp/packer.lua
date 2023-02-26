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

	-- Telescope, navigation, and Fuzzy finder
	use("nvim-lua/plenary.nvim")
	use("nvim-telescope/telescope.nvim")
	use("natecraddock/telescope-zf-native.nvim")
	use("ThePrimeagen/harpoon")

	-- File Management
	use("nvim-telescope/telescope-file-browser.nvim")
	use("stevearc/oil.nvim")

	-- Language service - core
	-- use("onsails/lspkind.nvim")
	use("nvim-treesitter/nvim-treesitter")
	use("neovim/nvim-lspconfig")
	use("jose-elias-alvarez/null-ls.nvim")

	-- Language service - UI
	use("MunifTanjim/nui.nvim")
	use("vigoux/notifier.nvim")
	use({
		"glepnir/lspsaga.nvim",
		branch = "main",
	})
	-- language service - svelte
	use("windwp/nvim-ts-autotag")
	use("leafoftree/vim-svelte-plugin")

	-- language service - rust
	use("simrat39/rust-tools.nvim")

	-- Completion
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

	-- Debuggers
	use({ "mfussenegger/nvim-dap" })
	use("rcarriga/nvim-dap-ui")
	use("nvim-telescope/telescope-dap.nvim")
	use("theHamsta/nvim-dap-virtual-text")

	-- Mason items
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")
	use("jay-babu/mason-nvim-dap.nvim")
	use("WhoIsSethDaniel/mason-tool-installer.nvim")

	-- Utils - UI
	use("kyazdani42/nvim-web-devicons")
	use("nvim-lualine/lualine.nvim")
	use({
		"utilyre/barbecue.nvim",
		requires = {
			"SmiteshP/nvim-navic",
		},
	})
	use("lukas-reineke/indent-blankline.nvim")

	-- Utils - Editing
	use("windwp/nvim-autopairs")
	use("kylechui/nvim-surround")
	use("terrortylor/nvim-comment")
	use("folke/which-key.nvim")

	-- Utils - Git
	use("kdheepak/lazygit.nvim")
	use("lewis6991/gitsigns.nvim")

	-- Utils - plugin dev
	use("folke/neodev.nvim")
	use("nvim-zh/colorful-winsep.nvim")

	-- Make NetRW pretty
	use("prichrd/netrw.nvim")

	-- Add OpeanAI Chat GPT
	use("jackMort/ChatGPT.nvim")
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
