local minimal_fedu = require("colors")

require("noirbuddy").setup({
	preset = "crt-green",
	colors = {
		background = minimal_fedu.background,
		primary = minimal_fedu.foreground,
		diagnostic_error = minimal_fedu.misc.remove_fg,
		diagnostic_warning = minimal_fedu.palette.yellow_fg,
		diagnostic_info = "#81c5ff",
		diagnostic_hint = minimal_fedu.dimmed_white,

		noir_0 = minimal_fedu.white,
		noir_1 = "#f5f5f5",
		noir_2 = "#d5d5d5",
		noir_3 = "#b4b4b4",
		noir_4 = "#a7a7a7",
		noir_5 = minimal_fedu.navy,
		noir_6 = "#737373",
		noir_7 = "#535353",
		noir_8 = "#323232",
		noir_9 = "#212121",
	},
})

local Color, colors, Group = require("colorbuddy").setup({})
local styles = require("colorbuddy").styles

Color.new("mfed_cyan", minimal_fedu.cyan)
Color.new("mfed_navy", minimal_fedu.navy)
Color.new("mfed_dim", minimal_fedu.dimmed_white)
Color.new("mfed_bool", minimal_fedu.misc.bool)
Color.new("mfed_num", minimal_fedu.misc.number)
Color.new("debug", minimal_fedu.debug)
Color.new("mfed_bg_accent", minimal_fedu.bg_accent)
Color.new("dimmed_red", "#ff8185")

Color.new("add", minimal_fedu.misc.add)
Color.new("remove", minimal_fedu.misc.remove)
Color.new("change", minimal_fedu.misc.change)
Color.new("remove_fg", minimal_fedu.misc.remove_fg)
Color.new("add_fg", minimal_fedu.misc.add_fg)

Color.new("yellow_fg", minimal_fedu.palette.yellow_fg)
Color.new("yellow", minimal_fedu.palette.yellow)

-- LSP stuff
Group.new("Identifier", colors.noir_0)
Group.new("@keyword.return", colors.mfed_cyan)
Group.new("@include", colors.mfed_cyan)
Group.new("@punctuation.delimiter", colors.mfed_dim)
Group.new("@tag", colors.white)
Group.new("@type.builtin", colors.mfed_dim)
Group.new("@boolean", colors.mfed_bool)
Group.new("@number", colors.mfed_num)

Group.new("@function.macro", colors.mfed_cyan)
Group.new("@macro", colors.mfed_cyan)
Group.new("@constant.macro", colors.mfed_cyan)
Group.new("@conditional", colors.mfed_cyan)

Group.new("@lsp.type.macro", colors.mfed_cyan)

-- Editor stuff
Group.new("CursorLineNr", colors.mfed_dim, nil)
Group.new("TabLine", colors.dimmed_white, nil)
Group.new("TabLineFill", nil, nil)
Group.new("VertSplit", colors.mfed_dim, nil)
Group.new("EndOfBuffer", colors.background, nil)
Group.new("ErrorMsg", colors.dimmed_red)
Group.new("Pmenu", colors.noir_2, colors.mfed_bg_accent)
Group.new("PmenuSel", colors.white, colors.change)
Group.new("StatusLine", colors.mfed_bg_accent, colors.mfed_bg_accent)

-- Telescope
Group.new("TelescopeResultsNormal", colors.mfed_dim)

-- Signs
Group.new("diffAdded", colors.add_fg)
Group.new("diffRemoved", colors.remove_fg)
Group.new("diffChanged", colors.primary)
Group.new("diffFile", colors.primary)
Group.new("diffNewFile", colors.primary)
Group.new("diffLine", colors.primary)

-- DiffView
Group.new("DiffAdd", nil, colors.add)
Group.new("DiffDelete", nil, colors.remove)
Group.new("DiffChange", nil, colors.change)
Group.new("DiffText", nil, colors.change)

Group.new("CmpItemAbbrDeprecated", colors.mfed_dim, nil, styles.strikethrough)
Group.new("CmpItemAbbrMatch", colors.mfed_cyan)
Group.new("CmpItemAbbrMatchFuzzy", colors.mfed_cyan)

Group.new("CmpItemKindVariable", colors.mfed_navy)
Group.new("CmpItemKindInterface", colors.mfed_navy)
Group.new("CmpItemKindText", colors.mfed_navy)

Group.new("CmpItemKindFunction", colors.mfed_bool)
Group.new("CmpItemKindMethod", colors.mfed_bool)

Group.new("CmpItemKindKeyword", colors.mfed_cyan)
Group.new("CmpItemKindProperty", colors.mfed_cyan)
Group.new("CmpItemKindUnit", colors.mfed_cyan)

Group.new("BufferInactive", nil, colors.bg_accent)

Group.new("ObsidianRefText", colors.mfed_cyan)
Group.new("ObsidianHighlightText", colors.debug)
Group.new("ObsidianTag", colors.primary)
Group.new("ObsidianExtLinkIcon", colors.mfed_navy)

Group.new("DiagnosticError", colors.diagnostic_error, nil)
Group.new("DiagnosticWarn", colors.yellow_fg, nil)

Group.new("LuaLineDiffChange", colors.yellow_fg, nil)
Group.new("LuaLineDiffAdd", colors.add_fg, nil)
Group.new("LuaLineDiffDelete", colors.remove_fg, nil)

-- Group.new("DiagnosticInfo", colors.diagnostic_info, nil, sumStyles({ s.bold, s.italic, s.undercurl }))
-- Group.new("DiagnosticHint", colors.diagnostic_hint, nil, sumStyles({ s.bold, s.italic, s.undercurl }))
