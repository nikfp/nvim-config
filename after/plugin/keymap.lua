vim.g.mapleader = " "

require'nikp.keymaps.base'.initialize()
-- <<< other locations for keymaps >>>
-- Tried to avoid, but sometimes it makes sense in the modules
-- All paths relative to here
--
-- Completion engine at ./completion_engine.lua
--
-- LSP configurations at ./lspconfig.lua
--
-- Snippets controls at ./snippets.vim
