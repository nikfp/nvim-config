return {
  "pwntester/octo.nvim",
  cmd = "Octo",
  opts = {
    -- or "fzf-lua" or "snacks" or "default"
    picker = "telescope",
    -- bare Octo command opens picker of commands
    enable_builtin = true,
  },
  keys = {
    {
      "<leader>oil",
      "<CMD>Octo issue list<CR>",
      desc = "List GitHub Issues",
    },
    {
      "<leader>oic",
      "<CMD>Octo issue create<CR>",
      desc = "Create Octo Issue"
    },
    {
      "<leader>oim",
      function()
        require("nikp.utils.milestones").pick_milestone_issues()
      end,
      desc = "List GH issues for a milestone"
    },
    {
      "<leader>op",
      "<CMD>Octo pr list<CR>",
      desc = "List GitHub PullRequests",
    },
    {
      "<leader>od",
      "<CMD>Octo discussion list<CR>",
      desc = "List GitHub Discussions",
    },
    {
      "<leader>on",
      "<CMD>Octo notification list<CR>",
      desc = "List GitHub Notifications",
    },
    {
      "<leader>os",
      function()
        require("octo.utils").create_base_search_command { include_current_repo = true }
      end,
      desc = "Search GitHub",
    },
    {
      "<leader>oc",
      "<CMD>Octo<CR>",
      desc = "Open Octo Command Menu"
    },
    {
      "<leader>oml",
      "<CMD>Octo milestone list<cr>",
      desc = "List milestones (will open GH)"
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    -- OR "ibhagwan/fzf-lua",
    -- OR "folke/snacks.nvim",
    "nvim-tree/nvim-web-devicons", -- optional if file_panel.icons is a function
  },
}
