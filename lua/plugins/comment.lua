return {
	"echasnovski/mini.comment",
	dependencies = {
		{
			"JoosepAlviste/nvim-ts-context-commentstring",
			lazy = true,
			opts = {
				enable_autocmd = false,
			},
		},
	},
	event = "BufEnter",
	config = function()
		require("mini.comment").setup({
			mappings = {
				comment = "gy",
				comment_line = "gyy",
				comment_visual = "gy",
				textobject = "gy",
			},
			options = {
				custom_commentstring = function()
					return require("ts_context_commentstring.internal").calculate_commentstring()
						or vim.bo.commentstring
				end,
			},
		})
	end,
}
