local minimal_fedu = {
  cyan = "#97CCF1",
  white = "#ffffff",
  dimmed_white = "#9a9a9a",
  debug = "#ff0000",
  navy = "#678CB1",
  foreground = "#ffbb80",
  background = "#131313",
  bg_accent = "#1f2425",
  misc = {
    bool = "#daedfa",
    number = "#ffd6b3",
    add_fg = "#81ffbb",
    remove_fg = "#ff676d",
    change = "#2f4557",
    add = "#1d3629",
    remove = "#431d1f",
  },
}

require("noirbuddy").setup({
  preset = "crt-green",
  colors = {
    background = minimal_fedu.background,
    primary = minimal_fedu.foreground,
    diagnostic_error = minimal_fedu.remove_fg,
    diagnostic_warning = "#ffad67",
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

local Color, colors, Group, styles = require("colorbuddy").setup({})

Color.new("mfed_cyan", minimal_fedu.cyan)
Color.new("mfed_navy", minimal_fedu.navy)
Color.new("mfed_dim", minimal_fedu.dimmed_white)
Color.new("mfed_bool", minimal_fedu.misc.bool)
Color.new("mfed_num", minimal_fedu.misc.number)
Color.new("debug", minimal_fedu.debug)
Color.new("mfed_bg_accent", minimal_fedu.bg_accent)

Color.new("add", minimal_fedu.misc.add)
Color.new("remove", minimal_fedu.misc.remove)
Color.new("change", minimal_fedu.misc.change)
Color.new("remove_fg", minimal_fedu.misc.remove_fg)
Color.new("add_fg", minimal_fedu.misc.add_fg)

-- LSP stuff
Group.new("Identifier", colors.noir_0)
Group.new("@keyword.return", colors.mfed_cyan)
Group.new("@include", colors.mfed_cyan)
Group.new("@punctuation.delimiter", colors.mfed_dim)
Group.new("@tag", colors.white)
Group.new("@type.builtin", colors.mfed_dim)
Group.new("@boolean", colors.mfed_bool)
Group.new("@number", colors.mfed_num)

-- Editor stuff
Group.new("CursorLineNr", colors.mfed_dim, colors.background)
Group.new("TabLine", colors.dimmed_white, colors.mfed_bg_accent)
Group.new("TabLineFill", nil, colors.mfed_bg_accent)
Group.new("VertSplit", colors.noir_8, colors.background)
Group.new("EndOfBuffer", colors.background, nil)
Group.new("ErrorMsg", colors.diagnostic_error)

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
