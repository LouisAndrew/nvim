local ls = require("luasnip")
local s = ls.snippet
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local sn = ls.snippet_node

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
	s(
		"imd",
		fmt('import {actual} from "{from}"', {
			from = i(1),
			actual = c(2, {
				sn(nil, fmt("{{ {} }}", { i(1) })),
				i(1),
			}),
		})
	),

	s(
		"imp",
		fmt('import {actual} from "{from}"', {
			actual = f(extract_component_name, { 1 }),
			from = i(1),
		})
	),

	s("clg", fmt("console.log({})", { i(1) })),

	s(
		"ds",
		fmt("const {destructure} = {variable};", {
			variable = i(1),
			destructure = c(2, {
				sn(nil, fmt("{{ {} }}", { i(1) })),
				sn(nil, fmt("[{}]", { i(1) })),
			}),
		})
	),
}
