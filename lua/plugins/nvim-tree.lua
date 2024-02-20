local icons = require("theme.icons")
return {
	"nvim-tree/nvim-tree.lua",
	keys = {
		{ "<leader>ee", "<cmd>:NvimTreeToggle<cr>" },
	},
	event = "VeryLazy",
	config = function()
		require("nvim-tree").setup({
			renderer = {
				icons = {
					glyphs = {
						folder = {
							default = icons.FolderClosed,
							open = icons.FolderOpened,
							arrow_closed = icons.ArrowClosed,
							arrow_open = icons.ArrowClosed,
							empty = "",
							empty_open = "",
							symlink = "",
						},
					},
					web_devicons = {
						file = {
							color = false,
						},
						folder = {
							enable = false,
							color = false,
						},
					},
				},
			},
		})
	end,
}
