return {
	"kylechui/nvim-surround",
	event = "BufEnter",
	config = function()
		require("nvim-surround").setup({})
	end,
}
