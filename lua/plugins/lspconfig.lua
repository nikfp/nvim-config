return {
  {
    "glepnir/lspsaga.nvim",
    event = "VeryLazy",
    branch = "main",
  },
  {
    "neovim/nvim-lspconfig",
    event = "BufAdd",
    dependencies = {
      -- "jose-elias-alvarez/null-ls.nvim",
      "glepnir/lspsaga.nvim",
      "stevearc/conform.nvim",
      "windwp/nvim-ts-autotag",
      -- "leafoftree/vim-svelte-plugin",
      "glepnir/lspsaga.nvim",
      "simrat39/rust-tools.nvim",
      "windwp/nvim-autopairs",
    },
    config = function()
      local popup = require("nikp.utils.popup")
      local nvim_lsp = require("lspconfig")
      local on_attach = require("nikp.keymaps.lsp").on_attach
      local map = require("nikp.keymaps.utils").map
      require("notifier").setup()
      require("lint")

      -- Common UI settings related to LSP

      require("lspsaga").setup({
        symbol_in_winbar = {
          enable = false,
        },
      })
      -- LSP Diagnostics Options Setup
      local sign = function(opts)
        vim.fn.sign_define(opts.name, {
          texthl = opts.name,
          text = opts.text,
          numhl = "",
        })
      end

      sign({ name = "DiagnosticSignError", text = "" })
      sign({ name = "DiagnosticSignWarn", text = "" })
      sign({ name = "DiagnosticSignHint", text = "" })
      sign({ name = "DiagnosticSignInfo", text = "" })

      vim.diagnostic.config({
        virtual_text = {
          prefix = "●",
        },
        signs = true,
        update_in_insert = true,
        underline = true,
        severity_sort = false,
        severity = { min = vim.diagnostic.severity.HINT },
        float = {
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      })

      -- Fixed column for diagnostics to appear
      -- Show autodiagnostic popup on cursor hover_range
      vim.cmd([[
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

      -- Common flags
      local lsp_flags = {
        -- This is the default in Nvim 0.7+
        debounce_text_changes = 50,
      }

      -- set up completion capabilities using nvim_cmp with LSP source
      local capabilities =
          require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      -- PER LANGUAGE SETUPS

      -- C and Variants
      nvim_lsp.clangd.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        lsp_flags = lsp_flags,
      })

      -- TYPESCRIPT
      nvim_lsp.tsserver.setup({
        on_attach = function(client, bufnr)
          on_attach(client, bufnr)
          client.server_capabilities.documentFormattingProvider = false
        end,
        flags = lsp_flags,
        filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript", "javascriptreact" },
        capabilities = capabilities,
        single_file_support = true,
      })

      --SVELTE
      nvim_lsp.svelte.setup({
        on_attach = on_attach,
        flags = lsp_flags,
      })
      vim.g.vim_svelte_plugin_use_typescript = 1

      -- RUST
      local rt = require("rust-tools")

      rt.setup({
        server = {
          standalone = true,
          capabilities = capabilities,
          on_attach = function(client, bufnr)
            -- add keymaps for the rest of things
            on_attach(client, bufnr)
            -- Hover actions
            map("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            map("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
            -- easy run code
            map("n", "<leader>ru", function()
              popup.output_command(":!cargo run")
            end)
            -- easy format
            map("n", "<leader>cf", ":!cargo fmt<cr><cr><cr>:echo 'Running rust formatter'<cr>")
            -- add semicolon easily
            map("n", "<leader>;", "$a;<esc>o")
          end,

          settings = {
            ["rust-analyzer"] = {
              checkOnSave = { command = "clippy" },
            },
          },
        },
        tools = {
          reload_workspace_from_cargo_toml = true,
          inlay_hints = {
            only_current_line = false,
            show_parameter_hints = false,
            other_hints_prefix = "",
          },
        },
        flags = lsp_flags,
      })

      -- GOLANG
      local util = require("lspconfig/util")
      nvim_lsp.gopls.setup({
        cmd = { "gopls", "serve" },
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        root_dir = util.root_pattern("go.work", "go.mod", ".git"),
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          on_attach(client, bufnr)
          map("n", "<leader>ru", function()
            popup.output_command(":!go run .")
          end)
        end,
      })

      -- TAILWINDCSS
      nvim_lsp.tailwindcss.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        autostart = false
      })

      -- JSON
      nvim_lsp.jsonls.setup({
        capabilities = capabilities,
        on_attach = on_attach
      })

      -- HTML
      nvim_lsp.html.setup({
        capabilities = capabilities,
        on_attach = on_attach
      })

      -- LUA
      nvim_lsp.lua_ls.setup({
        commands = {
          Format = {
            function()
              vim.lsp.buf.format()
            end,
          },
        },
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },
          },
        },
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          on_attach(client, bufnr)
        end,
      })

      -- CSS
      nvim_lsp.cssls.setup({
        capabilities = capabilities,
        on_attach = on_attach
      })
      nvim_lsp.cssmodules_ls.setup({
        capabilities = capabilities,
      })

      -- PRISMA
      nvim_lsp.prismals.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      -- BASH
      nvim_lsp.bashls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = { "sh", "*.bashrc", "shell" },
        {
          bashIde = {
            globPattern = "*@(.sh|.inc|.bash|.command)"
          }
        }
      })

      --Set completeopt to have a better completion experience
      -- :help completeopt
      -- menuone: popup even when there's only one match
      -- noinsert: Do not insert text until a selection is made
      -- noselect: Do not select, force to select one from the menu
      -- shortness: avoid showing extra messages when using completion
      -- updatetime: set updatetime for CursorHold
      vim.opt.completeopt = { "menu", "menuone", "noselect", "noinsert" }
      vim.opt.shortmess = vim.opt.shortmess + { c = true }
      vim.api.nvim_set_option("updatetime", 300)
    end,
  },
}
