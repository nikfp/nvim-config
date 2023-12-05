return {
  "stevearc/conform.nvim",
  event = 'VeryLazy',
  config = function()
    local filetypes = {
      "css",
      "html",
      "javascript",
      "javascriptreact",
      "json",
      "svelte",
      "typescript",
      "typescriptreact",
    }

    local formatter = { "prettier" }
    local ft_configs = {}

    for _, value in pairs(filetypes) do
      -- vim.tbl_extend("force", { [value] = })
      ft_configs[value] = formatter
    end

    ft_configs["ocaml"] = { "ocamlformat" }

    require("conform").setup({
      formatters_by_ft = ft_configs
    })
  end
}
