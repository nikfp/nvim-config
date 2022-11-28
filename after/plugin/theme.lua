vim.g.tokyonight_transparent_sidebar = true
vim.g.tokyonight_transparent = true
vim.opt.background = "dark"

local theme = "tokyonight"
require(theme).setup({
	transparent = true,
	terminal_colors = true,
})
vim.cmd("colorscheme " .. theme)

-- local dracula = require("dracula")
-- dracula.setup({
--   colors = {
--     purple = "#663ba1",
--     comment = "#f0920e",
--     pink = "#f01707",
--     selection = "#75623b"
--   }
-- })

require("notifier").setup()
-- require'noice'.setup({
--   redirect = {
--     filter = { cmdline = true },
--     view = "cmdline_output"
--   }
-- })

require("lualine").setup({
	options = {
		theme = theme,
	},
})
-- require("transparent").setup({
--   enable = true,  -- boolean: enable transparent
--   extra_groups = {  -- table/string: additional groups that should be cleared
--     -- In particular, when you set it to 'all', that means all available groups
--
--     -- example of akinsho/nvim-bufferline.lua
--     "BufferLineTabClose",
--     "BufferlineBufferSelected",
--     "BufferLineFill",
--     "BufferLineBackground",
--     "BufferLineSeparator",
--     "BufferLineIndicatorSelected",
--   },
--   exclude = {},  -- table: groups you don't want to clear
-- })
