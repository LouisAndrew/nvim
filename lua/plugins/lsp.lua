local icons = require("theme.icons")
return {
	"VonHeikemen/lsp-zero.nvim",
	-- event = "BufEnter",
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
			"zeioth/garbage-day.nvim",
			event = "VeryLazy",
			opts = {},
		},
		-- {
		-- 	"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		-- 	config = function()
		-- 		require("lsp_lines").setup()
		-- 	end,
		-- },
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
		-- Disabling for now, seeing a performance issue
		{
			"SmiteshP/nvim-navic",
			config = function()
				require("nvim-navic").setup({
					icons = icons,
					depth_limit = 4,
					highlight = true,
					---@param text string
					format_text = function(text)
						return text:gsub("callback", "cb")
					end,
					lsp = {
						preference = { "volar" },
					},
				})
			end,
		},
		{
			"kevinhwang91/nvim-ufo",
			dependencies = {
				"kevinhwang91/promise-async",
				{
					"chrisgrieser/nvim-origami",
					event = "BufReadPost", -- later or on keypress would prevent saving folds
					config = function()
						require("origami").setup({
							keepFoldsAcrossSessions = true,
							pauseFoldsOnSearch = true,
							setupFoldKeymaps = false,
						})
					end,
				},
			},
		},
		{
			"dgagn/diagflow.nvim",
			event = "LspAttach",
			opts = {
				format = function(diag)
					local source = diag.source
					local msg = diag.message
					return string.format("(%s) %s", source, msg)
				end,
				toggle_event = { "InsertEnter", "InsertLeave" },
				update_event = { "DiagnosticChanged", "BufReadPost" },
				max_width = 32, -- The maximum width of the diagnostic messages
				gap_size = 0,
				padding_top = -1,
				scope = "line",
				inline_padding_left = 2,
				text_align = "right",
				show_sign = false,
				placement = "inline",
			},
		},
		{
			"b0o/SchemaStore.nvim",
		},
		{
			"pmizio/typescript-tools.nvim",
		},
	},
	config = function()
		require("lsp")
	end,
}
