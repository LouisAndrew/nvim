return {
	generate_keymaps = function(bufnr)
		local opts = { buffer = bufnr, remap = false }

		vim.keymap.set("n", "<leader>iO", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "<leader>ij", "<cmd>Lspsaga hover_doc<CR>", opts)
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
		vim.keymap.set("n", "[e", function()
			require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
		end)
		vim.keymap.set("n", "]e", function()
			require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
		end)
		vim.keymap.set("n", "<leader>ia", "<cmd>Lspsaga code_action<CR>", opts)
		vim.keymap.set("n", "<leader>ir", "<cmd>Telescope lsp_references<cr>", opts)
		vim.keymap.set("n", "<leader>in", "<cmd>Lspsaga rename<CR>", opts) -- smart rename

		vim.keymap.set("n", "<leader>rr", "<cmd>LspRestart<CR>", opts) -- smart rename

		vim.keymap.set("n", "<leader>ie", function()
			vim.lsp.diagnostic.get_line_diagnostics()
		end, opts)
		vim.keymap.set("n", "<leader>iw", function()
			vim.lsp.buf.format({ async = true })
		end, opts)

		-- make sure it works
		vim.keymap.set("i", "<C-h>", "<Left>", opts)
	end,
}
