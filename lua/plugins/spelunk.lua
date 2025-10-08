return
{
	'EvWilson/spelunk.nvim',
	dependencies = {
		'nvim-lua/plenary.nvim',         -- For window drawing utilities
		'nvim-telescope/telescope.nvim', -- Optional: for fuzzy search capabilities
		'nvim-treesitter/nvim-treesitter', -- Optional: for showing grammar context
	},
	event = 'UIEnter',
	config = function()
		require('spelunk').setup({
			enable_persist = true,
			base_mappings = {
				toggle = '<leader>ht',
				add = '<leader>ha',
				next_bookmark = '<leader>hn',
				prev_bookmark = '<leader>hp',
				search_bookmarks = '<leader>hf'
			},
			window_mappings = {
				bookmark_up = {
					'<A-k>',
					'<M-k>',
				},
				bookmark_down = {
					'<A-j>',
					'<M-j>',
				},
				delete_stack = 'dd',
				close = { '<Esc>', 'q' }
			}
		})
	end
}
