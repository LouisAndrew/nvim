local Color = require("colorbuddy").setup()
local minimal_fedu = require("colors")

Color.new("nb_background", minimal_fedu.background)
Color.new("primary", minimal_fedu.foreground)
-- Variables and stuff
Color.new("secondary", minimal_fedu.white)

--
-- Set up semantic color palette
-- These are to be used sparingly, but have semantic meaning for things like lsp diagnostics, git diffs, etc.
-- Can be configured by preset or end user
Color.new("diagnostic_error", minimal_fedu.diagnostic_error)
Color.new("diagnostic_warning", minimal_fedu.diagnostic_warning)
Color.new("diagnostic_info", minimal_fedu.diagnostic_info)
Color.new("diagnostic_hint", minimal_fedu.diagnostic_hint)
Color.new("diff_add", minimal_fedu.diff_add)
Color.new("diff_change", minimal_fedu.diff_change)
Color.new("diff_delete", minimal_fedu.diff_delete)

-- Set up noir grayscale palette
-- The rest of the theme is based on this grayscale palette, hence the name 'noir' buddy
-- For dark themes: 0 is light and 9 is dark
-- For light themes: 0 is dark and 9 is light
Color.new("noir_0", minimal_fedu.noir_0)
Color.new("noir_1", minimal_fedu.noir_1)
Color.new("noir_2", minimal_fedu.noir_2)
Color.new("noir_3", minimal_fedu.noir_3)
Color.new("noir_4", minimal_fedu.noir_4)
Color.new("noir_5", minimal_fedu.noir_5)
Color.new("noir_6", minimal_fedu.noir_6)
Color.new("noir_7", minimal_fedu.noir_7)
Color.new("noir_8", minimal_fedu.noir_8)
Color.new("noir_9", minimal_fedu.noir_9)

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
