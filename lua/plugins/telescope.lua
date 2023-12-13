return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.4",
	dependencies = {
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
		"nvim-lua/plenary.nvim",
		"debugloop/telescope-undo.nvim",
		"nvim-telescope/telescope-file-browser.nvim",
		"fdschmidt93/telescope-egrepify.nvim",
		"AckslD/nvim-neoclip.lua",
	},
	config = function()
		local icons = require("nvim-nonicons")
		local builtin = require("telescope.builtin")
		local telescope = require("telescope")
		local config = require("telescope.config")

		local actions = require("telescope.actions")
		local fb_actions = telescope.extensions.file_browser.actions

		require("neoclip").setup()

		local default_maps = {
			i = {
				["<C-l>"] = actions.file_vsplit,
				["<C-j>"] = actions.file_split,
			},
		}

		---@diagnostic disable-next-line: deprecated
		local vimgrep_arguments = { unpack(config.values.vimgrep_arguments) }

		-- I want to search in hidden/dot files.
		table.insert(vimgrep_arguments, "--hidden")
		-- I don't want to search in the `.git` directory.
		table.insert(vimgrep_arguments, "--glob")
		table.insert(vimgrep_arguments, "!**/.git/*")

		telescope.setup({
			defaults = {
				prompt_prefix = "" .. icons.get("telescope") .. "  ",
				selection_caret = " ❯ ",
				entry_prefix = "   ",
				layout_config = {
					horizontal = {
						width_padding = 0.1,
						height_padding = 0.1,
						preview_width = 0.6,
						width = 0.9,
					},
				},
				vimgrep_arguments = vimgrep_arguments,
				mappings = default_maps,
			},
			pickers = {
				find_files = {
					mappings = default_maps,
					find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
				},
				buffers = {
					mappings = default_maps,
				},
				live_grep = {
					mappings = default_maps,
					find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
				},
			},
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
				file_browser = {
					hijack_netrw = true,
					respect_gitignore = true,
					mappings = {
						["i"] = {
							["<C-l>"] = actions.file_vsplit,
							["<C-j>"] = actions.file_split,
							["<C-h>"] = fb_actions.goto_cwd,
							["<C-c>"] = fb_actions.create,
							["<C-r>"] = fb_actions.rename,
							["<C-d>"] = fb_actions.remove,
							["<C-t>"] = actions.file_tab,
							["<C-x>"] = function(prompt_bufnr)
								fb_actions.toggle_hidden(prompt_bufnr)
								fb_actions.toggle_respect_gitignore(prompt_bufnr)
							end,
						},
					},
				},
				undo = {
					side_by_side = true,
				},
			},
		})

		telescope.load_extension("file_browser")
		telescope.load_extension("fzf")
		telescope.load_extension("egrepify")
		telescope.load_extension("undo")

		vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
		vim.keymap.set("n", "<leader>po", builtin.buffers, {})
		-- vim.keymap.set("n", "<leader>pc", builtin.grep_string, {})
		vim.keymap.set("n", "<leader>ps", telescope.extensions.egrepify.egrepify, {})
		vim.keymap.set("n", "<leader>ph", builtin.help_tags, {})
		vim.keymap.set("n", "<leader>py", telescope.extensions.neoclip.default, {})
		vim.keymap.set("n", "<leader>pu", telescope.extensions.undo.undo, {})
		vim.keymap.set("n", "<leader>pe", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", {})
	end,
}
