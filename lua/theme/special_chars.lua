local half_lower_block = "▄"
local half_upper_block = "▀"
local half_left_block = "▌"
local half_right_block = "▐"
local full_block = "█"

--- @class BorderOpts
--- @field side_padding boolean
--- @field padding_char? string

--- @param opts? BorderOpts
local create_special_border = function(opts)
	local padding = opts and opts.padding_char or full_block
	local side_padding = opts and opts.side_padding or false

	local border = {}
	for i = 1, 3 do
		border[i] = half_lower_block
	end

	border[4] = side_padding and padding or ""

	for i = 5, 7 do
		border[i] = half_upper_block
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
}
