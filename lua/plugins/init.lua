return {
	"yamatsum/nvim-nonicons",
	dependencies = { "kyazdani42/nvim-web-devicons" },
	priority = 999,
	config = function()
		require("nvim-nonicons").setup({})
	end,
}
