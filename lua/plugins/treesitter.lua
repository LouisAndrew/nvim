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
				})
			end,
		},

		-- {
		-- 	"kevinhwang91/nvim-ufo",
		-- 	dependencies = {
		-- 		"kevinhwang91/promise-async",
		-- 		{
		-- 			"chrisgrieser/nvim-origami",
		-- 			event = "BufReadPost", -- later or on keypress would prevent saving folds
		-- 			config = function()
		-- 				require("origami").setup({
		-- 					keepFoldsAcrossSessions = true,
		-- 					pauseFoldsOnSearch = true,
		-- 					setupFoldKeymaps = false,
		-- 				})
		-- 			end,
		-- 		},
		-- 	},
		-- 	config = function()
		-- 		vim.o.foldcolumn = "0" -- '0' is not bad
		-- 		vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
		-- 		vim.o.foldlevelstart = 99
		-- 		vim.o.foldenable = true
		-- 		vim.keymap.set("n", "zR", require("ufo").openAllFolds)
		-- 		vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
		--
		-- 		-- require("ufo").setup({
		-- 		-- 	provider_selector = function(bufnr, filetype, buftype)
		-- 		-- 		return { "treesitter", "indent" }
		-- 		-- 	end,
		-- 		-- })
		-- 	end,
		-- },
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

			--[[ textobjects = {
				select = {
					enable = true,

					-- Automatically jump forward to textobj, similar to targets.vim
					lookahead = true,

					keymaps = {
						["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
						["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
						["l="] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
						["r="] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },

						["a:"] = { query = "@property.outer", desc = "Select outer part of an object property" },
						["i:"] = { query = "@property.inner", desc = "Select inner part of an object property" },
						["l:"] = { query = "@property.lhs", desc = "Select left part of an object property" },
						["r:"] = { query = "@property.rhs", desc = "Select right part of an object property" },

						["aa"] = "@parameter.outer",
						["ia"] = "@parameter.inner",
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
						["ii"] = "@conditional.inner",
						["ai"] = "@conditional.outer",
						["il"] = "@loop.inner",
						["al"] = "@loop.outer",
						["at"] = "@comment.outer",
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["<leader>na"] = "@parameter.inner", -- swap parameters/argument with next
						["<leader>n:"] = "@property.outer", -- swap object property with next
						["<leader>nm"] = "@function.outer", -- swap function with next
					},
					swap_previous = {
						["<leader>pa"] = "@parameter.inner", -- swap parameters/argument with prev
						["<leader>p:"] = "@property.outer", -- swap object property with prev
						["<leader>pm"] = "@function.outer", -- swap function with previous
					},
				},
				move = {
					enable = true,
					set_jumps = true, -- whether to set jumps in the jumplist
					goto_next_start = {
						["]f"] = { query = "@call.outer", desc = "Next function call start" },
						["]q"] = { query = "@function.outer", desc = "Next method/function def start" },
						["]c"] = { query = "@class.outer", desc = "Next class start" },
						["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
						["]l"] = { query = "@loop.outer", desc = "Next loop start" },

						-- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
						-- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
						["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
						["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
						["]a"] = { query = "@paramater", query_group = "folds", desc = "Next parameter" },
					},
					goto_next_end = {
						["]F"] = { query = "@call.outer", desc = "Next function call end" },
						["]Q"] = { query = "@function.outer", desc = "Next method/function def end" },
						["]C"] = { query = "@class.outer", desc = "Next class end" },
						["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
						["]L"] = { query = "@loop.outer", desc = "Next loop end" },
					},
					goto_previous_start = {
						["[f"] = { query = "@call.outer", desc = "Prev function call start" },
						["[q"] = { query = "@function.outer", desc = "Prev method/function def start" },
						["[c"] = { query = "@class.outer", desc = "Prev class start" },
						["[i"] = { query = "@conditional.outer", desc = "Prev conditional start" },

						["[l"] = { query = "@loop.outer", desc = "Prev loop start" },
						["[s"] = { query = "@scope", query_group = "locals", desc = "Prev scope" },
						["[z"] = { query = "@fold", query_group = "folds", desc = "Prev fold" },
						["[a"] = { query = "@paramater", query_group = "folds", desc = "Prev parameter" },
					},
					goto_previous_end = {
						["[F"] = { query = "@call.outer", desc = "Prev function call end" },
						["[Q"] = { query = "@function.outer", desc = "Prev method/function def end" },
						["[C"] = { query = "@class.outer", desc = "Prev class end" },
						["[I"] = { query = "@conditional.outer", desc = "Prev conditional end" },
						["[L"] = { query = "@loop.outer", desc = "Prev loop end" },
					},
				},
			}, ]]
		})

		vim.keymap.set({ "n", "x", "o" }, "<C-s>", ts_repeat_move.repeat_last_move_next)
		vim.keymap.set({ "n", "x", "o" }, "<C-a>", ts_repeat_move.repeat_last_move_previous)
		vim.keymap.set("n", "<leader>ih", "<cmd>:TSHighlightCapturesUnderCursor<cr>")
		vim.keymap.set("n", "<leader>ic", "<cmd>:TSCaptureUnderCursor<cr>")
		-- vim.keymap.set("n", "[c", function()
		-- 	require("treesitter-context").go_to_context(vim.v.count1)
		-- end, { silent = true })

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

				f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
				c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
				t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },

				x = ai.gen_spec.treesitter({
					a = { "@call.outer" },
					i = { "@call.inner" },
				}, {}),
			},
			search_method = "cover_or_next",
		})

		require("neogen").setup()
		vim.keymap.set("n", "<leader>tc", require("neogen").generate)

		-- require("treesitter-context").setup({
		-- 	enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
		-- 	max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
		-- 	min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
		-- 	line_numbers = true,
		-- 	multiline_threshold = 20, -- Maximum number of lines to show for a single context
		-- 	trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
		-- 	mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
		-- 	-- Separator between context and content. Should be a single character string, like '-'.
		-- 	-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
		-- 	separator = nil,
		-- 	zindex = 20, -- The Z-index of the context window
		-- 	on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
		-- })

		local pairs = require("mini.pairs")
		pairs.setup()
	end,
}
