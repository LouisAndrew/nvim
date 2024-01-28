local colors = require("colors")
return {
	"mvllow/modes.nvim",
	tag = "v0.2.0",
	config = function()
		require("modes").setup({
			colors = {
				visual = colors.palette.indigo_fg,
			},
		})
	end,
}
