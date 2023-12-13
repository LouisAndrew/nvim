local null_ls = require("null-ls")

local file_exists = function(file)
	local f = io.open(file, "r")
	if f ~= nil then
		io.close(f)
		return true
	else
		return false
	end
end

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { { "eslint_d", "eslint" } },
		typescript = { { "eslint_d", "eslint" } },
		vue = { { "eslint_d", "eslint" } },
		rust = { "rustfmt" },
		go = { "gofmt" },
		-- markdown = { "deno_fmt" },
		json = { { "deno_fmt", "jq" } },
		-- md = { "deno_fmt" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
})

-- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md#formatting
null_ls.setup({
	sources = {
		-- ESLINT
		null_ls.builtins.diagnostics.eslint_d.with({
			condition = function(utils)
				local file_types = { "", ".js", ".cjs", ".yaml", ".yml", ".json" }
				for _, file_type in pairs(file_types) do
					if utils.root_has_file("/.eslintrc" .. file_type) then
						return true
					end
				end

				return false
			end,
		}),

		null_ls.builtins.code_actions.eslint_d.with({
			condition = function(utils)
				local file_types = { "", ".js", ".cjs", ".yaml", ".yml", ".json" }
				for _, file_type in pairs(file_types) do
					if utils.root_has_file("/.eslintrc" .. file_type) then
						return true
					end
				end

				return false
			end,
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
