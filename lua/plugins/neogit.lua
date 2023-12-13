return {
	"NeogitOrg/neogit",
	lazy = true,
	keys = { { "<leader>gd", "<cmd>:DiffviewOpen<cr>" } },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		"sindrets/diffview.nvim",
		{
			"lewis6991/gitsigns.nvim",
			config = function()
				require("gitsigns").setup()
			end,
		},
	},
	config = function()
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
