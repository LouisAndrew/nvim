return {
	"epwalsh/obsidian.nvim",
	lazy = true,
	keys = {
		{ "<leader>lo", "<cmd>:ObsidianOpen<cr>" },
		{ "<leader>lf", "<cmd>:ObsidianQuickSwitch<cr>" },
		{ "<leader>ls", "<cmd>:ObsidianSearch<cr>" },
		{ "<leader>lp", "<cmd>:ObsidianPasteImg<cr>" },
		{ "<leader>ll", "<cmd>:ObsidianBacklinks<cr>" },
		{ "<leader>ln", ":ObsidianNew " },
	},
	requires = {
		"nvim-lua/plenary.nvim",
		"godlygeek/tabular",
		"ekickx/clipboard-image.nvim",
		-- "preservim/vim-markdown"
	},
	config = function()
		local colors = require("colors")

		require("obsidian").setup({
			ui = {
				reference_text = { hl_group = "ObsidianRefText" },
				highlight_text = { hl_group = "ObsidianHighlightText" },
				tags = { hl_group = "ObsidianTag" },
				external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
				hl_groups = {
					ObsidianRefText = { fg = colors.cyan },
					ObsidianHighlightText = { fg = colors.debug },
					ObsidianTag = { fg = colors.foreground },
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
			sort_by = "path",
		})
	end,
}
