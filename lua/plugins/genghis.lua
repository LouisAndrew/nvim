return {
	"chrisgrieser/nvim-genghis",
	event = "BufEnter",
	dependencies = { "stevearc/dressing.nvim" },
	config = function()
		local keymap = vim.keymap.set
		local genghis = require("genghis")

		keymap("n", "<leader>yp", genghis.copyFilepath)
		keymap("n", "<leader>yn", genghis.copyFilename)
		keymap("n", "<leader>cx", genghis.chmodx)
		keymap("n", "<leader>rf", genghis.renameFile)
		keymap("n", "<leader>mf", genghis.moveAndRenameFile)
		keymap("n", "<leader>nf", genghis.createNewFile)
		keymap("n", "<leader>yf", genghis.duplicateFile)
		keymap("n", "<leader>df", function()
			genghis.trashFile({ trashLocation = ".Trash" })
		end)

		keymap("x", "<leader>x", genghis.moveSelectionToNewFile)
	end,
}
