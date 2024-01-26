return {
	"b0o/incline.nvim",
	event = "VeryLazy",
	config = function()
		local icons = require("theme.icons")
		local colors = require("colors")

		local function get_diagnostic_fg(props)
			local diag_severity = {
				"Error",
				"Warn",
			}

			for _, severity in pairs(diag_severity) do
				local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
				if n > 0 then
					local fg = props.focused and colors.diag[severity] or colors.diag[severity .. "Inactive"]

					return fg
				end
			end

			return nil
		end

		require("incline").setup({
			render = function(props)
				local bufname = vim.api.nvim_buf_get_name(props.buf)
				local filename = vim.fn.fnamemodify(bufname, ":t")

				if filename == "" then
					return {}
				end

				local fg = get_diagnostic_fg(props)
				local modified = vim.api.nvim_buf_get_option(props.buf, "modified") and icons.Modified or ""
				local filetype_icon = require("nvim-web-devicons").get_icon_color(filename)

				local fileinfo = {
					{ modified, guifg = fg },
					{ filetype_icon .. " ", guifg = fg },
					{ filename, guifg = fg },
				}

				local buffer = {}

				for _, content in ipairs(fileinfo) do
					table.insert(buffer, content)
				end

				return buffer
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
