local ls = require("luasnip")
local s = ls.snippet
local fmt = require("luasnip.extras.fmt").fmt
local f = ls.function_node
local i = ls.insert_node

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

	return component_name:match("(.+)%..+$") or component_name
end

return {
	-- ls.snippet({ trig = "vts" }, {t('<script setup lang="ts">$0</script>') }),
	s("imd", fmt('import {{ {} }} from "{}"', { i(2), i(1) })),
	s(
		"imp",
		fmt('import {actual} from "{from}"', {
			actual = f(extract_component_name, { 1 }),
			from = i(1),
		})
	),
}
