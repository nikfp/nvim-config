-- UTILS FOR SNIPPET CREATION
local luasnip = require("luasnip")

local f = luasnip.function_node
local M = {}

M.capitalize_first_letter = function(index)
	return f(function(arg)
		local str = arg[1][1]
		return str:sub(1, 1):upper() .. str:sub(2, -1)
	end, { index })
end

return M
