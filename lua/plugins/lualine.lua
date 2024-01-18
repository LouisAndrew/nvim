return {
	"nvim-lualine/lualine.nvim",
	config = function()
		local minimal_fedu = require("colors")
		local lualine = require("lualine")

		local colors = {
			-- Enable bg if transparent not disabled.
			bg = minimal_fedu.background,
			-- bg = nil,
			fg = "#ffbb80",
			yellow = "#ffad67",
			cyan = "#008080",
			darkblue = "#081633",
			green = "#81ffbb",
			orange = "#FF8800",
			violet = "#a9a1e1",
			magenta = "#c678dd",
			blue = "#51afef",
			red = "#ff8185",
		}

		local config = {
			options = {
				section_separators = "",
				component_separators = "",
				theme = {
					normal = { c = { fg = colors.fg, bg = colors.bg } },
					inactive = { c = { fg = colors.fg, bg = colors.bg } },
				},
			},
			disabled_filetypes = {
				statusline = {
					"packer",
					"NvimTree",
					"NeoGit",
				},
				winbar = {
					"packer",
					"NvimTree",
					"NeoGit",
				},
			},
			sections = {
				-- these are to remove the defaults
				lualine_a = {},
				lualine_b = {},
				lualine_y = {},
				lualine_z = {},
				-- These will be filled later
				lualine_c = {},
				lualine_x = {},
			},
			inactive_sections = {
				-- these are to remove the defaults
				lualine_a = {},
				lualine_b = {},
				lualine_y = {},
				lualine_z = {},
				lualine_c = {},
				lualine_x = {},
			},
			winbar = {
				lualine_a = {},
				lualine_b = {
					{
						"filetype",
						colored = false,
						icon_only = true,
						icon = { align = "right" },
						padding = { left = 3 },
						color = { fg = minimal_fedu.noir_2, bg = nil },
					},
				},
				lualine_x = {},
				lualine_c = {
					{
						"filename",
						file_status = true, -- Displays file status (readonly status, modified status)
						newfile_status = false, -- Display new file status (new file means no write after created)
						path = 4, -- 0: Just the filename
						color = { fg = minimal_fedu.noir_2, bg = nil },
						-- 1: Relative path
						-- 2: Absolute path
						-- 3: Absolute path, with tilde as the home directory
						-- 4: Filename and parent dir, with tilde as the home directory

						shorting_target = 60, -- Shortens path to leave 40 spaces in the window
						-- for other components. (terrible name, any suggestions?)
						symbols = {
							modified = "", -- Text to show when the file is modified.
							readonly = "", -- Text to show when the file is non-modifiable or readonly.
							unnamed = "", -- Text to show for unnamed buffers.
							newfile = "[New]", -- Text to show for newly created file before first write
						},
					},
				},
				lualine_y = {},
				lualine_z = {},
			},
			inactive_winbar = {
				lualine_a = {},
				lualine_b = {
					{
						"filetype",
						colored = false,
						icon_only = true,
						icon = { align = "right" },
						padding = { left = 3 },
						color = { fg = minimal_fedu.noir_6, bg = nil },
					},
				},
				lualine_c = {
					{
						"filename",
						file_status = true, -- Displays file status (readonly status, modified status)
						newfile_status = false, -- Display new file status (new file means no write after created)
						path = 4, -- 0: Just the filename
						color = { fg = minimal_fedu.noir_6 },
						-- 1: Relative path
						-- 2: Absolute path
						-- 3: Absolute path, with tilde as the home directory
						-- 4: Filename and parent dir, with tilde as the home directory

						shorting_target = 60, -- Shortens path to leave 40 spaces in the window
						-- for other components. (terrible name, any suggestions?)
						symbols = {
							modified = "", -- Text to show when the file is modified.
							readonly = "", -- Text to show when the file is non-modifiable or readonly.
							unnamed = "", -- Text to show for unnamed buffers.
							newfile = "[New]", -- Text to show for newly created file before first write
						},
					},
				},
				lualine_x = {},
				lualine_z = {},
				lualine_y = {},
			},
		}

		-- Inserts a component in lualine_c at left section
		local function ins_left(component)
			table.insert(config.sections.lualine_c, component)
		end

		-- Inserts a component in lualine_x at right section
		local function ins_right(component)
			table.insert(config.sections.lualine_x, component)
		end

		ins_left({
			-- mode component
			function()
				local mode = vim.fn.mode()
				local mode_info = {
					n = "normal",
					i = "insert",
					c = "command",
					v = "visual",
					[""] = "visual",
				}
				return mode_info[mode] or mode
			end,

			color = function()
				-- auto change color according to neovims mode
				local mode_color = {
					n = minimal_fedu.misc.remove_fg,
					i = minimal_fedu.misc.add_fg,
					v = minimal_fedu.palette.magenta,
					[""] = minimal_fedu.palette.magenta,
					V = minimal_fedu.palette.magenta,
					c = minimal_fedu.palette.orange,
					no = colors.red,
					s = colors.orange,
					S = colors.orange,
					[""] = colors.orange,
					ic = colors.yellow,
					R = colors.violet,
					Rv = colors.violet,
					cv = colors.red,
					ce = colors.red,
					r = colors.cyan,
					rm = colors.cyan,
					["r?"] = colors.cyan,
					["!"] = colors.red,
					t = colors.red,
				}

				local mode_color_bg = {
					n = minimal_fedu.misc.remove,
					i = minimal_fedu.misc.add,
					v = minimal_fedu.misc.change,
					[""] = minimal_fedu.misc.change,
					c = minimal_fedu.palette.yellow,
				}

				-- local bg = mode_color_bg[vim.fn.mode()]

				return {
					fg = mode_color[vim.fn.mode()],
					-- bg = bg,
				}
			end,
			padding = { right = 1, left = 1 },
		})

		ins_left({
			"branch",
			icon = "",
			color = {
				fg = minimal_fedu.palette.indigo_fg,
				-- bg = minimal_fedu.palette.indigo,
			},
			padding = { right = 1, left = 1 },
		})

		ins_left({
			"diff",
			colored = true, -- Displays a colored diff status if set to true
			diff_color = {
				-- Same color values as the general color option can be used here.
				added = "LuaLineDiffAdd", -- Changes the diff's added color
				modified = "LuaLineDiffChange", -- Changes the diff's modified color
				removed = "LuaLineDiffDelete", -- Changes the diff's removed color you
			},
			symbols = { added = "+", modified = "~", removed = "-" },
		})

		ins_left({
			"diagnostics",
			sources = { "nvim_diagnostic" },
			symbols = { error = " ", warn = " ", info = " ", hint = " " },
			diagnostics_color = {
				color_error = { fg = minimal_fedu.misc.remove_fg },
				color_warn = { fg = "#ffad67" },
				color_info = { fg = minimal_fedu.misc.add_fg },
				color_hint = { fg = minimal_fedu.noir_9 },
			},
			padding = { left = 1 },
		})

		ins_left({
			function()
				local mode = require("noice").api.statusline.mode.get()
				if mode:find("^recording") then
					return mode
				end

				return ""
			end,
			cond = require("noice").api.statusline.mode.has,
			color = { fg = minimal_fedu.dimmed_white },
			padding = { left = 2 },
		})

		ins_right({ "location", color = { fg = minimal_fedu.dimmed_white } })

		ins_right({
			"buffers",
			show_filename_only = true, -- Shows shortened relative path when set to false.
			hide_filename_extension = false, -- Hide filename extension when set to true.
			show_modified_status = true, -- Shows indicator when the buffer is modified.

			mode = 0,

			max_length = vim.o.columns * 2 / 3, -- Maximum width of buffers component,
			-- it can also be a function that returns
			-- the value of `max_length` dynamically.
			filetype_names = {
				TelescopePrompt = "",
			},

			use_mode_colors = false,

			buffers_color = {
				-- Same values as the general color option can be used here.
				active = {
					fg = minimal_fedu.white,
				}, -- Color for active buffer.
				inactive = {
					fg = minimal_fedu.dimmed_white,
				}, -- Color for inactive buffer.
			},

			symbols = {
				modified = "  ", -- Text to show when the buffer is modified
				-- modified = "*",
				alternate_file = "", -- Text to show to identify the alternate file
				directory = "", -- Text to show when the buffer is a directory
			},

			padding = {
				right = 1,
			},
		})

		ins_right({
			-- Lsp server name .
			function()
				local msg = "|    no lsp"
				local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
				local clients = vim.lsp.get_active_clients()

				if next(clients) == nil then
					return msg
				end

				local client_names = {}

				for _, client in ipairs(clients) do
					local filetypes = client.config.filetypes
					if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 and client.name ~= "null-ls" then
						local n = client.name
						if n == "emmet_language_server" then
							n = "emmet"
						end

						client_names[#client_names + 1] = n
					end
				end

				if #client_names > 0 then
					return "|    " .. table.concat(client_names, ", ")
				else
					return msg
				end
			end,
			color = {
				fg = minimal_fedu.cyan,
				-- bg = minimal_fedu.misc.add
			},
			padding = { left = 1, right = 1 },
		})

		lualine.setup(config)
	end,
}
