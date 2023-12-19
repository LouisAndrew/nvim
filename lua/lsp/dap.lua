local js_based_languages = { "typescript", "javascript", "typescriptreact", "vue" }
-- https://github.com/nikolovlazar/dotfiles/blob/main/.config/nvim/lua/plugins/dap.lua
--
--[[ -- setup adapters
require("dap-vscode-js").setup({
	debugger_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter",
	debugger_cmd = { "js-debug-adapter" },
	adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
})
 ]]
local dap = require("dap")

-- custom adapter for running tasks before starting debug
local custom_adapter = "pwa-node-custom"
dap.adapters[custom_adapter] = function(cb, config)
	if config.preLaunchTask then
		local async = require("plenary.async")
		local notify = require("notify").async

		async.run(function()
			---@diagnostic disable-next-line: missing-parameter
			notify("Running [" .. config.preLaunchTask .. "]").events.close()
		end, function()
			vim.fn.system(config.preLaunchTask)
			config.type = "pwa-node"
			dap.run(config)
		end)
	end
end

-- language config
for _, language in ipairs(js_based_languages) do
	dap.configurations[language] = {
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch file",
			program = "${file}",
			cwd = vim.fn.getcwd(),
			sourceMaps = true,
		},
		-- Debug nodejs processes (make sure to add --inspect when you run the process)
		{
			type = "pwa-node",
			request = "attach",
			name = "Attach",
			processId = require("dap.utils").pick_process,
			cwd = vim.fn.getcwd(),
			sourceMaps = true,
		},
		-- Debug web applications (client side)
		{
			type = "pwa-chrome",
			request = "launch",
			name = "Launch & Debug Chrome",
			url = function()
				local co = coroutine.running()
				return coroutine.create(function()
					vim.ui.input({
						prompt = "Enter URL: ",
						default = "http://localhost:3000",
					}, function(url)
						if url == nil or url == "" then
							return
						else
							coroutine.resume(co, url)
						end
					end)
				end)
			end,
			webRoot = vim.fn.getcwd(),
			protocol = "inspector",
			sourceMaps = true,
			userDataDir = false,
		},
		-- Example
		{
			name = "Debug TS",
			type = "pwa-node",
			request = "launch",
			program = "${workspaceFolder}/node_modules/tsx/dist/cli.mjs",
			args = {
				"${workspaceFolder}/src/others/p.ts", -- <- @TODO set entry file
			},
			rootPath = "${workspaceFolder}",
			cwd = "${workspaceFolder}",
			sourceMaps = true,
			skipFiles = { "<node_internals>/**" },
			protocol = "inspector",
			console = "integratedTerminal",
		},
	}
end

local dapui = require("dapui")
dapui.setup()
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

require("dap.ext.vscode").load_launchjs(nil, {
	["pwa-node"] = js_based_languages,
	["node"] = js_based_languages,
	["chrome"] = js_based_languages,
	["pwa-chrome"] = js_based_languages,
})

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "dapbreakpoint", linehl = "", numhl = "" })
