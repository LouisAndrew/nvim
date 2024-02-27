local half_lower_block = "▄"
local half_upper_block = "▀"
local half_left_block = "▌"
local half_right_block = "▐"
local full_block = "█"
local quarter_lower_block = "▂"
local quarter_upper_block = "🮂"

--- @class BorderOpts
--- @field side_padding? boolean
--- @field padding_char? string
--- @field hide_vertical_padding? boolean
--- @field vertical_half? boolean

--- @param opts? BorderOpts
local create_special_border = function(opts)
	local padding = opts and opts.padding_char or full_block
	local side_padding = opts and opts.side_padding or false
	local hide_vertical_padding = opts and opts.hide_vertical_padding or false
	local vertical_half = opts and opts.vertical_half or false

	local border = {}
	local vertical_borders = {
		half_lower_block,
		half_upper_block,
	}

	if hide_vertical_padding then
		vertical_borders = {
			"",
			"",
		}
	end

	if vertical_half then
		vertical_borders = {
			quarter_lower_block,
			quarter_upper_block,
		}
	end

	for i = 1, 3 do
		border[i] = vertical_borders[1]
	end

	border[4] = side_padding and padding or ""

	for i = 5, 7 do
		border[i] = vertical_borders[2]
	end

	border[8] = side_padding and padding or ""

	return border
end

return {
	half_lower_block = half_lower_block,
	half_upper_block = half_upper_block,
	half_left_block = half_left_block,
	half_right_block = half_right_block,
	full_block = full_block,
	create_special_border = create_special_border,
	quadrant_lower_right = "▗",
	quadrant_lower_left = "▖",
	quadrant_upper_right = "▝",
	quadrant_upper_left = "▘",
}
