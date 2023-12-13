local lsp_zero = require("lsp-zero")
local saga = require("lspsaga")

lsp_zero.on_attach(function(_, bufnr)
	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set("n", "<leader>iO", function()
		vim.lsp.buf.definition()
	end, opts)

	vim.keymap.set("n", "<leader>ii", "<cmd>Lspsaga hover_doc<CR>", opts)

	vim.keymap.set("n", "<leader>io", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window

	vim.keymap.set("n", "<leader>if", "<cmd>Lspsaga finder<CR>", opts) -- show definition, references
	vim.keymap.set("n", "<leader>is", function()
		vim.lsp.buf.workspace_symbol()
	end, opts)

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

	vim.keymap.set("i", "<C-u>", function()
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

lspconfig.grammarly.setup({
	filetypes = { "markdown", "md" },
})

lspconfig.tailwindcss.setup({
	root_dir = lspconfig.util.root_pattern("tailwind.config.js", "tailwind.config.cjs", "tailwind.config.ts"),
	filetypes = { "html", "css", "scss", "typescriptreact", "svelte", "vue", "javascriptreact" },
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

local PREVENT_CLASH_TS_VUE = true

lspconfig.volar.setup({
	root_dir = lspconfig.util.root_pattern("*.vue"),
	filetypes = { "typescript", "javascript", "vue", "json" },
	-- Takeover mode, prevent clashes
	on_attach = function(volar_client)
		-- Prevent clashes with tsserver
		local is_volar_attached = false
		local active_clients = vim.lsp.get_active_clients()

		for _, client in pairs(active_clients) do
			if client.name == "volar" and client.id ~= volar_client.id then
				is_volar_attached = true
				break
			end
			-- stop tsserver if denols is already active -> laggy
			if PREVENT_CLASH_TS_VUE and client.name == "tsserver" then
				client.stop()
			end
		end

		-- Prevent more than one volar instance attached (e.g. neogit)
		if is_volar_attached then
			volar_client.stop()
		end
	end,
	on_new_config = function(new_config, new_root_dir)
		new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
	end,
})

lspconfig.tsserver.setup({
	filetypes = { "typescript", "vue", "typescriptreact", "javascript" },
	on_attach = function(ts_client)
		-- Set volar as prio when vue files exists
		local active_clients = vim.lsp.get_active_clients()
		for _, client in pairs(active_clients) do
			-- stop tsserver if denols is already active
			if PREVENT_CLASH_TS_VUE and client.name == "volar" then
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
	ui = {
		border = "rounded",
		code_action = " ",
	},
	symbol_in_winbar = {
		enable = false,
		show_file = false,
	},
})