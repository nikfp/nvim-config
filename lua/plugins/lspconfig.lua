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
      local nvim_lsp_configs = require("lspconfig.configs")
      local on_attach = require("nikp.keymaps.lsp").on_attach
      local diagnostic_config = require("nikp.keymaps.lsp").diagnostic_config
      local map = require("nikp.keymaps.utils").map
      require("notifier").setup()
      -- require("lint")

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

      vim.diagnostic.config(diagnostic_config)

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
      --- @param err lsp.ResponseError
      --- @param result lsp.PublishDiagnosticsParams
      --- @param ctx lsp.HandlerContext
      local function diagnostics_handler(err, result, ctx)
        if err ~= nil then
          error("Failed to request diagnostics: " .. vim.inspect(err))
        end

        if result == nil then
          return
        end

        local buffer = vim.uri_to_bufnr(result.uri)
        local namespace = vim.lsp.diagnostic.get_namespace(ctx.client_id)

        local diagnostics = vim.tbl_map(function(diagnostic)
          local resultLines = vim.split(diagnostic.message, '\n')
          local output = vim.fn.reverse(resultLines)
          return {
            bufnr = buffer,
            lnum = diagnostic.range.start.line,
            end_lnum = diagnostic.range["end"].line,
            col = diagnostic.range.start.character,
            end_col = diagnostic.range["end"].character,
            severity = diagnostic.severity,
            message = table.concat(output, "\n\n"),
            source = diagnostic.source,
            code = diagnostic.code,
          }
        end, result.diagnostics)

        vim.diagnostic.set(namespace, buffer, diagnostics)
      end

      -- TYPESCRIPT
      nvim_lsp.tsserver.setup({
        on_attach = function(client, bufnr)
          on_attach(client, bufnr)
          client.server_capabilities.documentFormattingProvider = false
        end,
        handlers = {
          ["textDocument/publishDiagnostics"] = diagnostics_handler
        },
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

      nvim_lsp.eslint.setup({
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
        filetypes = { "javascriptreact", "typescriptreact" }
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

      -- OCAML
      nvim_lsp.ocamllsp.setup({
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          on_attach(client, bufnr)

          map("n", "<leader>ru", function()
            popup.output_command(":!")
          end)
        end,
      })

      -- ELIXIR
      --
      nvim_lsp.elixirls.setup({
        cmd = { "/home/nikp/elixirls/language_server.sh" },
        capabilities = capabilities,
        on_attach = on_attach
      })
      local lexical_config = {
        filetypes = { "elixir", "eelixir", "heex" },
        cmd = { "/home/nikp/lexical/_build/dev/package/lexical/bin/start_lexical.sh" },
        settings = {},
      }
      
      if not nvim_lsp_configs.lexical then
        nvim_lsp_configs.lexical = {
          default_config = {
            filetypes = lexical_config.filetypes,
            cmd = lexical_config.cmd,
            root_dir = function(fname)
              return nvim_lsp.util.root_pattern("mix.exs", ".git")(fname) or vim.loop.os_homedir()
            end,
            -- optional settings
            -- settings = lexical_config.settings,
          },
        }
      end
      
      nvim_lsp.lexical.setup({
        on_attach = function(client, bufnr)
          on_attach(client, bufnr)
          map("n", "<leader>ru", function()
            local file = vim.fn.expand("%")
            popup.output_command(":!elixir " .. file)
          end, { desc = "Run current elixir file" })
          diag_namespace = vim.lsp.diagnostic.get_namespace(client.id)
      
          diag_config = diagnostic_config
      
          diag_config["update_in_insert"] = false
          vim.diagnostic.config(diag_config, diag_namespace)
      
        end,
        capabilities = capabilities
      })
      --
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
