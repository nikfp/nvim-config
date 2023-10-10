return {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    config = function()
      local filetypes = {
        "javascript",
        "javascriptreact",
        "svelte",
        "typescript",
        "typescriptreact",
      }

      local linter = { "eslint" }
      local ft_configs = {}

      for _, value in pairs(filetypes) do
        ft_configs[value] = linter
      end

      require("lint").linters_by_ft = ft_configs

      vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })
    end
  }
