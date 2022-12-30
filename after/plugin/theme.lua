vim.g.tokyonight_transparent_sidebar = true
vim.g.tokyonight_transparent = true
vim.opt.background = "dark"

local theme = "tokyonight"
-- Use to set up tokyonight
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

vim.api.nvim_set_hl(0, "TelescopeNormal", { fg = "#c0caf5" })
require("notifier").setup()

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
