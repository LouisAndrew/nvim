local icons = require("theme.icons")
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
			"stevearc/conform.nvim",
			dependencies = { "mason.nvim" },
			lazy = true,
		},
		{
			"hrsh7th/nvim-cmp",
			event = "InsertEnter",
			dependencies = {
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-cmdline",
				"hrsh7th/cmp-buffer",
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
		{
			"SmiteshP/nvim-navic",
			config = function()
				require("nvim-navic").setup({
					icons = icons,
					depth_limit = 8,
					highlight = true,
				})
			end,
		},
	},
	config = function()
		require("lsp")
	end,
}
