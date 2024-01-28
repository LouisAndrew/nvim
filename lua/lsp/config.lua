local special_chars = require("theme.special_chars")
local keymaps = require("lsp.keymaps")

local lsp_zero = require("lsp-zero")
local lsputils = require("lspconfig.util")
local saga = require("lspsaga")
local utils = require("utils")

-- local VT_PREFIX = " "
local VT_PREFIX = "⏹ "
local navic = require("nvim-navic")

local custom_navic_lsps = {
	"tsserver",
	"graphql",
}

vim.diagnostic.config({
	virtual_text = false,
	update_in_insert = false,
	underline = true,
	severity_sort = true,
	signs = false,
})

vim.diagnostic.config({
	virtual_lines = { only_current_line = true },
	virtual_text = false,
	signs = false,
	severity_sort = true,
	update_in_insert = false,
	underline = true,
})

-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
-- 	underline = true,
-- 	virtual_text = false,
-- 	update_in_insert = false,
-- 	virtual_lines = { only_current_line = true },
-- })

local function remove_duplicates(client)
	local active_clients = vim.lsp.get_active_clients()

	for _, act_client in pairs(active_clients) do
		if client.name == act_client.name and client.id ~= act_client.id then
			act_client.stop()
			break
		end
	end

	-- Prevent more than one LSP instance attached (e.g. neogit)
	-- if is_duplicated then
	-- 	client.stop()
	-- end
end

lsp_zero.on_attach(function(client, bufnr)
	-- remove_duplicates(client)

	if client.server_capabilities["documentSymbolProvider"] then
		if utils.has_value(custom_navic_lsps, client.name) ~= true then
			navic.attach(client, bufnr)
		end
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

-- Take a look, cos it's a bit complex
require("lsp.vue")

local vue_project = true
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

		-- navic.attach(ts_client, bufnr)
	end,
})

local saga_keys = {
	edit = "<cr>",
	vsplit = "<C-l>",
	split = "<C-j>",
	quit = "<C-c>",
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
		border = special_chars.create_special_border({
			side_padding = true,
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
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}
local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
for _, ls in ipairs(language_servers) do
	require("lspconfig")[ls].setup({
		capabilities = capabilities,
		-- you can add other fields for setting up lsp server in this table
	})
end
require("ufo").setup()
