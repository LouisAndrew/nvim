local special_chars = require("theme.special_chars")
local keymaps = require("lsp.keymaps")

local lsp_zero = require("lsp-zero")
local lsputils = require("lspconfig.util")
local saga = require("lspsaga")
local utils = require("utils")

-- local VT_PREFIX = " "
local VT_PREFIX = "⏹ "
local navic = require("nvim-navic")
local util = require("lspconfig.util")

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

lsp_zero.on_attach(function(client, bufnr)
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
		volar = function()
			require("lspconfig").volar.setup({
				filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
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

lspconfig.volar.setup({
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
	on_attach = function()
		print("Volar attached")
	end,
})

local function get_typescript_server_path(root_dir)
	-- Highly dependent on nvm and node version
	local global_ts = "/Users/louis.andrew/Library/pnpm/global/5/node_modules/typescript/lib"
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

-- `pnpm add -g @vue/language-server`
-- local volar_cmd = { "vue-language-server", "--stdio" }

-- lspconfig.volar.setup({
-- 	-- cmd = volar_cmd,
-- 	root_dir = util.root_pattern("*.vue"),
-- 	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
-- 	init_options = {
-- 		languageFeatures = {
-- 			implementation = true, -- new in @volar/vue-language-server v0.33
-- 			references = true,
-- 			definition = true,
-- 			typeDefinition = true,
-- 			callHierarchy = true,
-- 			hover = true,
-- 			rename = true,
-- 			renameFileRefactoring = true,
-- 			signatureHelp = true,
-- 			codeAction = true,
-- 			workspaceSymbol = true,
-- 			completion = {
-- 				defaultTagNameCase = "both",
-- 				defaultAttrNameCase = "kebabCase",
-- 				getDocumentNameCasesRequest = false,
-- 				getDocumentSelectionRequest = false,
-- 			},
-- 			documentHighlight = true,
-- 			documentLink = true,
-- 			codeLens = { showReferencesNotification = true },
-- 			-- not supported - https://github.com/neovim/neovim/pull/15723
-- 			semanticTokens = false,
-- 			diagnostics = true,
-- 			schemaRequestService = true,
-- 		},
-- 	},
-- 	on_new_config = function(new_config, new_root_dir)
-- 		local path = get_typescript_server_path(new_root_dir)
-- 		vim.g.TS_PATH = path
-- 		new_config.init_options.typescript.tsdk = path
-- 	end,
-- })

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

		navic.attach(ts_client, bufnr)
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
