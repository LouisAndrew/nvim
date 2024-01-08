return {
	"epwalsh/obsidian.nvim",
	lazy = true,
	keys = {
		{ "<leader>lo", "<cmd>:ObsidianOpen<cr>" },
		{ "<leader>lf", "<cmd>:ObsidianQuickSwitch<cr>" },
		{ "<leader>ls", "<cmd>:ObsidianSearch<cr>" },
		{ "<leader>lp", "<cmd>:ObsidianPasteImg<cr>" },
		{ "<leader>ll", "<cmd>:ObsidianBacklinks<cr>" },
		-- { "<leader>ln", ":e ~/dev/documents/notes/" },
		{ "<leader>ln", ":ObsidianNew notes/" },
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"godlygeek/tabular",
		"dfendr/clipboard-image.nvim",
		{
			"ellisonleao/glow.nvim",
			cmd = "Glow",
			config = function()
				require("glow").setup({
					path = "/opt/homebrew/bin/glow",
					border = "rounded", -- floating window border config
					style = "dark", -- filled automatically with your current editor background, you can override using glow json style
					pager = false,
					width = 150,
					height = 300,
					width_ratio = 0.7, -- maximum width of the Glow window compared to the nvim window size (overrides `width`)
					height_ratio = 0.7,
				})

				vim.keymap.set("n", "<leader>lg", "<cmd>:Glow<cr>", { noremap = true, silent = true })
			end,
		},
		-- "preservim/vim-markdown"
	},
	config = function()
		local colors = require("colors")

		require("obsidian").setup({
			ui = {
				reference_text = { hl_group = "ObsidianRefText" },
				highlight_text = { hl_group = "ObsidianHighlightText" },
				tags = { hl_group = "ObsidianTag" },
				external_link_icon = {
					--[[ char = "", ]]
					char = "",
					hl_group = "ObsidianExtLinkIcon",
				},
				checkboxes = {
					-- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
					[" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
					["x"] = { char = "", hl_group = "ObsidianDone" },
					[">"] = { char = "", hl_group = "ObsidianRightArrow" },
					["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
					-- Replace the above with this if you don't have a patched font:
					-- [" "] = { char = "☐", hl_group = "ObsidianTodo" },
					-- ["x"] = { char = "✔", hl_group = "ObsidianDone" },

					-- You can also add more custom ones...
				},
				hl_groups = {
					ObsidianRefText = { fg = colors.cyan },
					ObsidianHighlightText = { fg = colors.debug },
					ObsidianTag = { fg = colors.palette.blue_fg, bg = colors.palette.blue },
					ObsidianExtLinkIcon = { fg = colors.navy },
				},
			},
			workspaces = {
				{
					name = "personal",
					path = "~/dev/documents",
				},
			},
			open_app_foreground = true,
			follow_url_func = function(url)
				vim.fn.jobstart({ "open", url })
			end,
			attachments = {
				img_folder = "assets/imgs",
				img_text_func = function(client, path)
					local link_path
					local vault_relative_path = client:vault_relative_path(path)
					if vault_relative_path ~= nil then
						-- Use relative path if the image is saved in the vault dir.
						link_path = vault_relative_path
					else
						-- Otherwise use the absolute path.
						link_path = tostring(path)
					end
					local display_name = vim.fs.basename(link_path)
					return string.format("![%s](%s)", display_name, link_path)
				end,
			},
			sort_by = "modified",
			sort_reversed = true,
			note_frontmatter_func = function(note)
				-- This is equivalent to the default frontmatter function.
				local now = os.date("%d.%m.%Y")
				local out = { id = note.id, aliases = note.aliases, tags = note.tags, created = now, modified = now }
				-- `note.metadata` contains any manually added fields in the frontmatter.
				-- So here we just make sure those fields are kept in the frontmatter.
				if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
					for k, v in pairs(note.metadata) do
						out[k] = v

						if k == "modified" then
							out[k] = now
						end
					end
				end
				return out
			end,
		})
	end,
}
