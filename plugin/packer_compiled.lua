-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/louis.andrew/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/louis.andrew/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/louis.andrew/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/louis.andrew/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/louis.andrew/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    config = { "\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fComment\frequire\0" },
    loaded = true,
    path = "/Users/louis.andrew/.local/share/nvim/site/pack/packer/start/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  LuaSnip = {
    loaded = true,
    path = "/Users/louis.andrew/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["autoclose.nvim"] = {
    loaded = true,
    path = "/Users/louis.andrew/.local/share/nvim/site/pack/packer/start/autoclose.nvim",
    url = "https://github.com/m4xshen/autoclose.nvim"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/Users/louis.andrew/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/Users/louis.andrew/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/Users/louis.andrew/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["colorbuddy.nvim"] = {
    loaded = true,
    path = "/Users/louis.andrew/.local/share/nvim/site/pack/packer/start/colorbuddy.nvim",
    url = "https://github.com/tjdevries/colorbuddy.nvim"
  },
  ["copilot.vim"] = {
    loaded = true,
    path = "/Users/louis.andrew/.local/share/nvim/site/pack/packer/start/copilot.vim",
    url = "https://github.com/github/copilot.vim"
  },
  ["diffview.nvim"] = {
    loaded = true,
    path = "/Users/louis.andrew/.local/share/nvim/site/pack/packer/start/diffview.nvim",
    url = "https://github.com/sindrets/diffview.nvim"
  },
  ["flash.nvim"] = {
    config = { "\27LJ\2\n\30\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\1À\tjump$\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\1À\15treesitter \0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\1À\vremote+\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\1À\22treesitter_search \0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\1À\vtoggle¿\3\1\0\b\0\27\00086\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\0016\0\3\0006\2\0\0'\3\1\0B\0\3\3\14\0\0\0X\2\1€2\0*€6\2\4\0009\2\5\0029\2\6\0025\4\a\0'\5\b\0003\6\t\0005\a\n\0B\2\5\0016\2\4\0009\2\5\0029\2\6\0025\4\v\0'\5\f\0003\6\r\0005\a\14\0B\2\5\0016\2\4\0009\2\5\0029\2\6\2'\4\15\0'\5\16\0003\6\17\0005\a\18\0B\2\5\0016\2\4\0009\2\5\0029\2\6\0025\4\19\0'\5\20\0003\6\21\0005\a\22\0B\2\5\0016\2\4\0009\2\5\0029\2\6\0025\4\23\0'\5\24\0003\6\25\0005\a\26\0B\2\5\0012\0\0€K\0\1\0K\0\1\0\1\0\1\tdesc\24Toggle Flash Search\0\n<c-s>\1\2\0\0\6c\1\0\1\tdesc\28Flash Treesitter Search\0\6R\1\3\0\0\6o\6x\1\0\1\tdesc\17Remote Flash\0\6r\6o\1\0\1\tdesc\21Flash Treesitter\0\6F\1\4\0\0\6n\6o\6x\1\0\1\tdesc\nFlash\0\6f\1\4\0\0\6n\6x\6o\bset\vkeymap\bvim\npcall\nsetup\nflash\frequire\0" },
    loaded = true,
    path = "/Users/louis.andrew/.local/share/nvim/site/pack/packer/start/flash.nvim",
    url = "https://github.com/folke/flash.nvim"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/Users/louis.andrew/.local/share/nvim/site/pack/packer/start/friendly-snippets",
    url = "https://github.com/rafamadriz/friendly-snippets"
  },
  ["fzf-lua"] = {
    loaded = true,
    path = "/Users/louis.andrew/.local/share/nvim/site/pack/packer/start/fzf-lua",
    url = "https://github.com/ibhagwan/fzf-lua"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rgitsigns\frequire\0" },
    loaded = true,
    path = "/Users/louis.andrew/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["guard-collection"] = {
    loaded = true,
    path = "/Users/louis.andrew/.local/share/nvim/site/pack/packer/start/guard-collection",
    url = "https://github.com/nvimdev/guard-collection"
  },
  ["guard.nvim"] = {
    loaded = true,
    path = "/Users/louis.andrew/.local/share/nvim/site/pack/packer/start/guard.nvim",
    url = "https://github.com/nvimdev/guard.nvim"
  },
  ["lsp-zero.nvim"] = {
    loaded = true,
    path = "/Users/louis.andrew/.local/share/nvim/site/pack/packer/start/lsp-zero.nvim",
    url = "https://github.com/VonHeikemen/lsp-zero.nvim"
  },
  ["lspkind.nvim"] = {
    loaded = true,
    path = "/Users/louis.andrew/.local/share/nvim/site/pack/packer/start/lspkind.nvim",
    url = "https://github.com/onsails/lspkind.nvim"
  },
  ["lspsaga.nvim"] = {
    config = { "\27LJ\2\n9\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\flspsaga\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/Users/louis.andrew/.local/share/nvim/site/pack/packer/opt/lspsaga.nvim",
    url = "https://github.com/nvimdev/lspsaga.nvim"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/Users/louis.andrew/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["mason-lspconfig.nvim"] = {
    loaded = true,
    path = "/Users/louis.andrew/.local/share/nvim/site/pack/packer/start/mason-lspconfig.nvim",
    url = "https://github.com/williamboman/mason-lspconfig.nvim"
  },
  ["mason.nvim"] = {
    loaded = true,
    path = "/Users/louis.andrew/.local/share/nvim/site/pack/packer/start/mason.nvim",
    url = "https://github.com/williamboman/mason.nvim"
  },
  neogit = {
    loaded = true,
    path = "/Users/louis.andrew/.local/share/nvim/site/pack/packer/start/neogit",
    url = "https://github.com/NeogitOrg/neogit"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "/Users/louis.andrew/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/louis.andrew/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-noirbuddy"] = {
    loaded = true,
    path = "/Users/louis.andrew/.local/share/nvim/site/pack/packer/start/nvim-noirbuddy",
    url = "https://github.com/jesseleite/nvim-noirbuddy"
  },
  ["nvim-surround"] = {
    config = { "\27LJ\2\n?\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\18nvim-surround\frequire\0" },
    loaded = true,
    path = "/Users/louis.andrew/.local/share/nvim/site/pack/packer/start/nvim-surround",
    url = "https://github.com/kylechui/nvim-surround"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/Users/louis.andrew/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-textobjects"] = {
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/Users/louis.andrew/.local/share/nvim/site/pack/packer/opt/nvim-treesitter-textobjects",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"
  },
  ["nvim-ts-autotag"] = {
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/Users/louis.andrew/.local/share/nvim/site/pack/packer/opt/nvim-ts-autotag",
    url = "https://github.com/windwp/nvim-ts-autotag"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/louis.andrew/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/nvim-tree/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/louis.andrew/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  playground = {
    loaded = true,
    path = "/Users/louis.andrew/.local/share/nvim/site/pack/packer/start/playground",
    url = "https://github.com/nvim-treesitter/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/louis.andrew/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["rainbow-delimiters.nvim"] = {
    loaded = true,
    path = "/Users/louis.andrew/.local/share/nvim/site/pack/packer/start/rainbow-delimiters.nvim",
    url = "https://github.com/HiPhish/rainbow-delimiters.nvim"
  },
  ["startup.nvim"] = {
    config = { "\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fstartup\frequire\0" },
    loaded = true,
    path = "/Users/louis.andrew/.local/share/nvim/site/pack/packer/start/startup.nvim",
    url = "https://github.com/startup-nvim/startup.nvim"
  },
  ["telescope-file-browser.nvim"] = {
    loaded = true,
    path = "/Users/louis.andrew/.local/share/nvim/site/pack/packer/start/telescope-file-browser.nvim",
    url = "https://github.com/nvim-telescope/telescope-file-browser.nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/Users/louis.andrew/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/Users/louis.andrew/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  undotree = {
    loaded = true,
    path = "/Users/louis.andrew/.local/share/nvim/site/pack/packer/start/undotree",
    url = "https://github.com/mbbill/undotree"
  },
  ["vim-visual-multi"] = {
    loaded = true,
    path = "/Users/louis.andrew/.local/share/nvim/site/pack/packer/start/vim-visual-multi",
    url = "https://github.com/mg979/vim-visual-multi"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: Comment.nvim
time([[Config for Comment.nvim]], true)
try_loadstring("\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fComment\frequire\0", "config", "Comment.nvim")
time([[Config for Comment.nvim]], false)
-- Config for: nvim-surround
time([[Config for nvim-surround]], true)
try_loadstring("\27LJ\2\n?\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\18nvim-surround\frequire\0", "config", "nvim-surround")
time([[Config for nvim-surround]], false)
-- Config for: flash.nvim
time([[Config for flash.nvim]], true)
try_loadstring("\27LJ\2\n\30\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\1À\tjump$\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\1À\15treesitter \0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\1À\vremote+\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\1À\22treesitter_search \0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\1À\vtoggle¿\3\1\0\b\0\27\00086\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\0016\0\3\0006\2\0\0'\3\1\0B\0\3\3\14\0\0\0X\2\1€2\0*€6\2\4\0009\2\5\0029\2\6\0025\4\a\0'\5\b\0003\6\t\0005\a\n\0B\2\5\0016\2\4\0009\2\5\0029\2\6\0025\4\v\0'\5\f\0003\6\r\0005\a\14\0B\2\5\0016\2\4\0009\2\5\0029\2\6\2'\4\15\0'\5\16\0003\6\17\0005\a\18\0B\2\5\0016\2\4\0009\2\5\0029\2\6\0025\4\19\0'\5\20\0003\6\21\0005\a\22\0B\2\5\0016\2\4\0009\2\5\0029\2\6\0025\4\23\0'\5\24\0003\6\25\0005\a\26\0B\2\5\0012\0\0€K\0\1\0K\0\1\0\1\0\1\tdesc\24Toggle Flash Search\0\n<c-s>\1\2\0\0\6c\1\0\1\tdesc\28Flash Treesitter Search\0\6R\1\3\0\0\6o\6x\1\0\1\tdesc\17Remote Flash\0\6r\6o\1\0\1\tdesc\21Flash Treesitter\0\6F\1\4\0\0\6n\6o\6x\1\0\1\tdesc\nFlash\0\6f\1\4\0\0\6n\6x\6o\bset\vkeymap\bvim\npcall\nsetup\nflash\frequire\0", "config", "flash.nvim")
time([[Config for flash.nvim]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rgitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Config for: startup.nvim
time([[Config for startup.nvim]], true)
try_loadstring("\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fstartup\frequire\0", "config", "startup.nvim")
time([[Config for startup.nvim]], false)
-- Load plugins in order defined by `after`
time([[Sequenced loading]], true)
vim.cmd [[ packadd nvim-treesitter ]]
vim.cmd [[ packadd nvim-treesitter-textobjects ]]
vim.cmd [[ packadd nvim-ts-autotag ]]
vim.cmd [[ packadd nvim-lspconfig ]]
vim.cmd [[ packadd lspsaga.nvim ]]

-- Config for: lspsaga.nvim
try_loadstring("\27LJ\2\n9\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\flspsaga\frequire\0", "config", "lspsaga.nvim")

time([[Sequenced loading]], false)

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
