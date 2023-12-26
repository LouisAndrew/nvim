return {
	"gelguy/wilder.nvim",
	event = "CmdlineEnter",
	config = function()
		local wilder = require("wilder")

		wilder.set_option(
			"renderer",
			wilder.popupmenu_renderer({
				highlights = {
					border = "paletteborder",
					accent = "wildermatch",
				},
				highlighter = wilder.basic_highlighter(),
				border = "rounded",
			})
		)

		wilder.setup({ modes = { ":", "/" } })
	end,
}
