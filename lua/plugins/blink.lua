return {
  'saghen/blink.cmp',
  -- optional: provides snippets for the snippet source
  dependencies = 'L3MON4D3/LuaSnip',

  -- use a release tag to download pre-built binaries
  version = '0.9.1',
  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',

  opts = {
    keymap = {
      preset = 'default',

      -- ["<C-b>"] = { 'scroll_documentation_up', 'fallback' },
      -- ["<C-f>"] = { 'scroll_documentation_down', 'fallback' },
      -- ["<C-Space>"] = { 'show', 'fallback' },
      -- ["<esc>"] = { 'hide', 'fallback' },
      -- ["<Tab>"] = { 'select_and_accept', 'fallback' },
      -- ["<C-n>"] = {
      --   function(_)
      --     if require("luasnip").locally_jumpable(1) then
      --       require("luasnip").jump(1)
      --       return true
      --     else
      --       return false
      --     end
      --   end,
      --   'fallback'
      -- },
      -- ["<C-p>"] = {
      --   function(_)
      --     if require("luasnip").locally_jumpable(-1) then
      --       require("luasnip").jump(-1)
      --       return true
      --     else
      --       return false
      --     end
      --   end,
      --   'fallback'
      -- },
      -- ["<C-j>"] = {
      --   function(_)
      --     if require("luasnip").choice_active() then
      --       require("luasnip").change_choice(1)
      --       return true
      --     else
      --       return false
      --     end
      --   end,
      --   'select_next',
      --   'fallback' },
      -- ["<C-k>"] = {
      --   function(_)
      --     if require("luasnip").choice_active() then
      --       require("luasnip").change_choice(-1)
      --       return true
      --     else
      --       return false
      --     end
      --   end,
      --   'select_prev',
      --   'fallback' },
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
      default = { 'lsp', 'path', 'luasnip', 'buffer' },
    },
    signature = { enabled = true }
  }


}
