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
  ["flash.nvim"] = {
    config = { "\27LJ\2\n\26\0\1\3\0\1\0\4'\1\0\0\18\2\0\0&\1\2\1L\1\2\0\a\\<\30\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\1À\tjump$\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\1À\15treesitter \0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\1À\vremote+\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\1À\22treesitter_search \0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\1À\vtoggleâ\3\1\0\b\0 \0<6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0003\4\3\0=\4\5\3=\3\a\2B\0\2\0016\0\b\0006\2\0\0'\3\1\0B\0\3\3\14\0\0\0X\2\2€2\0\0€K\0\1\0006\2\t\0009\2\n\0029\2\v\0025\4\f\0'\5\r\0003\6\14\0005\a\15\0B\2\5\0016\2\t\0009\2\n\0029\2\v\0025\4\16\0'\5\17\0003\6\18\0005\a\19\0B\2\5\0016\2\t\0009\2\n\0029\2\v\2'\4\20\0'\5\21\0003\6\22\0005\a\23\0B\2\5\0016\2\t\0009\2\n\0029\2\v\0025\4\24\0'\5\25\0003\6\26\0005\a\27\0B\2\5\0016\2\t\0009\2\n\0029\2\v\0025\4\28\0'\5\29\0003\6\30\0005\a\31\0B\2\5\0012\0\0€K\0\1\0\1\0\1\tdesc\24Toggle Flash Search\0\n<c-s>\1\2\0\0\6c\1\0\1\tdesc\28Flash Treesitter Search\0\6R\1\3\0\0\6o\6x\1\0\1\tdesc\17Remote Flash\0\6r\6o\1\0\1\tdesc\21Flash Treesitter\0\6F\1\4\0\0\6n\6o\6x\1\0\1\tdesc\nFlash\0\6f\1\4\0\0\6n\6x\6o\bset\vkeymap\bvim\npcall\vsearch\1\0\0\tmode\1\0\0\0\nsetup\nflash\frequire\0" },
    loaded = true,
    path = "/Users/louis.andrew/.local/share/nvim/site/pack/packer/start/flash.nvim",
    url = "https://github.com/folke/flash.nvim"
  },
  ["oil.nvim"] = {
    config = { "\27LJ\2\n1\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\boil\frequire\0" },
    loaded = true,
    path = "/Users/louis.andrew/.local/share/nvim/site/pack/packer/start/oil.nvim",
    url = "https://github.com/stevearc/oil.nvim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/louis.andrew/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["vim-visual-multi"] = {
    loaded = true,
    path = "/Users/louis.andrew/.local/share/nvim/site/pack/packer/start/vim-visual-multi",
    url = "https://github.com/mg979/vim-visual-multi"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: flash.nvim
time([[Config for flash.nvim]], true)
try_loadstring("\27LJ\2\n\26\0\1\3\0\1\0\4'\1\0\0\18\2\0\0&\1\2\1L\1\2\0\a\\<\30\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\1À\tjump$\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\1À\15treesitter \0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\1À\vremote+\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\1À\22treesitter_search \0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\1À\vtoggleâ\3\1\0\b\0 \0<6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0003\4\3\0=\4\5\3=\3\a\2B\0\2\0016\0\b\0006\2\0\0'\3\1\0B\0\3\3\14\0\0\0X\2\2€2\0\0€K\0\1\0006\2\t\0009\2\n\0029\2\v\0025\4\f\0'\5\r\0003\6\14\0005\a\15\0B\2\5\0016\2\t\0009\2\n\0029\2\v\0025\4\16\0'\5\17\0003\6\18\0005\a\19\0B\2\5\0016\2\t\0009\2\n\0029\2\v\2'\4\20\0'\5\21\0003\6\22\0005\a\23\0B\2\5\0016\2\t\0009\2\n\0029\2\v\0025\4\24\0'\5\25\0003\6\26\0005\a\27\0B\2\5\0016\2\t\0009\2\n\0029\2\v\0025\4\28\0'\5\29\0003\6\30\0005\a\31\0B\2\5\0012\0\0€K\0\1\0\1\0\1\tdesc\24Toggle Flash Search\0\n<c-s>\1\2\0\0\6c\1\0\1\tdesc\28Flash Treesitter Search\0\6R\1\3\0\0\6o\6x\1\0\1\tdesc\17Remote Flash\0\6r\6o\1\0\1\tdesc\21Flash Treesitter\0\6F\1\4\0\0\6n\6o\6x\1\0\1\tdesc\nFlash\0\6f\1\4\0\0\6n\6x\6o\bset\vkeymap\bvim\npcall\vsearch\1\0\0\tmode\1\0\0\0\nsetup\nflash\frequire\0", "config", "flash.nvim")
time([[Config for flash.nvim]], false)
-- Config for: oil.nvim
time([[Config for oil.nvim]], true)
try_loadstring("\27LJ\2\n1\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\boil\frequire\0", "config", "oil.nvim")
time([[Config for oil.nvim]], false)
-- Config for: Comment.nvim
time([[Config for Comment.nvim]], true)
try_loadstring("\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fComment\frequire\0", "config", "Comment.nvim")
time([[Config for Comment.nvim]], false)

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
