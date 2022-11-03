local rt = require("rust-tools")

rt.setup({
  server = {
    on_attach = function(_, bufnr)
      print('got to rust setup')
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
      -- easy run code
      vim.keymap.set('n', '<leader>ru', ":!cargo run<cr>")
      -- easy format
      vim.keymap.set('n', '<leader>fmt', ":!cargo fmt<cr>")
      -- add semicolon easily
      vim.keymap.set('n', '<leader>;', "$a;<esc>o")
    end,
  },
})
