require("obsidian").setup({
	ui = {
		reference_text = { hl_group = "ObsidianRefText" },
		highlight_text = { hl_group = "ObsidianHighlightText" },
		tags = { hl_group = "ObsidianTag" },
		external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
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

vim.keymap.set("n", "<leader>lo", "<cmd>:ObsidianOpen<cr>", { noremap = true })
vim.keymap.set("n", "<leader>lf", "<cmd>:ObsidianQuickSwitch<cr>", { noremap = true })
vim.keymap.set("n", "<leader>ls", "<cmd>:ObsidianSearch<cr>", { noremap = true })
vim.keymap.set("n", "<leader>lp", "<cmd>:ObsidianPasteImg<cr>", { noremap = true })
vim.keymap.set("n", "<leader>ll", "<cmd>:ObsidianBacklinks<cr>", { noremap = true })
vim.keymap.set("n", "<leader>ln", ":ObsidianNew", { noremap = true })
