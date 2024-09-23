local block = "n-c:block-Cursor,i-ci:ver10-iCursor,v:hor100-vCursor,o:hor50-pCursor,r:hor100-rCursor"
local statuscolumn =
	'%s%=%{v:relnum?v:relnum:v:lnum} %#FoldColumn#%{foldlevel(v:lnum) > foldlevel(v:lnum - 1) ? (foldclosed(v:lnum) == -1 ? " " : " ") : "  " }%*'

return {
	statuscolumn = statuscolumn,
	nu = true,
	rnu = true,
	numberwidth = 1,

	-- indents etc
	tabstop = 2,
	softtabstop = 2,
	shiftwidth = 2,
	expandtab = true,
	autoindent = true,
	wrap = false,
	laststatus = 3,
	smartindent = true,

	-- search
	ignorecase = true,
	smartcase = true,

	-- backspace
	backspace = "indent,eol,start",

	-- split
	splitright = true,
	splitbelow = true,
	background = "dark", -- set this to dark or light
	cursorline = true,
	cursorlineopt = "number",
	guicursor = block,
	undofile = true,
}
