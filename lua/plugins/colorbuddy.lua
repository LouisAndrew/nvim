return {
	"tjdevries/colorbuddy.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("theme").setup()
	end,
}
