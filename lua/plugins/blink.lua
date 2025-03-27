local M = {}

M.providers = { 'snippets', 'lsp', 'buffer', 'path' }



-- I need a way to track which source is in use.
-- I'll use a variable to track the current source
-- This variable will start at 0, and then advance up to the number of sources,
-- and then back to 0
M.current_source = 0

-- I need a function to advance the current source
M.advance_source = function()
  if M.current_source == #M.providers then
    M.current_source = 0
  else
    M.current_source = M.current_source + 1
  end
end
-- I'll also need a function to reset the current source to nil
M.reset_source = function()
  M.current_source = 0
end

-- I'll write a function on `M` to fetch sources
-- When the sources are initially requested, I want to return a table with all sources
-- Subsequent requests for sources should cycle sources one at a time,
-- and return a table with just the current source
M.fetch_sources = function()
  if M.current_source == 0 then
    local sources = M.providers
    M.advance_source()
    return sources;
  else
    local source = M.providers[M.current_source]
    M.advance_source()
    return { source }
  end
end

return {
  'saghen/blink.cmp',
  -- optional: provides snippets for the snippet source
  dependencies = 'L3MON4D3/LuaSnip',

  event = "VeryLazy",

  -- use a release tag to download pre-built binaries
  version = "1.*",
  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    completion = {
      keyword = {
        range = 'full',
      },
      menu = {
        border = 'single',
        max_height = 15,
        draw = {
          columns = { { 'source_name' }, { 'kind_icon', gap = 1 }, { 'label', 'label_description', gap = 1 } },
        }
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
      ["<C-Space>"] = { function(cmp)
        if not cmp.is_visible() then
          M.reset_source()
          local sources = M.fetch_sources()
          cmp.show({ providers = sources, force = true })
          return true
        else
          local sources = M.fetch_sources()
          vim.print(sources)
          cmp.show({ providers = sources, force = true })

          return true
        end
      end },
      ["<esc>"] = { 'hide', 'fallback' },
      ["<Tab>"] = { 'select_and_accept', 'fallback' },
      ["<C-n>"] = {
        function(_)
          if vim.snippet.active({ direction = 1 }) then
            vim.snippet.jump(1)
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
          if vim.snippet.active({ direction = -1 }) then
            vim.snippet.jump(-1)
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
      preset = 'luasnip'
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
      default = M.providers,
      providers = {
        -- luasnip = {
        --   score_offset = 100
        -- },
        snippets = {
          score_offset = 500,
          transform_items = function(_, items)
            for _, item in ipairs(items) do
              item.source_name = '[SNI]'
            end
            return items
          end
        },
        lsp = {
          score_offset = 60,
          timeout_ms = 5000,
          transform_items = function(_, items)
            for _, item in ipairs(items) do
              item.source_name = '[LSP]'
            end
            return items
          end
        },
        path = {
          score_offset = 40,
          transform_items = function(_, items)
            for _, item in ipairs(items) do
              item.source_name = '[PAT]'
            end
            return items
          end
        },
        buffer = {
          score_offset = 20,
          transform_items = function(_, items)
            for _, item in ipairs(items) do
              item.source_name = '[BUF]'
            end
            return items
          end
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
