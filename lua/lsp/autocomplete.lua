local cmp = require("cmp")

local cmp_kinds = {
	Text = "  ",
	Method = "  ",
	Function = "  ",
	Constructor = "  ",
	Field = "  ",
	Variable = "  ",
	Class = "  ",
	Interface = "  ",
	Module = "  ",
	Property = "  ",
	Unit = "  ",
	Value = "  ",
	Enum = "  ",
	Keyword = "  ",
	Snippet = " ",
	Color = "  ",
	File = "  ",
	Reference = "  ",
	Folder = "  ",
	EnumMember = "  ",
	Constant = "  ",
	Struct = "  ",
	Event = "  ",
	Operator = "  ",
	TypeParameter = "  ",
}

local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	window = {
		completion = {
			col_offset = 1,
			side_padding = 1,
			border = "rounded",
			winhighlight = "Normal:cmpmenu,FloatBorder:cmpborder,Search:None",
		},
		documentation = { -- no border; native-style scrollbar
			border = "rounded",
			side_padding = 1,
			winhighlight = "Normal:cmpmenu,FloatBorder:cmpborder,Search:None",
		},
	},
	sources = {
		{
			name = "nvim_lsp",
			entry_filter = function(entry)
				-- Disable snippets from LSP
				return cmp.lsp.CompletionItemKind.Snippet ~= entry:get_kind()
			end,
		},
		-- { name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "path" },
		{ name = "luasnip" },
	},
	formatting = {
		format = function(entry, vim_item)
			-- This concatonates the icons with the name of the item kind
			vim_item.kind = string.format("      %s %s", cmp_kinds[vim_item.kind], vim_item.kind:lower())
			vim_item.menu = ({
				nvim_lsp = "[LSP]",
				nvim_lua = "[Lua]",
				luasnip = "[Snip]",
				buffer = "[Buf]",
				path = "[Path]",
			})[entry.source.name]
			return vim_item
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
		["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
		["<cr>"] = cmp.mapping.confirm({ select = true }),
		["<C-e>"] = cmp.mapping.complete(),
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
	}),
})
