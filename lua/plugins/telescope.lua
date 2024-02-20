local special_chars = require("theme.special_chars")
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
				["<C-u>"] = actions.preview_scrolling_up,
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
				borderchars = {
					preview = {
						special_chars.half_lower_block,
						special_chars.full_block,
						special_chars.half_upper_block,
						special_chars.full_block,
						special_chars.half_lower_block,
						special_chars.half_lower_block,
						special_chars.half_upper_block,
						special_chars.half_upper_block,
					},
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
				path_display = {
					shorten = {
						len = 1,
						exclude = { -1, -2 },
					},
				},
				dynamic_preview_title = true,
				prompt_prefix = "   ",
				selection_caret = " > ",
				entry_prefix = "   ",
				layout_config = {
					horizontal = {
						width_padding = 1,
						height_padding = 1,
						preview_width = 0.6,
						width = 0.9,
					},
				},
				vimgrep_arguments = vimgrep_arguments,
				mappings = default_maps,
				color_devicons = false,

				preview = {
					mime_hook = function(filepath, bufnr, opts)
						local is_image = function(filepath)
							local image_extensions = { "png", "jpg" } -- Supported image formats
							local split_path = vim.split(filepath:lower(), ".", { plain = true })
							local extension = split_path[#split_path]
							return vim.tbl_contains(image_extensions, extension)
						end

						if is_image(filepath) then
							local term = vim.api.nvim_open_term(bufnr, {})
							local function send_output(_, data, _)
								for _, d in ipairs(data) do
									vim.api.nvim_chan_send(term, d .. "\r\n")
								end
							end

							-- still not working :((
							vim.fn.jobstart({
								"viu",
								filepath, -- Terminal image viewer command
							}, { on_stdout = send_output, stdout_buffered = true, pty = true })
						else
							require("telescope.previewers.utils").set_preview_message(
								bufnr,
								opts.winid,
								"Binary cannot be previewed"
							)
						end
					end,
				},
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
							["<C-u>"] = actions.preview_scrolling_up,
							["<C-d>"] = actions.preview_scrolling_down,
							["<C-l>"] = actions.file_vsplit,
							["<C-j>"] = actions.file_split,
							["<C-h>"] = fb_actions.goto_cwd,
							["<C-c>"] = fb_actions.create,
							["<C-r>"] = fb_actions.rename,
							["<C-q>"] = fb_actions.remove,
							["<C-t>"] = actions.file_tab,
							["<C-x>"] = function(prompt_bufnr)
								fb_actions.toggle_hidden(prompt_bufnr)
								fb_actions.toggle_respect_gitignore(prompt_bufnr)
							end,
						},
					},
				},
				undo = {
					side_by_side = false,
					use_delta = false,
					layout_config = {
						horizontal = {
							width_padding = 0.1,
							height_padding = 0.1,
							preview_width = 0.7,
							width = 0.9,
						},
					},
				},
			},
		})

		telescope.load_extension("file_browser")
		telescope.load_extension("fzf")
		telescope.load_extension("egrepify")
		telescope.load_extension("undo")
		telescope.load_extension("noice")

		vim.keymap.set("n", "<C-f>", builtin.find_files, {})
		vim.keymap.set("n", "<C-b>", builtin.buffers, {})
		vim.keymap.set("n", "<C-g>", telescope.extensions.egrepify.egrepify, {})

		vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
		-- find siblings
		vim.keymap.set("n", "<leader>pj", function()
			builtin.find_files({ cwd = vim.fn.expand("%:p:h") })
		end)
		vim.keymap.set("n", "<leader>pb", builtin.buffers, {})
		vim.keymap.set("n", "<leader>pc", builtin.grep_string, {})
		vim.keymap.set("n", "<leader>gb", builtin.git_branches, {})
		vim.keymap.set("n", "<leader>ps", telescope.extensions.egrepify.egrepify, {})
		vim.keymap.set("n", "<leader>ph", builtin.help_tags, {})
		vim.keymap.set("n", "<leader>py", telescope.extensions.neoclip.default, {})
		vim.keymap.set("n", "<leader>pu", telescope.extensions.undo.undo, {})
		vim.keymap.set("n", "<leader>pe", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", {})
	end,
}
