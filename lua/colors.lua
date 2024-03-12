local red = "#431d1f"
local red_fg = "#ff8185"

local yellow_fg = "#fed7aa"
local yellow = "#713f12"

local dimmed_white = "#9a9a9a"
local white = "#ffffff"
local navy = "#678CB1"

local background = "#131313"
local bg_shade = "#0f0f0f"
local bg_accent_light = "#657578"
-- local foreground = "#ffbb80"
local foreground = "#ffcfa7"
local debug = "#ff0000"
local magenta = "#291A2E"
local orange = "#fb923c"

return {
	-- noirbuddy related.
	primary = foreground,
	diagnostic_error = red_fg,
	diagnostic_warning = yellow_fg,
	diagnostic_info = "#81c5ff",
	diagnostic_hint = dimmed_white,
	diag = {
		Error = red_fg,
		Warn = yellow_fg,
		ErrorInactive = "#b75c5f",
		WarnInactive = "#b19676",
	},

	noir_0 = white,
	noir_1 = "#f5f5f5",
	noir_2 = "#d5d5d5",
	noir_3 = "#b4b4b4",
	noir_4 = "#a7a7a7",
	noir_5 = navy,
	noir_6 = "#737373",
	noir_7 = "#535353",
	noir_8 = "#323232",
	noir_9 = "#212121",

	cyan = "#97CCF1",
	white = "#ffffff",
	navy = navy,
	white_accent = "#727272",
	white_softened = "#5a5a5a",
	dimmed_white = dimmed_white,
	debug = debug,
	foreground = foreground,
	background = background,
	bg = background,
	bg_shade = bg_shade,
	bg_accent = "#1f2425",
	bg_accent_light = bg_accent_light,

	palette = {
		blue = "#172554",
		blue_fg = "#93c5fd",
		indigo = "#1e1b4b",
		-- indigo_fg = "#a5b4fc",
		indigo_fg = "#818cf8",
		yellow = yellow,
		yellow_fg = yellow_fg,
		red_softened = "#ff8185",
		red = red,
		red_fg = red_fg,
		magenta = magenta,
		magenta_fg = "#e879f9",
		orange = orange,
	},
	misc = {
		bool = "#eeb684",
		number = "#ffd6b3",
		add_fg = "#81ffbb",
		remove_fg = red_fg,
		change = "#2f4557",
		add = "#1d3629",
		remove = red,
		-- 15% of visual in `modes.lua`
		visual = "#242536",
	},
}
