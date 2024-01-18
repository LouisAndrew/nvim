local ls = require("luasnip")
local s = ls.snippet
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node
local c = ls.choice_node
local sn = ls.snippet_node
local t = ls.text_node

--
return {
	-- ls.snippet({ trig = "vts" }, {t('<script setup lang="ts">$0</script>') }),
	s("vts", fmt('<script setup lang="ts">{}</script>', { i(1) })),
	s("tem", fmt("<template>{}</template>", { i(1) })),
	s("pcs", fmt('<style scoped lang="postcss">{}</style>', { i(1) })),

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

	s("clg", fmt("console.log({})", { i(1) })),

	-- Vues
	s(
		"rf",
		fmt("const {var} = ref{ref}", {
			var = i(1),
			ref = sn(
				2,
				fmt("{generic}({default})", {
					generic = c(1, {
						t(""),
						sn(nil, fmt("<{}>", { i(1) })),
					}),
					default = i(2),
				})
			),
		})
	),

	s(
		"rc",
		fmt("const {var} = reactive{reactive}", {
			var = i(1),
			reactive = sn(
				2,
				fmt("{generic}({default})", {
					generic = c(1, {
						t(""),
						sn(nil, fmt("<{}>", { i(1) })),
					}),
					default = i(2),
				})
			),
		})
	),

	s(
		"pr",
		fmt("const {v} = defineProps<{p}>()", {
			p = i(1),
			v = c(2, {
				sn(nil, fmt("{{ {} }}", { i(1) })),
				t("props"),
			}),
		})
	),

	s(
		"em",
		fmt("const emit = defineEmits<{{ {p} }}>()", {
			p = i(1),
		})
	),

	s(
		"cm",
		fmt("const {var} = computed{ref}", {
			var = i(1),
			ref = sn(
				2,
				fmt("{generic}(() => {default})", {
					generic = c(1, {
						t(""),
						sn(nil, fmt("<{}>", { i(1) })),
					}),
					default = i(2),
				})
			),
		})
	),
}
