local ls = require("luasnip")
local s = ls.snippet
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node

return {
	-- ls.snippet({ trig = "vts" }, {t('<script setup lang="ts">$0</script>') }),
	s("imd", fmt('import {{ {} }} from "{}"', { i(2), i(1) })),
	s("imp", fmt('import {} from "{}"', { i(2), i(1) })),
	s("clg", fmt("console.log({})", { i(1) })),
}
