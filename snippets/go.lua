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
  t.Run("{name}", func (t *testing.T) {{
    got := {got}
    want := {want}

    if {test} {{
      t.Errorf("got %v want %v", got, want)
    }}
  }})
  ]],
			{
				name = i(1),
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
		"gtr",
		fmt(
			[[
  func Test{functionName}(t *testing.T) {{
    t.Run("{name}", func (t *testing.T) {{
      got := {got}
      want := {want}

      if {test} {{
        t.Errorf("got %v want %v", got, want)
      }}
    }})
  }}
  ]],
			{
				functionName = i(1),
				name = i(2),
				got = i(3),
				want = i(4),
				test = c(5, {
					t("got != want"),
					t("!reflect.DeepEqual(got, want)"),
				}),
			}
		)
	),
}
