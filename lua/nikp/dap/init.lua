local M = {}

M.setup = function()
	local dap_ok, dap = pcall(require, "dap")
	local dap_ui_ok, ui = pcall(require, "dapui")
	if not (dap_ok and dap_ui_ok) then
		print("nvim-dap not installed!")
		return
	end

	for _, language in ipairs({ "typescript", "javascript" }) do
		dap.configurations[language] = {
			{
				type = "node2",
				name = "Launch",
				request = "launch",
				program = "${workspaceFolder}/out/index.js",
				cwd = vim.fn.getcwd(),
				sourceMaps = true,
				protocol = "inspector",
				console = "integratedTerminal",
				outFiles = { "${workspaceFolder}/out/**/*.js" },
			},
			{
				type = "node2",
				name = "Attach",
				request = "attach",
				program = "${workspaceFolder}/out/index.js",
				cwd = vim.fn.getcwd(),
				sourceMaps = true,
				protocol = "inspector",
				console = "integratedTerminal",
				outFiles = { "${workspaceFolder}/out/**/*.js" },
			},
		}
	end

	require("dap").set_log_level("INFO")

	dap.adapters.node2 = {
		type = "executable",
		command = "node",
		-- args = { vim.fn.stdpath("data") .. "/mason/bin/js-debug-adapter" },
		args = { vim.fn.stdpath("data") .. "/mason/packages/node-debug2-adapter/out/src/nodeDebug.js" },
	}

	ui.setup({
		icons = { expanded = "▾", collapsed = "▸" },
		mappings = {
			open = "o",
			remove = "d",
			edit = "e",
			repl = "r",
			toggle = "t",
		},
		expand_lines = vim.fn.has("nvim-0.7"),
		layouts = {
			{
				elements = {
					"scopes",
          "watches"
				},
				size = 0.3,
				position = "right",
			},
			{
				elements = {
					"repl",
					"breakpoints",
				},
				size = 0.3,
				position = "bottom",
			},
		},
		floating = {
			max_height = nil,
			max_width = nil,
			border = "single",
			mappings = {
				close = { "q", "<Esc>" },
			},
		},
		windows = { indent = 1 },
		render = {
			max_type_length = nil,
		},
	})
end

return M
