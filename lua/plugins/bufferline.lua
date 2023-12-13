return {
	"akinsho/bufferline.nvim",
	event = "BufEnter",
	config = function()
		local bufferline = require("bufferline")
		local colors = require("colors")

		bufferline.setup({
			options = {
				style_preset = bufferline.style_preset.minimal,
				color_icons = false,
				show_buffer_close_icons = false,
				show_close_icon = false,
				diagnostics = "nvim_lsp",
			},
			highlights = {
				fill = {
					fg = colors.debug,
					bold = false,
				},
				background = {
					fg = colors.white_softened,
				},
				buffer_selected = {
					fg = colors.white,
					bg = nil,
					bold = false,
					italic = false,
				},
				buffer_visible = {
					fg = colors.dimmed_white,
					bg = nil,
					bold = false,
					italic = false,
				},

				diagnostic = {
					fg = nil,
				},
				error = {
					fg = colors.palette.remove_fg,
					italic = true,
				},
				error_visible = {
					fg = colors.palette.remove_fg,
					bg = nil,
					bold = false,
					italic = true,
				},
				error_selected = {
					fg = colors.misc.remove_fg,
					bg = nil,
					bold = false,
					italic = false,
				},

				warning = {
					fg = colors.palette.yellow_fg,
					italic = true,
				},
				warning_visible = {
					fg = colors.palette.yellow_fg,
					bold = false,
					italic = true,
				},
				warning_selected = {
					fg = colors.palette.yellow_fg,
					bold = false,
					italic = false,
				},
			},
		})
	end,
}
