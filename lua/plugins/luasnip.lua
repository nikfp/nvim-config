return {
  "L3MON4D3/LuaSnip",
  dependencies = {
    "hrsh7th/nvim-cmp",
  },
  event = "InsertEnter",
  config = function()
    local ls = require("luasnip")

    local s, i, t = ls.s, ls.i, ls.t
    local c = ls.choice_node
    local f = ls.function_node
    local fmt = require("luasnip.extras.fmt").fmt
    local rep = require("luasnip.extras").rep

    local utils = require("nikp.utils.snip_utils")


    -- LUA SNIPPETS
    ls.add_snippets("lua", {
      s(
        "req",
        fmt([[local {} = require'{}']], {
          f(function(import_name)
            local parts = vim.split(import_name[1][1], ".", true)
            return parts[#parts] or ""
          end, { 1 }),
          i(1),
        })
      ),
      s("desc", fmt([[{{ desc = "{}"}}]], { i(1) })),
      s("map", fmt([[map("{}", "{}", {}{})]], { c(1, { t("n"), t("v"), t("i"), t("c") }), i(2), i(3), i(4) })),
    })
    -- JAVASCRIPT SNIPPETS
    ls.add_snippets("javascript", {
      s("log", fmt([[console.log({})]], { i(1) })),
      s("import", fmt([[import {} from '{}{}';]], { i(3), i(1), i(2) })),
      s("dest", fmt([[const {{ {} }} = {};]], { i(2), i(1)}))
    })
    -- JAVASCRIPT REACT SNIPPETS
    ls.add_snippets("javascriptreact", {
      s(
        "frag",
        fmt(
          [[
  <>
    {}
  </>
  ]],
          { i(1) }
        )
      ),
    })
    -- TYPESCRIPT SNIPPETS
    ls.add_snippets("typescript", {
      s(
        "useState",
        fmt([[const [ {}, set{} ] = useState{}({});]], { i(1), utils.capitalize_first_letter(1), i(2), i(3) })
      ),
    })

    ls.filetype_extend("typescript", { "javascript" })
    ls.filetype_extend("typescriptreact", { "typescript", "javascript", "javascriptreact" })
    -- SVELTE SNIPPETS
    ls.add_snippets("svelte", {
      s(
        "sv",
        fmt(
          [[
    <script lang="ts">
      {}
    </script>
    ]],
          { i(1) }
        )
      ),
      s("pd",
        fmt([[
    import type {{ PageData }} from './$types'

    export let data: PageData;
    {}
        ]], { i(1) }))
    })
    ls.filetype_extend("svelte", { "typescript", "javascript" })

    -- RUST SNIPPETS
    ls.add_snippets("rust", {
      s("printfmt", fmt([[println!("{{:?}}{}", {});]], { i(1), i(2) })),
    })
    -- DEV TOOLS FOR SNIPPETS - UNCOMMENT LINES BELOW FOR REPL USE
    -- vim.keymap.set("n", "<leader><leader>ls", '<cmd>source %<cr>', {silent = true, noremap = true})
    -- vim.keymap.set("n", "<leader><leader>lc",function()
    --   ls.cleanup()
    -- end, {silent = true, noremap = true})

    ls.setup({
      delete_check_events = { "InsertLeave", "TextChanged" }
    })
  end,
}
