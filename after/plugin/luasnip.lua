local ls = require'luasnip'

local s, i, t = ls.s, ls.i, ls.t
local c = ls.choice_node
local test = require'luasnip'
local fmt = require'luasnip.extras.fmt'.fmt
local rep = require'luasnip.extras'.rep

 ls.add_snippets("lua",  {
   -- require function
    s("req", fmt("local {} = require'{}{}'", {
      i(1, "default"), rep(1), i(2)
    })),

  })

