return {
	{
		"stevearc/oil.nvim",
		keys = {
			{ "-", "<cmd>:Oil<cr>" },
		},
		config = function()
			local oil = require("oil")
			oil.setup({
				view_options = {},
				keymaps = {
					["g?"] = "actions.show_help",
					["<CR>"] = "actions.select",
					["<C-l>"] = {
						"actions.select",
						opts = { vertical = true },
						desc = "Open the entry in a vertical split",
					},
					["<C-j>"] = {
						"actions.select",
						opts = { horizontal = true },
						desc = "Open the entry in a horizontal split",
					},
					["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },
					["<C-p>"] = "actions.preview",
					["<C-c>"] = "actions.close",
					["<C-r>"] = "actions.refresh",
					["="] = "actions.parent",
					["+"] = "actions.open_cwd",
					["`"] = "actions.cd",
					["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory" },
					["gs"] = "actions.change_sort",
					["gx"] = "actions.open_external",
					["g."] = "actions.toggle_hidden",
					["g\\"] = "actions.toggle_trash",
				},
			})
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		keys = {
			{ "<leader>ee", "<cmd>:NvimTreeToggle<cr>" },
		},
		config = function()
			local icons = require("theme.icons")
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
	},
}
