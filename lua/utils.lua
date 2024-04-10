---@param tab table
---@param val  string
---@return boolean
local function has_value(tab, val)
	for _, value in ipairs(tab) do
		if value == val then
			return true
		end
	end

	return false
end

local function dump(o)
	if type(o) == "table" then
		local s = "{ "
		for k, v in pairs(o) do
			if type(k) ~= "number" then
				k = '"' .. k .. '"'
			end
			s = s .. "[" .. k .. "] = " .. dump(v) .. ","
		end
		return s .. "} "
	else
		return tostring(o)
	end
end

local nvim_config_path = function()
	return vim.fn.stdpath("config")
end

local pascal_case = function(str)
	local pascalStr = str:gsub("[-_]%l", string.upper):gsub("[-_]", "")
	return pascalStr:gsub("^%l", string.upper)
end

--- @param text string
local insert = function(text, append)
	local content = text
	if append then
		local current_line = vim.api.nvim_get_current_line()
		if current_line == "" then
			content = text
		else
			content = current_line .. " " .. text
		end
	end

	vim.api.nvim_set_current_line(content)
end

local function extract_component_name(
	args, -- text from i(2) in this example i.e. { { "456" } }
	_, -- parent snippet or parent node
	_ -- custom arguments
)
	local import_content = args[1][1]
	local component_name = string.gsub(import_content, ".+/(.*)$", "%1")

	if component_name == "" then
		return "snip"
	end

	local str = component_name:match("(.+)%..+$") or component_name
	return pascal_case(str)
end

local merge = function(first_table, second_table)
	for k, v in pairs(second_table) do
		first_table[k] = v
	end
end

return {
	has_value = has_value,
	dump = dump,
	nvim_config_path = nvim_config_path(),
	insert = insert,
	CONST = {
		truthy = 1,
		falsy = 0,
		emptyString = "",
	},
	pascal_case = pascal_case,
	extract_component_name = extract_component_name,
	merge = merge,
}
