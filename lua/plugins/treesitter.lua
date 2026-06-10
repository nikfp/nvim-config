return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    branch = "main",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "JoosepAlviste/nvim-ts-context-commentstring"
    },
    config = function()
      local filetypes = {
        "bash",
        "css",
        "elixir",
        "heex",
        "html",
        "javascript",
        "lua",
        "markdown",
        "markdown_inline",
        "regex",
        "rust",
        "svelte",
        "toml",
        "tsx",
        "typescript",
        "vim",
      }
      require("nvim-treesitter").setup({
        ensure_installed = filetypes,
        auto_install = true,
        sync_install = false,
        ignore_install = {},
        modules = {},
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
        rainbow = {
          enable = true,
          extended_mode = true,
          max_file_lines = nil,
        },
        autotag = {
          enable = true,
          enable_close_on_slash = false
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn", -- set to `false` to disable one of the mappings
            node_incremental = "gnn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
      })

      require("ts_context_commentstring").setup({})

      vim.treesitter.language.register("bash", "tmux")
      -- vim.opt.foldmethod = "expr"
      -- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

      vim.api.nvim_create_autocmd("FileType", {
        pattern = filetypes,
        callback = function()
          vim.treesitter.start()
        end,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    dependencies = {
      "nvim-treesitter/nvim-treesitter"
    },
    config = function()
      require('nvim-treesitter-textobjects').setup({
        select = {
          enable = true,
          lookahead = true
        }
      })

      local map = require('nikp.keymaps.utils').map

      ---@param query string
      local select = function(query)
        require('nvim-treesitter-textobjects.select').select_textobject(query, 'textobjects')
      end

      map({ 'o', 'x' }, 'af', function()
        select("@function.outer")
      end)
      map({ 'o', 'x' }, 'af', function()
        select("@function.inner")
      end)
      map({ 'o', 'x' }, 'ab', function()
        select("@block.outer")
      end)
      map({ 'o', 'x' }, 'ab', function()
        select("@block.inner")
      end)
      map({ 'o', 'x' }, 'ad', function()
        select("@do_block.outer")
      end)
      map({ 'o', 'x' }, 'ad', function()
        select("@do_block.inner")
      end)
      -- map('ox', 'if', select '@function.inner')
      -- map('ox', 'ip', select '@parameter.inner')
      -- map('ox', 'ap', select '@parameter.outer')
      -- map('ox', 'ib', select '@block.inner')
      -- map('ox', 'ab', select '@block.outer')
    end



  }
}
