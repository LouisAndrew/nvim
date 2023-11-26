local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local lsp_zero = require("lsp-zero")
-- local ft = require("guard.filetype")
local saga = require("lspsaga")

lsp_zero.on_attach(function(client, bufnr)
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

	vim.keymap.set({ "n", "i" }, "<C-s>", function()
		vim.lsp.buf.format({ async = true })
	end, opts)

	-- make sure it works
	vim.keymap.set("i", "<C-h>", "<Left>", opts)

	-- Format on save
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
				-- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
				vim.lsp.buf.format({ async = false })
			end,
		})
	end
end)

require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = { "tsserver", "rust_analyzer", "volar", "tailwindcss", "cssls", "html", "lua_ls" },
	handlers = {
		lsp_zero.default_setup,
		lua_ls = function()
			local lua_opts = lsp_zero.nvim_lua_ls()
			require("lspconfig").lua_ls.setup(lua_opts)
		end,
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

require("lspconfig").graphql.setup({
	filetypes = { "graphql", "javascript", "typescript", "typescriptreact" },
})

require("lspconfig").grammarly.setup({
	filetypes = { "markdown", "md" },
})

require("lspconfig").lua_ls.setup({
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
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
		keys = saga_keys,
	},
	ui = {
		colors = {
			normal_bg = "#022746",
		},
	},
	symbol_in_winbar = {
		enable = false,
		show_file = false,
	},
})

local null_ls = require("null-ls")

-- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md#formatting
null_ls.setup({
	sources = {
		-- ESLINT
		null_ls.builtins.diagnostics.eslint_d,
		null_ls.builtins.formatting.eslint_d,
		null_ls.builtins.code_actions.eslint_d,

		-- RUST
		null_ls.builtins.formatting.rustfmt,

		-- LUA
		null_ls.builtins.diagnostics.luacheck,
		null_ls.builtins.formatting.stylua,

		-- MARKDOWN
		null_ls.builtins.diagnostics.markdownlint,

		-- JSON
		null_ls.builtins.diagnostics.spectral,
		null_ls.builtins.formatting.deno_fmt.with({
			filetypes = { "markdown", "json" }, -- only runs `deno fmt` for markdown
		}),

		-- GO
		null_ls.builtins.formatting.gofmt,
		null_ls.builtins.diagnostics.staticcheck,

		--[[ null_ls.builtins.formatting.prettier.with({
			filetypes = { "json" },
		}), ]]
	},
})

vim.keymap.set({ "n", "t" }, "<M-p>", "<cmd>Lspsaga term_toggle<cr>")
