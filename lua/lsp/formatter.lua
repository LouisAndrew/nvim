local null_ls = require("null-ls")
local conform = require("conform")

local file_exists = function(file)
	local f = io.open(file, "r")
	if f ~= nil then
		io.close(f)
		return true
	else
		return false
	end
end

-- Use conform for formatting
conform.setup({
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "eslint_d" },
		typescript = { "eslint_d" },
		typescriptreact = { "eslint_d" },
		vue = { "eslint_d" },
		rust = { "rust_analyzer" },
		go = { "gofmt" },
		-- markdown = { "markdownlint" },
		json = { "jq" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
})

local check_project_eslint = function(utils)
	local file_types = { "", ".js", ".cjs", ".yaml", ".yml", ".json" }
	for _, file_type in pairs(file_types) do
		if utils.root_has_file("/.eslintrc" .. file_type) then
			return true
		end
	end

	return false
end

-- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md#formatting
-- Ideally only for diagnostics and code actions
null_ls.setup({
	sources = {
		-- ESLINT
		null_ls.builtins.diagnostics.eslint_d.with({
			condition = check_project_eslint,
		}),

		null_ls.builtins.code_actions.eslint_d.with({
			condition = check_project_eslint,
		}),

		-- MARKDOWN
		null_ls.builtins.diagnostics.markdownlint,

		null_ls.builtins.formatting.deno_fmt.with({
			filetypes = { "markdown" },
		}),

		-- JSON
		null_ls.builtins.diagnostics.spectral,

		-- GO
		null_ls.builtins.diagnostics.staticcheck,
	},
})
