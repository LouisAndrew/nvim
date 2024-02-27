local cmp = require("cmp")

local special_chars = require("theme.special_chars")
local cmp_kinds = require("theme.icons")

local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	window = {
		completion = {
			col_offset = 1,
			side_padding = 1,
			winhighlight = "Normal:cmpmenu,FloatBorder:cmpborder,Search:None",
		},
		documentation = {
			border = special_chars.create_special_border({
				side_padding = true,
				padding_char = special_chars.full_block,
				hide_vertical_padding = true,
			}),
			winhighlight = "Normal:cmpmenu,FloatBorder:cmpborder,Search:None",
		},
	},
	sources = {
		{
			name = "nvim_lsp",
			entry_filter = function(entry)
				-- Disable snippets from LSP
				local kind = entry:get_kind()
				return cmp.lsp.CompletionItemKind.Snippet ~= kind and cmp.lsp.CompletionItemKind.Text ~= kind
			end,
		},
		{ name = "nvim_lua" },
		{ name = "path" },
		{ name = "luasnip" },
	},
	formatting = {
		format = function(entry, vim_item)
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
		["<C-e>"] = cmp.mapping({
			i = function()
				if cmp.visible() then
					cmp.abort()
				else
					cmp.complete()
				end
			end,
			c = function()
				if cmp.visible() then
					cmp.close()
				else
					cmp.complete()
				end
			end,
		}),
		["<C-6>"] = cmp.mapping.close(),
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
	}),
})

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{
			name = "path",
		},
	}, {
		{
			name = "cmdline",
			option = {
				ignore_cmds = { "Man", "!" },
			},
		},
	}),
})

cmp.setup.cmdline("/", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})
