return {
  'saghen/blink.cmp',
  -- optional: provides snippets for the snippet source
  dependencies = 'L3MON4D3/LuaSnip',

  event = "VeryLazy",

  -- use a release tag to download pre-built binaries
  version = '0.9.1',
  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',

  opts = {
    completion = {
      list = {
        selection = "auto_insert"
      },
      keyword = {
        range = 'full'
      },
      menu = {
        border = 'single'
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
        window = {
          border = 'single'
        }
      },
    },
    keymap = {
      preset = 'none',

      ["<C-b>"] = { 'scroll_documentation_up', 'fallback' },
      ["<C-f>"] = { 'scroll_documentation_down', 'fallback' },
      ["<C-Space>"] = { 'show' },
      ["<esc>"] = { 'hide', 'fallback' },
      ["<Tab>"] = { 'select_and_accept', 'fallback' },
      ["<C-n>"] = {
        function(_)
          if require("luasnip").locally_jumpable(1) then
            require("luasnip").jump(1)
            return true
          else
            return false
          end
        end,
        'snippet_forward',
        'fallback'
      },
      ["<C-p>"] = {
        function(_)
          if require("luasnip").locally_jumpable(-1) then
            require("luasnip").jump(-1)
            return true
          else
            return false
          end
        end,
        'snippet_backward',
        'fallback'
      },
      ["<C-j>"] = {
        function(_)
          if require("luasnip").choice_active() then
            require("luasnip").change_choice(1)
            return true
          else
            return false
          end
        end,
        'select_next',
        'fallback' },
      ["<C-k>"] = {
        function(_)
          if require("luasnip").choice_active() then
            require("luasnip").change_choice(-1)
            return true
          else
            return false
          end
        end,
        'select_prev',
        'fallback' },
    },
    snippets = {
      expand = function(snippet) require('luasnip').lsp_expand(snippet) end,
      active = function(filter)
        if filter and filter.direction then
          return require('luasnip').jumpable(filter.direction)
        end
        return require('luasnip').in_snippet()
      end,
      jump = function(direction) require('luasnip').jump(direction) end,
    },
    appearance = {
      -- Sets the fallback highlight groups to nvim-cmp's highlight groups
      -- Useful for when your theme doesn't support blink.cmp
      -- Will be removed in a future release
      use_nvim_cmp_as_default = true,
      -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'normal'
    },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { 'luasnip', 'lsp', 'path', 'buffer' },
      providers = {
        luasnip = {
          score_offset = 100
        },
        -- snippet = {
        --   score_offset = 80
        -- },
        lsp = {
          score_offset = 60,
          timeout_ms = 5000
        },
        path = {
          score_offset = 40
        }
      }
    },
    signature = {
      enabled = true,
      window = {
        border = 'single'
      }
    }
  },
  opt_extend = { "sources.default" }


}
