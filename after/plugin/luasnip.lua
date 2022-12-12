local ls = require("luasnip")

local s, i, t = ls.s, ls.i, ls.t
local c = ls.choice_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local utils = require("nikp.snip_utils")

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
})
-- JAVASCRIPT SNIPPETS
ls.add_snippets("javascript", {
	s("log", fmt([[console.log({})]], { i(1) })),
})
-- TYPESCRIPT SNIPPETS
ls.add_snippets("typescript", {
	s(
		"useState",
		fmt([[const [ {}, set{} ] = useState{}({});]], { i(1), utils.capitalize_first_letter(1), i(2), i(3) })
	),
})

ls.filetype_extend("typescript", { "javascript" })
ls.filetype_extend("typescriptreact", { "typescript", "javascript" })
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
