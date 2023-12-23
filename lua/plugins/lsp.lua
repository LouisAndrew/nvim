return {
	"VonHeikemen/lsp-zero.nvim",
	event = "BufEnter",
	branch = "v3.x",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		-- LSP Support
		"neovim/nvim-lspconfig",
		"github/copilot.vim",
		-- Autocompletion
		"nvimdev/lspsaga.nvim",
		"nvimtools/none-ls.nvim",
		{
			"ray-x/lsp_signature.nvim",
			config = function(_)
				require("lsp_signature").setup({
					hint_enable = false,
				})

				vim.keymap.set({ "i" }, "<c-b>", function()
					vim.lsp.buf.signature_help()
				end, { silent = true, noremap = true, desc = "toggle signature" })
			end,
		},
		{

			"stevearc/conform.nvim",
			dependencies = { "mason.nvim" },
			lazy = true,
		},
		{
			"hrsh7th/nvim-cmp",
			event = "InsertEnter",
			dependencies = {
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-nvim-lsp",
				-- Snippets: TBD, not sure what to do here
				"L3MON4D3/LuaSnip",
				"saadparwaiz1/cmp_luasnip",
			},
		},
		-- Debugging
		{
			"folke/trouble.nvim",
			lazy = true,
			keys = { { "<leader>id", "<cmd>:TroubleToggle<cr>" } },
			config = function()
				require("trouble").setup({ auto_preview = false })
			end,
		},
	},
	config = function()
		require("lsp")
	end,
}
