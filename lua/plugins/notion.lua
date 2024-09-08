return {
	"Al0den/notion.nvim",
	lazy = true,
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim",
	},
	keys = {
		{ "<leader>no", "<cmd>:lua require('notion').openMenu()<cr>" },
		{ "<leader>nr", "<cmd>:lua print(require('notion').raw())<cr>" },
	},
	config = function()
		require("notion").setup({
			editor = "medium",
			viewOnEdit = {
				enabled = true,
				replace = true,
			},
		})
	end,
}
