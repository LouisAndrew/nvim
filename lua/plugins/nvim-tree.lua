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
							default = "",
							open = "",
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
