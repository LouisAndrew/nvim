return {
		"nvim-lualine/lualine.nvim",
     config = function() 
        local minimal_fedu = require("colors")
local lualine = require("lualine")

local colors = {
	bg = minimal_fedu.background,
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

--[[ local conditions = {
	buffer_not_empty = function()
		return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
	end,
	hide_in_width = function()
		return vim.fn.winwidth(0) > 80
	end,
	check_git_workspace = function()
		local filepath = vim.fn.expand("%:p:h")
		local gitdir = vim.fn.finddir(".git", filepath .. ";")
		return gitdir and #gitdir > 0 and #gitdir < #filepath
	end,
} ]]

local config = {
	options = {
		-- Disable sections and component separators
		component_separators = "",
		section_separators = "",
		theme = {
			-- We are going to use lualine_c an lualine_x as left and
			-- right section. Both are highlighted by c theme .  So we
			-- are just setting default looks o statusline
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
		lualine_b = {},
		lualine_c = {},
		lualine_x = {
			{
				"filename",
				file_status = true, -- Displays file status (readonly status, modified status)
				newfile_status = false, -- Display new file status (new file means no write after created)
				path = 4, -- 0: Just the filename
				color = { fg = minimal_fedu.palette.blue_fg, bg = minimal_fedu.palette.blue },
				-- 1: Relative path
				-- 2: Absolute path
				-- 3: Absolute path, with tilde as the home directory
				-- 4: Filename and parent dir, with tilde as the home directory

				shorting_target = 60, -- Shortens path to leave 40 spaces in the window
				-- for other components. (terrible name, any suggestions?)
				symbols = {
					modified = "[+]", -- Text to show when the file is modified.
					readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
					unnamed = "[No Name]", -- Text to show for unnamed buffers.
					newfile = "[New]", -- Text to show for newly created file before first write
				},
			},
		},
		lualine_y = {},
		lualine_z = {},
	},
	inactive_winbar = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {},
		lualine_z = {},
		lualine_y = {},
		lualine_x = {
			{
				"filename",
				file_status = true, -- Displays file status (readonly status, modified status)
				newfile_status = false, -- Display new file status (new file means no write after created)
				path = 4, -- 0: Just the filename
				color = { fg = minimal_fedu.palette.blue_fg, gui = "" },
				-- 1: Relative path
				-- 2: Absolute path
				-- 3: Absolute path, with tilde as the home directory
				-- 4: Filename and parent dir, with tilde as the home directory

				shorting_target = 60, -- Shortens path to leave 40 spaces in the window
				-- for other components. (terrible name, any suggestions?)
				symbols = {
					modified = "[+]", -- Text to show when the file is modified.
					readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
					unnamed = "[No Name]", -- Text to show for unnamed buffers.
					newfile = "[New]", -- Text to show for newly created file before first write
				},
			},
		},
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
			v = minimal_fedu.palette.blue_fg,
			[""] = minimal_fedu.palette.blue_fg,
			V = minimal_fedu.palette.blue_fg,
			c = minimal_fedu.palette.yellow_fg,
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

		local bg = mode_color_bg[vim.fn.mode()]

		return { fg = mode_color[vim.fn.mode()], bg = bg }
	end,
	padding = { right = 1, left = 1 },
})

ins_left({
	"branch",
	icon = "",
	color = { fg = minimal_fedu.palette.indigo_fg, bg = minimal_fedu.palette.indigo },
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
	symbols = { error = " ", warn = " ", info = " ", hint = " " },
	diagnostics_color = {
		color_error = { fg = minimal_fedu.misc.remove_fg },
		color_warn = { fg = "#ffad67" },
		color_info = { fg = minimal_fedu.misc.add_fg },
	},
	padding = { left = 1 },
})

ins_right({ "location", color = { fg = minimal_fedu.misc.add_fg } })

ins_right({
	-- Lsp server name .
	function()
		local msg = "  "
		local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
		local clients = vim.lsp.get_active_clients()

		if next(clients) == nil then
			return msg
		end

		local client_names = {}

		for _, client in ipairs(clients) do
			local filetypes = client.config.filetypes
			if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 and client.name ~= "null-ls" then
				client_names[#client_names + 1] = client.name
			end
		end

		if #client_names > 0 then
			return "  " .. table.concat(client_names, ", ")
		else
			return msg
		end
	end,
	color = { fg = minimal_fedu.misc.add_fg, bg = minimal_fedu.misc.add },
	padding = { left = 1, right = 1 },
})

lualine.setup(config)

     end
	}
