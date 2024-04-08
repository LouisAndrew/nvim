local ls = require("luasnip")
local s = ls.snippet
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node
local c = ls.choice_node
local t = ls.text_node

return {
	s(
		"gto",
		fmt(
			[[
  func Test{functionName}(t *testing.T) {{
    got := {got}
    want := {want}

    if {test} {{
      t.Errorf("got %v want %v", got, want)
    }}
  }}
  ]],
			{
				functionName = i(1),
				got = i(2),
				want = i(3),
				test = c(4, {
					t("got != want"),
					t("!reflect.DeepEqual(got, want)"),
				}),
			}
		)
	),
	s(
		"tr",
		fmt(
			[[
  t.Run("{name}", func(t *testing.T) {{
    {}
  }})
  ]],
			{
				name = i(1),
				i(2),
			}
		)
	),
}
