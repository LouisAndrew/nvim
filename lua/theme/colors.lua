local Color = require("colorbuddy").Color
local minimal_fedu = require("colors")

Color.new("nb_background", minimal_fedu.background)
Color.new("primary", minimal_fedu.foreground)
-- Variables and stuff
Color.new("secondary", minimal_fedu.white)

Color.new("diagnostic_error", minimal_fedu.diagnostic_error)
Color.new("diagnostic_warning", minimal_fedu.diagnostic_warning)
Color.new("diagnostic_info", minimal_fedu.diagnostic_info)
Color.new("diagnostic_hint", minimal_fedu.diagnostic_hint)

Color.new("mfed_0", minimal_fedu.mfed_0)
Color.new("mfed_1", minimal_fedu.mfed_1)
Color.new("mfed_2", minimal_fedu.mfed_2)
Color.new("mfed_3", minimal_fedu.mfed_3)
Color.new("mfed_4", minimal_fedu.mfed_4)
Color.new("mfed_5", minimal_fedu.mfed_5)
Color.new("mfed_6", minimal_fedu.mfed_6)
Color.new("mfed_7", minimal_fedu.mfed_7)
Color.new("mfed_8", minimal_fedu.mfed_8)
Color.new("mfed_9", minimal_fedu.mfed_9)

Color.new("mfed_cyan", minimal_fedu.cyan)
Color.new("mfed_navy", minimal_fedu.navy)
Color.new("mfed_dim", minimal_fedu.dimmed_white)
Color.new("mfed_bool", minimal_fedu.misc.bool)
Color.new("mfed_num", minimal_fedu.misc.number)
Color.new("debug", minimal_fedu.debug)
Color.new("mfed_bg_accent", minimal_fedu.bg_accent)
Color.new("mfed_bg_accent_light", minimal_fedu.bg_accent_light)
Color.new("dimmed_red", "#ff8185")
Color.new("dimmed_white", minimal_fedu.dimmed_white)
Color.new("bg_shade", minimal_fedu.bg_shade)

Color.new("add", minimal_fedu.misc.add)
Color.new("remove", minimal_fedu.misc.remove)
Color.new("change", minimal_fedu.misc.change)
Color.new("remove_fg", minimal_fedu.misc.remove_fg)
Color.new("add_fg", minimal_fedu.misc.add_fg)

Color.new("yellow_fg", minimal_fedu.palette.yellow_fg)
Color.new("yellow", minimal_fedu.palette.yellow)
Color.new("red", minimal_fedu.palette.red)
Color.new("red_softened", minimal_fedu.palette.red_softened)

Color.new("indigo_fg", minimal_fedu.palette.indigo_fg)
Color.new("indigo", minimal_fedu.palette.indigo)

Color.new("blue_fg", minimal_fedu.palette.blue_fg)
Color.new("blue", minimal_fedu.palette.blue)

Color.new("magenta", minimal_fedu.palette.magenta)
Color.new("magenta_fg", minimal_fedu.palette.magenta_fg)
Color.new("visual", minimal_fedu.misc.visual)
