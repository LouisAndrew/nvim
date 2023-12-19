-- See https://miguelcrespo.co/posts/debugging-javascript-applications-with-neovim/ for more info
-- JSON5 related
table.insert(vim._so_trails, "/?.dylib")

return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		{
			"mxsdev/nvim-dap-vscode-js",
			config = function()
				---@diagnostic disable-next-line: missing-fields
				require("dap-vscode-js").setup({
					-- Path of node executable. Defaults to $NODE_PATH, and then "node"
					-- node_path = "node",

					-- Path to vscode-js-debug installation.
					debugger_path = vim.fn.resolve(vim.fn.stdpath("data") .. "/lazy/vscode-js-debug"),

					-- Command to use to launch the debug server. Takes precedence over "node_path" and "debugger_path"
					-- debugger_cmd = { "js-debug-adapter" },

					-- which adapters to register in nvim-dap
					adapters = {
						"chrome",
						"pwa-node",
						"pwa-chrome",
						"pwa-msedge",
						"pwa-extensionHost",
						"node-terminal",
					},

					-- Path for file logging
					-- log_file_path = "(stdpath cache)/dap_vscode_js.log",

					-- Logging level for output to file. Set to false to disable logging.
					-- log_file_level = false,

					-- Logging level for output to console. Set to false to disable console output.
					-- log_console_level = vim.log.levels.ERROR,
				})
			end,
		},
		{
			"microsoft/vscode-js-debug",
			build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
		},
		{
			"Joakker/lua-json5",
			build = "./install.sh",
		},
	},
	keys = {
		{ "<leader>dt", "<cmd>:DapToggleBreakpoint<cr>" },
		{ "<leader>dp", "<cmd>:DapToggleBreakpoint<cr>" },

		{ "<leader>di", "<cmd>:DapStepInto<cr>" },
		{ "<leader>do", "<cmd>:DapStepOut<cr>" },
		{ "<leader>dj", "<cmd>:DapStepOver<cr>" },

		{ "<leader>dc", "<cmd>:DapContinue<cr>" },
		{ "<leader>dr", "<cmd>:DapContinue<cr>" },
	},
	config = function()
		require("lsp.dap")
	end,
}
