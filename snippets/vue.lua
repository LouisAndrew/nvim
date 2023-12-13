local ls = require("luasnip")
local s = ls.snippet
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node

return {
	-- ls.snippet({ trig = "vts" }, {t('<script setup lang="ts">$0</script>') }),
	s("vts", fmt('<script setup lang="ts">{}</script>', { i(1) })),
	s("tem", fmt("<template>{}</template>", { i(1) })),
	s("pcs", fmt('<style scoped lang="postcss">{}</style>', { i(1) })),
}
