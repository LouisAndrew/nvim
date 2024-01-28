return {
	"chrisgrieser/nvim-genghis",
	dependencies = {
		"stevearc/dressing.nvim",
		config = function()
			local special_chars = require("theme.special_chars")
			require("dressing").setup({
				input = {
					border = special_chars.create_special_border({
						side_padding = true,
						start_in_insert = false,
					}),
					win_options = {
						winhighlight = "NormalFloat:NoiceInputNormal",
					},
				},
				select = {
					telescope = {
						layout_strategy = "vertical",
						sorting_strategy = "ascending",
						layout_config = {
							vertical = {
								width = 0.5,
								height = 0.5,
								prompt_position = "top",
							},
							-- other layout configuration here
						},
						borderchars = {
							prompt = {
								special_chars.half_lower_block,
								special_chars.half_left_block,
								special_chars.half_upper_block,
								special_chars.half_right_block,
								special_chars.quadrant_lower_right,
								special_chars.quadrant_lower_left,
								special_chars.quadrant_upper_left,
								special_chars.quadrant_upper_right,
							},
							results = {
								special_chars.half_lower_block,
								special_chars.half_left_block,
								special_chars.half_upper_block,
								special_chars.half_right_block,
								special_chars.quadrant_lower_right,
								special_chars.quadrant_lower_left,
								special_chars.quadrant_upper_left,
								special_chars.quadrant_upper_right,
							},
						},
					},
				},
			})
		end,
	},
	config = function()
		local keymap = vim.keymap.set
		local genghis = require("genghis")

		keymap("n", "<leader>yp", genghis.copyFilepath)
		keymap("n", "<leader>yn", genghis.copyFilename)
		keymap("n", "<leader>yf", genghis.duplicateFile)

		keymap("n", "<leader>cx", genghis.chmodx)

		keymap("n", "<leader>rf", genghis.renameFile)
		keymap("n", "<leader>mf", genghis.moveAndRenameFile)
		keymap("n", "<leader>nf", genghis.createNewFile)

		keymap("n", "<leader>df", function()
			genghis.trashFile({ trashLocation = ".Trash" })
		end)

		keymap("x", "<leader>x", genghis.moveSelectionToNewFile)
	end,
}
