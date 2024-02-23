return {
	"NeogitOrg/neogit",
	lazy = false,
	keys = { { "<leader>gd", "<cmd>:DiffviewOpen<cr>" }, { "<leader>go", "<cmd>:DiffviewOpen<cr>" } },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		"sindrets/diffview.nvim",
	},
	config = function()
		local icons = require("theme.icons")
		require("diffview").setup({
			icons = { -- Only applies when use_icons is true.
				folder_closed = icons.FolderClosed,
				folder_open = icons.FolderOpened,
			},
			signs = {
				fold_closed = icons.ArrowClosed,
				fold_open = icons.ArrowOpened,
				done = "✓",
			},
		})

		local neogit = require("neogit")
		neogit.setup({
			integrations = {
				telescope = true,
				diffview = true,
			},
			mappings = {
				popup = {
					["?"] = "HelpPopup",
					["A"] = "CherryPickPopup",
					["D"] = "DiffPopup",
					["M"] = "RemotePopup",
					["P"] = "PushPopup",
					["X"] = "ResetPopup",
					["Z"] = "StashPopup",
					["b"] = "BranchPopup",
					["c"] = "CommitPopup",
					["f"] = "FetchPopup",
					["l"] = "LogPopup",
					["m"] = "MergePopup",
					["p"] = "PullPopup",
					["r"] = "RebasePopup",
					["v"] = "RevertPopup",
				},
			},
		})
	end,
}
