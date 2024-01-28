local special_chars = require("theme.special_chars")
local icons = require("theme.icons")

return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	config = function()
		local noice = require("noice")
		noice.setup({
			cmdline = {
				enabled = true,
				view = "cmdline",
				opts = {},
				format = {
					cmdline = { pattern = "^:", icon = "  ", lang = "vim" },
					search_down = {
						kind = "search",
						pattern = "^/",
						icon = "  ",
						lang = "regex",
						opts = {
							win_options = {
								winhighlight = {
									Normal = "NoiceCmdlineSearch",
								},
							},
						},
					},
					search_up = {
						kind = "search",
						pattern = "^%?",
						icon = "  ",
						lang = "regex",
						opts = {
							win_options = {
								winhighlight = {
									Normal = "NoiceCmdlineSearch",
								},
							},
						},
					},
					filter = {
						pattern = "^:%s*!",
						icon = " $ ",
						lang = "bash",
						opts = {
							win_options = {
								winhighlight = {
									Normal = "NoiceCmdlineScript",
								},
							},
						},
					},
					lua = {
						pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" },
						icon = "  ",
						lang = "lua",
						opts = {
							win_options = {
								winhighlight = {
									Normal = "NoiceCmdlineScript",
								},
							},
						},
					},
					help = { pattern = "^:%s*he?l?p?%s+", icon = " ?" },
					input = {
						opts = {
							win_options = {
								winhighlight = {
									Normal = "NoiceInputNormal",
								},
							},

							border = {
								style = special_chars.create_special_border(),
							},
						},
					},
				},
			},
			views = {
				notify = {
					merge = true,
				},
				cmdline = {},
				cmdline_popup = {
					relative = "editor",
					position = {
						row = "3%",
						col = "50%",
					},
					size = {
						width = 0.3,
						height = "auto",
					},
					border = {
						style = special_chars.create_special_border(),
						text = {
							top_align = "left",
						},
					},
				},
				mini = {},
				hover = {
					border = {
						style = special_chars.create_special_border(),
					},
					position = {
						row = 2,
					},
				},
				ui = {
					hover = {
						border = {
							style = special_chars.create_special_border(),
						},
						position = {
							row = 2,
						},
					},
				},
			},
			notify = {
				enabled = false,
			},
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
				signature = {
					auto_open = {
						enabled = false,
						trigger = false,
						luasnip = false,
					},
				},
			},
			presets = {
				bottom_search = true,
				command_palette = false,
				long_message_to_split = true,
				inc_rename = false,
				lsp_doc_border = false,
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
				level = { icons = { error = icons.Error, warn = icons.Warn, info = icons.Info } },
			},
			progress = {
				view = "mini",
			},
			routes = {
				{
					filter = {
						event = "lsp",
						cond = function(message)
							local client = vim.tbl_get(message.opts, "progress", "client")
							return client == "null-ls"
						end,
					},
					opts = {
						skip = true,
					},
				},
			},
		})
	end,
}
