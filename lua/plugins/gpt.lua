return {
	"jackMort/ChatGPT.nvim",
	lazy = true,
	keys = {
		{
			"<leader>ac",
			"<cmd>:ChatGPT<cr>",
			mode = { "n", "v" },
		},
		{
			"<leader>ar",
			":ChatGPTRun ",
			mode = { "n", "v" },
		},
	},
	config = function()
		require("chatgpt").setup()
	end,
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
	},
}
