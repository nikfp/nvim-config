return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "saadparwaiz1/cmp_luasnip",
    -- L3MON4D3/LuaSnip is declared in lua/plugins/luasnip.lua (avoid duplicate InsertEnter spec)
  },
  event = "InsertEnter",
  config = function()
    local cmp = require("cmp")
    local ls = require("luasnip")
    local kind_icons = require("nikp.utils.kind_icons")

    -- cmp.config.formatting = {
    --   format = require("tailwindcss-colorizer-cmp").formatter
    -- }
    --
    local sources = {
      { name = "luasnip" },
      { name = "nvim_lsp" },
      { name = "nvim_lsp_signature_help" },
      { name = "nvim_lua" },
      { name = "path" },
      { name = "buffer" },
    }

    local source_index = 0

    cmp.setup({
      snippet = {
        expand = function(args)
          -- Prefer native vim.snippet for Expert (elixir/heex) to avoid LuaSnip's
          -- large-range Select bug with `${1:name}($2) ... $0` snippets.
          -- For other filetypes keep LuaSnip (preserves choice nodes etc).
          local ft = vim.bo.filetype
          if (ft == "elixir" or ft == "heex" or ft == "eelixir") and vim.snippet then
            local ok = pcall(vim.snippet.expand, args.body)
            if ok then return end
          end
          require("luasnip").lsp_expand(args.body)
        end,
      },
      mapping = {
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping(function(_fallback)
          if cmp.visible() then
            source_index = (source_index % #sources) + 1
            cmp.complete({
              config = {
                sources = { sources[source_index] }
              }
            })
          else
            source_index = 0
            cmp.complete({
              config = {
                sources = sources
              }
            })
          end
        end),
        ["<esc>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.abort()
          else
            fallback()
          end
        end, { "i" }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.confirm({ select = true })
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<C-n>"] = cmp.mapping(function(fallback)
          if vim.snippet and vim.snippet.active({ direction = 1 }) then
            vim.snippet.jump(1)
          elseif ls.locally_jumpable(1) or ls.jumpable(1) then
            ls.jump(1)
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<C-p>"] = cmp.mapping(function(fallback)
          if vim.snippet and vim.snippet.active({ direction = -1 }) then
            vim.snippet.jump(-1)
          elseif ls.locally_jumpable(-1) or ls.jumpable(-1) then
            ls.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<C-j>"] = cmp.mapping(function(fallback)
          if ls.choice_active() then
            ls.change_choice(1)
          elseif cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<down>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<C-k>"] = cmp.mapping(function(fallback)
          if ls.choice_active() then
            ls.change_choice(-1)
          elseif cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<up>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, { "i", "s" }),
      },
      sources = sources,
      formatting = {
        fields = { "kind", "abbr", "menu", },
        -- format = require("tailwindcss-colorizer-cmp").formatter,
        format = function(entry, item)
          item.kind = string.format("%s", kind_icons[item.kind])

          item.menu = ({
            buffer = "[Buff]",
            nvim_lsp = "[LSP]",
            path = "[Path]",
            luasnip = "[Snip]",
            nvim_lua = "[Lua]",
          })[entry.source.name]
          local updated = require("tailwindcss-colorizer-cmp").formatter(entry, item)
          return updated
        end,
      },
      completion = {
        autocomplete = false,
      },
      window = {
        documentation = cmp.config.window.bordered()
      }
    })
    vim.cmd([[
      augroup CmpDebounceAuGroup
        au!
        au TextChangedI * lua require("nikp.cmp.debounce").debounce()
      augroup end
    ]])
  end,
}
