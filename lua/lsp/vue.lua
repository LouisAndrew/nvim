vim.g.PREVENT_CLASH_TS_VUE = "true"
local util = require("lspconfig.util")
local lspconfig = require("lspconfig")

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
local volar_cmd = { "vue-language-server", "--stdio" }

lspconfig.volar.setup({
	cmd = volar_cmd,
	root_dir = util.root_pattern("*.vue"),
	filetypes = { "typescript", "vue", "javascript" },
	init_options = {
		languageFeatures = {
			implementation = true, -- new in @volar/vue-language-server v0.33
			references = true,
			definition = true,
			typeDefinition = true,
			callHierarchy = true,
			hover = true,
			rename = true,
			renameFileRefactoring = true,
			signatureHelp = true,
			codeAction = true,
			workspaceSymbol = true,
			completion = {
				defaultTagNameCase = "both",
				defaultAttrNameCase = "kebabCase",
				getDocumentNameCasesRequest = false,
				getDocumentSelectionRequest = false,
			},
			documentHighlight = true,
			documentLink = true,
			codeLens = { showReferencesNotification = true },
			-- not supported - https://github.com/neovim/neovim/pull/15723
			semanticTokens = false,
			diagnostics = true,
			schemaRequestService = true,
		},
	},
	on_new_config = function(new_config, new_root_dir)
		local path = get_typescript_server_path(new_root_dir)
		vim.g.TS_PATH = path
		new_config.init_options.typescript.tsdk = path
	end,
})
