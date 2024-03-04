local special_chars = require("theme.special_chars")
local keymaps = require("lsp.keymaps")

local lsp_zero = require("lsp-zero")
local saga = require("lspsaga")
local navic = require("nvim-navic")
local utils = require("utils")

vim.diagnostic.config({
	virtual_lines = { only_current_line = true },
	virtual_text = false,
	signs = true,
	severity_sort = true,
	update_in_insert = false,
	underline = true,
})

lsp_zero.on_attach(function(client, bufnr)
	if
		client.server_capabilities["documentSymbolProvider"]
		and utils.has_value({
			"tsserver",
			"graphql",
		}, client.name) ~= true
	then
		navic.attach(client, bufnr)
	end

	keymaps.generate_keymaps(bufnr)
end)

require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = {
		"rust_analyzer",
		"lua_ls",
		"tailwindcss",
		"cssls",
		"html",
		"volar",
	},
	handlers = {
		lsp_zero.default_setup,
		rust_analyzer = function()
			require("lspconfig").rust_analyzer.setup({
				on_attach = lsp_zero.on_attach,
				settings = {
					["rust-analyzer"] = {
						checkOnSave = {
							command = "clippy",
						},
					},
				},
			})
		end,
	},
})

local lspconfig = require("lspconfig")

lspconfig.graphql.setup({
	filetypes = { "graphql", "javascript", "typescript", "typescriptreact" },
})

lspconfig.tailwindcss.setup({
	root_dir = lspconfig.util.root_pattern(
		"tailwind.config.js",
		"tailwind.config.cjs",
		"tailwind.config.ts",
		"tailwind.config.mjs"
	),
	filetypes = { "html", "css", "scss", "typescriptreact", "svelte", "vue", "javascriptreact", "astro" },
})

local util = require("lspconfig.util")
-- Get TS version for volar, use installed version if not found
local function get_typescript_server_path(root_dir)
	-- Highly dependent on nvm and node version
	local global_ts = "/Users/louis.andrew/.nvm/versions/node/v20.10.0/lib/node_modules/typescript/lib"
	-- Alternative location if installed as root:
	-- local global_ts = '/usr/local/lib/node_modules/typescript/lib'
	local found_ts = ""
	local function check_dir(path)
		found_ts = util.path.join(path, "node_modules", "typescript", "lib")
		if util.path.exists(found_ts) then
			return path
		end
	end
	if util.search_ancestors(root_dir, check_dir) then
		return found_ts
	else
		return global_ts
	end
end

vim.g.PREVENT_CLASH_TS_VUE = "true"

lspconfig.volar.setup({
	root_dir = lspconfig.util.root_pattern("*.vue"),
	filetypes = { "typescript", "vue", "javascript" },
	on_attach = function(clientnr, bufnr)
		local active_clients = vim.lsp.get_active_clients()
		for _, client in pairs(active_clients) do
			if vim.g.PREVENT_CLASH_TS_VUE == "true" and client.name == "tsserver" then
				client.stop()
			end
		end
	end,
	on_new_config = function(new_config, new_root_dir)
		local path = get_typescript_server_path(new_root_dir)
		vim.g.TS_PATH = path
		new_config.init_options.typescript.tsdk = path
	end,
})

local vue_project = true
local lsputils = require("lspconfig.util")
lspconfig.tsserver.setup({
	filetypes = { "typescript", "typescriptreact", "javascript" },
	root_dir = function(filename, bufnr)
		local has_vue = lsputils.root_pattern("*.vue")(filename, bufnr)
		vue_project = has_vue ~= nil
		if vue_project then
			return
		end

		return lsputils.root_pattern("package.json")(filename, bufnr)
	end,
	on_attach = function(ts_client, bufnr)
		if vue_project then
			ts_client.stop()
			return
		end

		navic.attach(ts_client, bufnr)
	end,
})
local saga_keys = {
	edit = "<cr>",
	vsplit = "<C-l>",
	split = "<C-j>",
	quit = "<leader>w",
	tabe = "<C-t>",
}

saga.setup({
	scroll_preview = { scroll_down = "<C-d>", scroll_up = "<C-u>" },
	definition = {
		keys = saga_keys,
	},
	finder = {
		keys = saga_keys,
	},
	code_action = {
		keys = {
			quit = "<leader>w",
		},
	},
	lightbulb = {
		enabled = false,
		sign_priority = 1,
	},
	ui = {
		title = false,
		border = special_chars.create_special_border({
			side_padding = true,
			hide_vertical_padding = true,
		}),
		code_action = " ",
	},
	symbol_in_winbar = {
		enable = false,
		show_file = false,
	},
	outline = {
		keys = {
			toggle_or_jump = "<CR>",
		},
	},
	diagnostic = {
		border_follow = false,
		text_hl_follow = false,
	},
	rename = {
		in_select = false,
	},
})
