local lsp_zero = require("lsp-zero")
local saga = require("lspsaga")
local VT_PREFIX = " "
-- local VT_PREFIX = nil

vim.diagnostic.config({
	virtual_text = {
		source = true,
		prefix = VT_PREFIX,
		spacing = 0,
	},
	update_in_insert = false,
	underline = true,
	severity_sort = true,
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		source = true,
		header = "",
		prefix = "",
	},
	signs = false,
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	underline = true,
	virtual_text = {
		prefix = VT_PREFIX,
		spacing = 0,
	},
})

local function remove_duplicates(client)
	local is_duplicated = false
	local active_clients = vim.lsp.get_active_clients()

	for _, act_client in pairs(active_clients) do
		if client.name == act_client.name and client.id ~= act_client.id then
			is_duplicated = true
			break
		end
	end

	-- Prevent more than one LSP instance attached (e.g. neogit)
	if is_duplicated then
		client.stop()
	end

	return is_duplicated
end

lsp_zero.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	if remove_duplicates(client) then
		return
	end

	vim.keymap.set("n", "<leader>iO", vim.lsp.buf.definition, opts)

	vim.keymap.set("n", "<leader>ij", "<cmd>Lspsaga hover_doc<CR>", opts)
	-- Try to get out from
	vim.keymap.set("n", "<leader>ii", vim.lsp.buf.hover, opts)

	vim.keymap.set("n", "<leader>io", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window

	vim.keymap.set("n", "<leader>if", "<cmd>Lspsaga finder<CR>", opts) -- show definition, references
	vim.keymap.set("n", "<leader>is", vim.lsp.buf.workspace_symbol, opts)
	vim.keymap.set("n", "<leader>it", "<cmd>Lspsaga outline<CR>", opts)
	vim.keymap.set(
		"i",
		"<c-b>",
		vim.lsp.buf.signature_help,
		{ silent = true, noremap = true, desc = "toggle signature" }
	)

	vim.keymap.set("n", "<leader>id", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
	vim.keymap.set("n", "<leader>iD", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)
	vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
	vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
	vim.keymap.set("n", "<leader>ia", "<cmd>Lspsaga code_action<CR>", opts)
	vim.keymap.set("n", "<leader>ir", "<cmd>Telescope lsp_references<cr>", opts)
	vim.keymap.set("n", "<leader>in", "<cmd>Lspsaga rename<CR>", opts) -- smart rename
	vim.keymap.set("n", "<leader>rr", "<cmd>LspRestart<CR>", opts) -- smart rename

	vim.keymap.set("n", "<leader>ie", function()
		vim.lsp.util.show_line_diagnostics()
	end, opts)

	vim.keymap.set("i", "<C-,>", function()
		vim.lsp.buf.signature_help()
	end, opts)

	vim.keymap.set("n", "<leader>iw", function()
		vim.lsp.buf.format({ async = true })
	end, opts)

	-- make sure it works
	vim.keymap.set("i", "<C-h>", "<Left>", opts)
end)

require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = {
		-- RUST
		"rust_analyzer",

		-- LUA
		"lua_ls",

		-- WEBDEV
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

-- Might be too much, especialy if only using for hover docs...
--[[ lspconfig.ltex.setup({
	on_attach = function() -- if client is not defined here you get 'Error catching ltex client'
		local ok, ltex_extra = pcall(require, "ltex_extra") -- protected call in case ltex_extra is not installed
		if not ok then
			return
		end

		ltex_extra.setup({
			load_langs = { "en-US" },
			init_check = true, -- You need this one set to true
			path = vim.fn.expand("~"),
			log_level = "none",
		})
	end,
}) ]]

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
-- vim.g.PREVENT_CLASH_TS_VUE = "false"

lspconfig.volar.setup({
	-- lowPowerMode = true,
	root_dir = lspconfig.util.root_pattern("*.vue"),
	-- enable TS and JS for takeover mode
	filetypes = { "typescript", "vue", "javascript" },
	-- cmd = {
	-- 	"node",
	-- 	"--max-old-space-size=4096",
	-- 	"/Users/louis.andrew/.local/share/nvim/mason/packages/vue-language-server/node_modules/@vue/language-server/out/index.js",
	-- 	"--stdio",
	-- },
	-- Takeover mode, prevent clashes
	on_attach = function()
		local active_clients = vim.lsp.get_active_clients()
		-- Prevent clashes with tsserver
		for _, client in pairs(active_clients) do
			-- stop tsserver if denols is already active -> laggy
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

lspconfig.tsserver.setup({
	filetypes = { "typescript", "vue", "typescriptreact", "javascript" },
	on_attach = function(ts_client)
		-- Set volar as prio when vue files exists
		local active_clients = vim.lsp.get_active_clients()
		for _, client in pairs(active_clients) do
			-- stop tsserver if denols is already active
			if vim.g.PREVENT_CLASH_TS_VUE == "true" and client.name == "volar" then
				ts_client.stop()
			end
		end
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
		border = "rounded",
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
})
