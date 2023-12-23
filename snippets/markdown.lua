local ls = require("luasnip")
local s = ls.snippet
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node

return {
	-- ls.snippet({ trig = "vts" }, {t('<script setup lang="ts">$0</script>') }),
	s("lk", fmt("[{}]({})", { i(2), i(1) })),
}
