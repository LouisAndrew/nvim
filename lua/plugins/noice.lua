return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
		"MunifTanjim/nui.nvim",
	},
	config = function()
		local noice = require("noice")
		noice.setup({
			cmdline = {
				enabled = true, -- enables the Noice cmdline UI
				view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
				opts = {}, -- global options for the cmdline. See section on views
				format = {
					-- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
					-- view: (default is cmdline view)
					-- opts: any options passed to the view
					-- icon_hl_group: optional hl_group for the icon
					-- title: set to anything or empty string to hide
					cmdline = { pattern = "^:", icon = " >", lang = "vim", title = "" },
					search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex", title = "" },
					search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex", title = "" },
					filter = { pattern = "^:%s*!", icon = " $", lang = "bash", title = "" },
					lua = {
						pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*", title = "" },
						icon = " ",
						lang = "lua",
					},
					help = { pattern = "^:%s*he?l?p?%s+", icon = " ?", title = "" },
					input = {}, -- Used by input()
				},
			},
			views = {
				notify = {
					merge = true,
				},
				cmdline_popup = {
					relative = "editor",
					position = {
						row = "3%",
						col = "100%",
					},
					size = {
						width = 52,
						height = "auto",
					},
					border = {
						padding = { 3 },
						text = {
							top_align = "left",
						},
					},
				},
			},
			notify = {
				enabled = false,
			},
			lsp = {
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
				signature = {
					enabled = true,
				},
				progress = {
					enabled = false,
				},
			},
			-- you can enable a preset for easier configuration
			presets = {
				bottom_search = false, -- use a classic bottom cmdline for search
				command_palette = false, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = true, -- add a border to hover docs and signature help
			},
			popup_menu = {
				enabled = true,
				backend = "cmp",
			},
			messages = {
				view = "mini",
				view_error = "mini",
				view_warn = "mini",
			},
			format = {
				level = { icons = { error = " ", warn = " ", info = " " } },
			},
		})
	end,
}
