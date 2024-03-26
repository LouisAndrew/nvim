return {
	"tjdevries/colorbuddy.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("colorbuddy").setup()
		require("theme").setup()
	end,
}
