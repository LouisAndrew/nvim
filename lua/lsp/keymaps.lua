local diag_float_config = {
	severity_sort = true,
	source = "if_many",
	prefix = " ",
	suffix = " ",
	header = "",
}

return {
	generate_keymaps = function(bufnr)
		local opts = { buffer = bufnr, remap = false }

		vim.keymap.set("n", "<leader>iO", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "<leader>ij", "<cmd>Lspsaga hover_doc<CR>", opts)
		vim.keymap.set("n", "<leader>ii", vim.lsp.buf.hover, opts)

		vim.keymap.set("n", "<leader>io", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
		vim.keymap.set("n", "<leader>if", function()
			local winid = require("ufo").peekFoldedLinesUnderCursor()
			if not winid then
				vim.lsp.buf.hover()
			end
		end, opts)

		vim.keymap.set("n", "<leader>is", vim.lsp.buf.workspace_symbol, opts)
		vim.keymap.set("n", "<leader>it", "<cmd>Lspsaga outline<CR>", opts)
		vim.keymap.set(
			"i",
			"<c-b>",
			vim.lsp.buf.signature_help,
			{ silent = true, noremap = true, desc = "toggle signature" }
		)
		vim.keymap.set("n", "<space>id", function()
			vim.diagnostic.open_float(diag_float_config)
		end, { noremap = true, silent = true })

		vim.keymap.set("n", "[d", function()
			vim.diagnostic.goto_prev({
				float = diag_float_config,
			})
		end, opts) -- jump to previous diagnostic in buffer
		vim.keymap.set("n", "]d", function()
			vim.diagnostic.goto_next({
				float = diag_float_config,
			})
		end, opts)

		vim.keymap.set("n", "[e", function()
			vim.diagnostic.goto_prev({
				float = diag_float_config,
				severity = vim.diagnostic.severity.ERROR,
			})
		end)
		vim.keymap.set("n", "]e", function()
			vim.diagnostic.goto_next({
				float = diag_float_config,
				severity = vim.diagnostic.severity.ERROR,
			})
		end)
		-- vim.keymap.set("n", "<leader>ia", "<cmd>Lspsaga code_action<CR>", opts)
		vim.keymap.set("n", "<leader>ia", vim.lsp.buf.code_action, opts)

		vim.keymap.set("n", "<leader>ip", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "<leader>ir", "<cmd>Telescope lsp_references<cr>", opts)
		vim.keymap.set("n", "<leader>in", vim.lsp.buf.rename, opts) -- smart rename

		vim.keymap.set("n", "<leader>rr", "<cmd>LspRestart<CR>", opts)
		vim.keymap.set("n", "<leader>iw", function()
			vim.lsp.buf.format({ async = true })
		end, opts)

		-- make sure it works
		vim.keymap.set("i", "<C-h>", "<Left>", opts)
	end,
}
