return {
	"jackMort/ChatGPT.nvim",
	lazy = true,
	keys = {
		{
			"<leader>cc",
			"<cmd>:ChatGPT<cr>",
		},
		{
			"<leader>cr",
			":ChatGPTRun ",
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
