return {
	{
		"github/copilot.vim",
		lazy = false,
	},
	{
		-- https://github.com/olimorris/codecompanion.nvim
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"hrsh7th/nvim-cmp", -- Optional: For using slash commands and variables in the chat buffer
			{
				"stevearc/dressing.nvim", -- Optional: Improves the default Neovim UI
				opts = {},
			},
			"nvim-telescope/telescope.nvim", -- Optional: For using slash commands
		},
		cmd = {
			"CodeCompanionChat",
			"CodeCompanionToggle",
			"CodeCompanionActions",
			"CodeCompanionAdd",
		},
		keys = {
			{ "<leader>ac", "<cmd>:CodeCompanionChat<CR>" },
			{ "<leader>aa", "<cmd>:CodeCompanionToggle<CR>" },
			{ "<leader>al", "<cmd>:CodeCompanion " },
			{ "<leader>ax", "<cmd>:CodeCompanionActions<CR>" },
			{ "<leader>an", "<cmd>:CodeCompanionAdd<CR>" },
		},
		config = true,
		opts = {
			strategies = {
				chat = {
					keymaps = {
						next_chat = {
							modes = {
								n = "]a",
							},
						},
						previous_chat = {
							modes = {
								n = "[a",
							},
						},
					},
				},
			},
		},
	},
}
