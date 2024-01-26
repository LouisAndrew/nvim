local function search_count()
	if vim.api.nvim_get_vvar("hlsearch") == 1 then
		local res = vim.fn.searchcount({ maxcount = 999, timeout = 500 })
		local contents = vim.fn.getreg("/")

		if res.total > 0 then
			return string.format("%s %d/%d", contents, res.current, res.total)
		end
	end

	return ""
end

return {
	search_count = search_count,
}
