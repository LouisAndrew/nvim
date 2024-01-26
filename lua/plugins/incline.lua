return {
	"b0o/incline.nvim",
	event = "VeryLazy",
	config = function()
		local icons = require("theme.icons")
		local function get_diagnostic_label(props)
			local severity_icons = {
				Error = icons.Error,
				Warn = icons.Warn,
				Info = icons.Info,
				Hint = icons.Hint,
			}

			local label = {}
			for severity, icon in pairs(severity_icons) do
				local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
				if n > 0 then
					local fg = "#"
						.. string.format(
							"%06x",
							vim.api.nvim_get_hl_by_name("DiagnosticSign" .. severity, true)["foreground"]
						)
					table.insert(label, { icon .. " " .. n .. " ", guifg = fg })
				end
			end
			return label
		end

		require("incline").setup({
			render = function(props)
				local bufname = vim.api.nvim_buf_get_name(props.buf)
				local filename = vim.fn.fnamemodify(bufname, ":t")

				if filename == "" then
					return {}
				end

				local diagnostics = get_diagnostic_label(props)
				local modified = vim.api.nvim_buf_get_option(props.buf, "modified") and " " .. icons.Modified or ""
				local filetype_icon = require("nvim-web-devicons").get_icon_color(filename)

				local buffer = {
					{ filetype_icon .. " " },
					{ filename .. modified },
				}

				if #diagnostics > 0 then
					table.insert(diagnostics, { "| ", guifg = "grey" })
				end
				for _, buffer_ in ipairs(buffer) do
					table.insert(diagnostics, buffer_)
				end

				return diagnostics
			end,

			window = {
				margin = {
					horizontal = 1,
					vertical = 0,
				},
				padding = 2,
				placement = {
					horizontal = "right",
					vertical = "top",
				},
				width = "fit",
				zindex = 50,
			},
		})
	end,
}
