return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = "VeryLazy",
	dependencies = {
		"nvim-treesitter/playground",
		"nvim-treesitter/nvim-treesitter-textobjects",
		-- "nvim-treesitter/nvim-treesitter-context",
		"danymat/neogen",
		"windwp/nvim-ts-autotag",
		{ "echasnovski/mini.ai", version = "*" },
		{ "echasnovski/mini.pairs", branch = "stable" },
		{
			"RRethy/vim-illuminate",
			config = function()
				require("illuminate").configure({
					min_count_to_highlight = 2,
					delay = 200,
					filetypes_denylist = {
						"dirbuf",
						"dirvish",
						"NvimTree",
						"DiffviewFiles",
						"DiffviewFileHistory",
						"qf",
					},
				})
			end,
		},
	},
	config = function()
		local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"javascript",
				"typescript",
				"vue",
				"lua",
				"vim",
				"vimdoc",
				"html",
				"css",
				"graphql",
				"markdown",
				"markdown_inline",
			},
			sync_install = false,
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			autotag = {
				enable = true,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-t>",
					node_incremental = "<C-n>",
					scope_incremental = false,
					node_decremental = "<C-p>",
				},
			},
			playground = {
				enable = true,
			},
		})

		vim.keymap.set({ "n", "x", "o" }, "<C-s>", ts_repeat_move.repeat_last_move_next)
		vim.keymap.set({ "n", "x", "o" }, "<C-a>", ts_repeat_move.repeat_last_move_previous)
		vim.keymap.set("n", "<leader>ih", "<cmd>:TSHighlightCapturesUnderCursor<cr>")
		vim.keymap.set("n", "<leader>ic", "<cmd>:TSCaptureUnderCursor<cr>")

		local ai = require("mini.ai")
		ai.setup({
			n_lines = 500,
			mappings = {
				goto_left = "[",
				goto_right = "]",
				-- `val=` -> goes to `local ->ai`
			},
			custom_textobjects = {
				o = ai.gen_spec.treesitter({
					a = { "@block.outer", "@conditional.outer", "@loop.outer" },
					i = { "@block.inner", "@conditional.inner", "@loop.inner" },
				}, {}),

				["="] = ai.gen_spec.treesitter({
					a = { "@assignment.lhs" },
					i = { "@assignment.rhs" },
				}),
				a = ai.gen_spec.argument({ brackets = { "%b()" } }),

				f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
				c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
				-- @TODO find out more use cases
				t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
				-- <html></html>

				x = ai.gen_spec.treesitter({
					a = { "@call.outer" },
					i = { "@call.inner" },
				}, {}),
			},
			search_method = "cover_or_next",
		})

		require("neogen").setup()
		vim.keymap.set("n", "<leader>tc", require("neogen").generate)

		local pairs = require("mini.pairs")
		pairs.setup()
	end,
}
