return {
  'sudo-tee/opencode.nvim',
  dependencies = {
    -- Optional: choose a picker you already use, or keep vim.ui.select.
    -- 'folke/snacks.nvim',
    'nvim-telescope/telescope.nvim',
    -- 'ibhagwan/fzf-lua',
    -- 'nvim-mini/mini.pick',
    -- Optional: use your configured completion engine, or built-in completion.
    -- 'saghen/blink.cmp',
    'hrsh7th/nvim-cmp',
    {
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        anti_conceal = { enabled = false },
        file_types = { 'markdown', 'opencode_output' },
      },
      ft = { 'markdown', 'opencode_output' },
    },
  },
  init = function()
    -- Feed opencode.nvim session activity to Herdr (SwiftBar + sounds).
    require('nikp.utils.opencode_herdr').setup()
  end,
  opts = {},
}
