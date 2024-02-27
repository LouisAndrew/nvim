return {
	"lewis6991/gitsigns.nvim",
	config = function()
		require("gitsigns").setup({
			current_line_blame = false,
			signs = {
				add = { text = "|" },
				change = { text = "|" },
				delete = { text = "-" },
				topdelete = { text = "-" },
				changedelete = { text = "~" },
				untracked = { text = "|" },
			},
		})
	end,
}
