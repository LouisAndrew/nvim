local null_ls = require("null-ls")

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { { "eslint_d", "eslint" } },
		typescript = { { "eslint_d", "eslint" } },
		vue = { { "eslint_d", "eslint" } },
		rust = { "rustfmt" },
		go = { "gofmt" },
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
		null_ls.builtins.diagnostics.eslint_d,
		null_ls.builtins.code_actions.eslint_d,

		-- MARKDOWN
		null_ls.builtins.diagnostics.markdownlint,

		-- JSON
		null_ls.builtins.diagnostics.spectral,

		-- GO
		null_ls.builtins.diagnostics.staticcheck,

		-- For stuff that are not supported by conform
		null_ls.builtins.formatting.deno_fmt.with({
			filetypes = { "markdown", "json" }, -- only runs `deno fmt` for markdown
		}),
	},
})
