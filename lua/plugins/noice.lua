local special_chars = require("theme.special_chars")
local icons = require("theme.icons")

return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	version = "4.4.7",
	config = function()
		local noice = require("noice")
		noice.setup({
			cmdline = {
				view = "cmdline",
				enabled = true,
				opts = {},
				format = {
					cmdline = { pattern = "^:", icon = "   ", lang = "vim", title = "" },
					search_down = {
						title = "",
						kind = "search",
						pattern = "^/",
						icon = "   ",
						lang = "regex",
						opts = {
							win_options = {
								winhighlight = {
									Normal = "NoiceCmdline",
									FloatBorder = "NoiceCmdline",
								},
							},
						},
					},
					search_up = {
						title = "",
						kind = "search",
						pattern = "^%?",
						icon = "   ",
						lang = "regex",
						opts = {
							win_options = {
								winhighlight = {
									Normal = "NoiceCmdline",
									FloatBorder = "NoiceCmdline",
								},
							},
						},
					},
					filter = {
						title = "",
						pattern = "^:%s*!",
						icon = "  $ ",
						lang = "bash",
						opts = {
							win_options = {
								winhighlight = {
									Normal = "NoiceCmdline",
									FloatBorder = "NoiceCmdline",
								},
							},
						},
					},
					lua = {
						title = "",
						pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" },
						icon = "   ",
						lang = "lua",
						opts = {
							win_options = {
								winhighlight = {
									Normal = "NoiceCmdline",
									FloatBorder = "NoiceCmdline",
								},
							},
						},
					},
					help = { title = "", pattern = "^:%s*he?l?p?%s+", icon = "  ? " },
					input = {
						opts = {
							-- win_options = {
							-- 	winhighlight = {
							-- 		Normal = "NoiceInputNormal",
							-- 	},
							-- },

							border = {
								-- style = special_chars.create_special_border({ vertical_padding = false }),
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
						width = 64,
						height = "auto",
					},
					border = {
						style = special_chars.create_special_border({
							vertical_half = true,
						}),
						text = nil,
					},
				},
				mini = {},
				hover = {
					win_options = {
						winhighlight = "Normal:NoiceHoverNormal,FloatBorder:cmpborder",
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
				bottom_search = false,
				command_palette = true,
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
