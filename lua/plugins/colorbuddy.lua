return {
	"tjdevries/colorbuddy.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		-- vim.cmd.colorscheme("minimal_fedu")
		require("theme").setup()
	end,
}
