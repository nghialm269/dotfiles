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
local package_path_str = "/home/nghialm/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/nghialm/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/nghialm/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/nghialm/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/nghialm/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
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
    config = { "\27LJ\2\n5\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\26plugin-config/comment\frequire\0" },
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  LuaSnip = {
    config = { "\27LJ\2\n(\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\rsnippets\frequire\0" },
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["aerial.nvim"] = {
    config = { "\27LJ\2\n4\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\vaerial\frequire\0" },
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/aerial.nvim",
    url = "https://github.com/stevearc/aerial.nvim"
  },
  ["animation.nvim"] = {
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/animation.nvim",
    url = "https://github.com/anuvyklack/animation.nvim"
  },
  catppuccin = {
    config = { "\27LJ\2\n8\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\29plugin-config/catppuccin\frequire\0" },
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/catppuccin",
    url = "https://github.com/catppuccin/nvim"
  },
  ["ccc.nvim"] = {
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/ccc.nvim",
    url = "https://github.com/uga-rosa/ccc.nvim"
  },
  ["cmp-buffer"] = {
    after_files = { "/home/nghialm/.local/share/nvim/site/pack/packer/opt/cmp-buffer/after/plugin/cmp_buffer.lua" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    after_files = { "/home/nghialm/.local/share/nvim/site/pack/packer/opt/cmp-cmdline/after/plugin/cmp_cmdline.lua" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-cmdline-history"] = {
    after_files = { "/home/nghialm/.local/share/nvim/site/pack/packer/opt/cmp-cmdline-history/after/plugin/cmp_cmdline_history.lua" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/cmp-cmdline-history",
    url = "https://github.com/dmitmel/cmp-cmdline-history"
  },
  ["cmp-dap"] = {
    after_files = { "/home/nghialm/.local/share/nvim/site/pack/packer/opt/cmp-dap/after/plugin/cmp_dap.lua" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/cmp-dap",
    url = "https://github.com/rcarriga/cmp-dap"
  },
  ["cmp-dictionary"] = {
    after_files = { "/home/nghialm/.local/share/nvim/site/pack/packer/opt/cmp-dictionary/after/plugin/cmp_dictionary.lua" },
    config = { "\27LJ\2\nv\0\0\5\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0005\4\3\0=\4\5\3=\3\a\2B\0\2\1K\0\1\0\bdic\1\0\0\6*\1\0\0\1\2\0\0\26/usr/share/dict/words\nsetup\19cmp_dictionary\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/cmp-dictionary",
    url = "https://github.com/uga-rosa/cmp-dictionary"
  },
  ["cmp-nvim-lsp"] = {
    after_files = { "/home/nghialm/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp/after/plugin/cmp_nvim_lsp.lua" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lsp-document-symbol"] = {
    after_files = { "/home/nghialm/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp-document-symbol/after/plugin/cmp_nvim_lsp_document_symbol.lua" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp-document-symbol",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp-document-symbol"
  },
  ["cmp-nvim-lua"] = {
    after_files = { "/home/nghialm/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lua/after/plugin/cmp_nvim_lua.lua" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lua",
    url = "https://github.com/hrsh7th/cmp-nvim-lua"
  },
  ["cmp-path"] = {
    after_files = { "/home/nghialm/.local/share/nvim/site/pack/packer/opt/cmp-path/after/plugin/cmp_path.lua" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  ["cmp-tmux"] = {
    after_files = { "/home/nghialm/.local/share/nvim/site/pack/packer/opt/cmp-tmux/after/plugin/cmp_tmux.vim" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/cmp-tmux",
    url = "https://github.com/andersevenrud/cmp-tmux"
  },
  ["cmp-treesitter"] = {
    after_files = { "/home/nghialm/.local/share/nvim/site/pack/packer/opt/cmp-treesitter/after/plugin/cmp_treesitter.lua" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/cmp-treesitter",
    url = "https://github.com/ray-x/cmp-treesitter"
  },
  cmp_luasnip = {
    after_files = { "/home/nghialm/.local/share/nvim/site/pack/packer/opt/cmp_luasnip/after/plugin/cmp_luasnip.lua" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["csv.vim"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/csv.vim",
    url = "https://github.com/chrisbra/csv.vim"
  },
  ["dart-vim-plugin"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/dart-vim-plugin",
    url = "https://github.com/dart-lang/dart-vim-plugin"
  },
  ["dial.nvim"] = {
    config = { "\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23plugin-config/dial\frequire\0" },
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/dial.nvim",
    url = "https://github.com/monaqa/dial.nvim"
  },
  ["diffview.nvim"] = {
    commands = { "DiffviewOpen", "DiffviewFileHistory" },
    config = { "\27LJ\2\nà\2\0\0\5\0\r\0\0176\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\5\0005\4\4\0=\4\6\0035\4\a\0=\4\b\3=\3\t\0025\3\v\0005\4\n\0=\4\f\3=\3\b\2B\0\2\1K\0\1\0\15merge_tool\1\0\0\1\0\2\24disable_diagnostics\2\vlayout\16diff3_mixed\17key_bindings\tview\1\0\1\6q\27<Cmd>DiffviewClose<CR>\15file_panel\1\0\0\1\0\1\6q\27<Cmd>DiffviewClose<CR>\1\0\1\21enhanced_diff_hl\2\nsetup\rdiffview\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/diffview.nvim",
    url = "https://github.com/sindrets/diffview.nvim"
  },
  ["dressing.nvim"] = {
    config = { "\27LJ\2\nπ\1\0\1\5\0\t\0\0159\1\0\0\a\1\1\0X\1\vÄ5\1\2\0006\2\3\0'\4\4\0B\2\2\0029\2\5\0024\4\0\0B\2\2\2=\2\6\0015\2\a\0=\2\b\1L\1\2\0K\0\1\0\bnui\1\0\2\rrelative\vcursor\14max_width\3(\14telescope\15get_cursor\21telescope.themes\frequire\1\0\1\fbackend\14telescope\15codeaction\tkindc\1\0\5\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0003\4\3\0=\4\5\3=\3\a\2B\0\2\1K\0\1\0\vselect\1\0\0\15get_config\1\0\0\0\nsetup\rdressing\frequire\0" },
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/dressing.nvim",
    url = "https://github.com/stevearc/dressing.nvim"
  },
  ["editorconfig.nvim"] = {
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/editorconfig.nvim",
    url = "https://github.com/gpanders/editorconfig.nvim"
  },
  ["fcitx.vim"] = {
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/fcitx.vim",
    url = "https://github.com/lilydjwg/fcitx.vim"
  },
  ["flutter-tools.nvim"] = {
    loaded = false,
    needs_bufread = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/flutter-tools.nvim",
    url = "https://github.com/akinsho/flutter-tools.nvim"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/friendly-snippets",
    url = "https://github.com/rafamadriz/friendly-snippets"
  },
  ["git-conflict.nvim"] = {
    config = { "\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0>\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0\28All conflicts resolved!\vnotify\bvimÄ\2\1\0\5\0\r\0\0236\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\4\0009\0\5\0009\0\6\0'\2\a\0005\3\b\0003\4\t\0=\4\n\3B\0\3\0016\0\4\0009\0\5\0009\0\6\0'\2\a\0005\3\v\0003\4\f\0=\4\n\3B\0\3\1K\0\1\0\0\1\0\1\fpattern\24GitConflictResolved\rcallback\0\1\0\1\fpattern\24GitConflictDetected\tUser\24nvim_create_autocmd\bapi\bvim\1\0\1\24disable_diagnostics\2\nsetup\17git-conflict\frequire\0" },
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/git-conflict.nvim",
    url = "https://github.com/akinsho/git-conflict.nvim"
  },
  ["gitlinker.nvim"] = {
    config = { "\27LJ\2\nü\3\0\0\6\0\v\0\0216\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\4\0009\0\5\0'\2\4\0'\3\6\0'\4\a\0'\5\b\0B\0\5\0016\0\4\0009\0\5\0'\2\t\0'\3\6\0'\4\n\0'\5\b\0B\0\5\1K\0\1\0{<cmd>lua require\"gitlinker\".get_buf_range_url(\"v\", {action_callback = require\"gitlinker.actions\".open_in_browser})<cr>\6v\24gitlinker: open url{<cmd>lua require\"gitlinker\".get_buf_range_url(\"n\", {action_callback = require\"gitlinker.actions\".open_in_browser})<cr>\15<leader>go\bmap\6n\1\0\1\rmappings\15<leader>gy\nsetup\14gitlinker\frequire\0" },
    keys = { { "", "<leader>gy" }, { "", "<leader>go" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/gitlinker.nvim",
    url = "https://github.com/ruifm/gitlinker.nvim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rgitsigns\frequire\0" },
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["go.nvim"] = {
    config = { "\27LJ\2\n\"\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\0¿\rgoimport\"\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\0¿\rgoimportÀ\2\1\0\t\0\18\0!6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\0\0'\2\4\0B\0\2\0026\1\5\0009\1\6\0019\1\a\1'\3\b\0005\4\v\0006\5\5\0009\5\6\0059\5\t\5'\a\n\0004\b\0\0B\5\3\2=\5\f\0043\5\r\0=\5\14\4B\1\3\0016\1\5\0009\1\6\0019\1\15\1'\3\16\0003\4\17\0004\5\0\0B\1\4\0012\0\0ÄK\0\1\0\0\vFormat\29nvim_create_user_command\rcallback\0\ngroup\1\0\1\fpattern\t*.go\14LspFormat\24nvim_create_augroup\16BufWritePre\24nvim_create_autocmd\bapi\bvim\14go.format\1\0\2\rgoimport\ngopls\ngofmt\ngopls\nsetup\ago\frequire\0" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/go.nvim",
    url = "https://github.com/ray-x/go.nvim"
  },
  ["guihua.lua"] = {
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/guihua.lua",
    url = "https://github.com/ray-x/guihua.lua"
  },
  ["hlargs.nvim"] = {
    config = { "\27LJ\2\n4\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\vhlargs\frequire\0" },
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/hlargs.nvim",
    url = "https://github.com/m-demare/hlargs.nvim"
  },
  ["impatient.nvim"] = {
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/impatient.nvim",
    url = "https://github.com/lewis6991/impatient.nvim"
  },
  ["indent-blankline.nvim"] = {
    config = { "\27LJ\2\nÒ\4\0\0\4\0\n\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0=\3\t\2B\0\2\1K\0\1\0\20buftype_exclude\1\3\0\0\rterminal\vnofile\21filetype_exclude\1\22\0\0\rstartify\14dashboard\16dotooagenda\blog\rfugitive\14gitcommit\vpacker\fvimwiki\rmarkdown\tjson\btxt\nvista\thelp\ftodoist\rNvimTree\rpeekaboo\bgit\20TelescopePrompt\rundotree\24flutterToolsOutline\5\24char_highlight_list\1\a\0\0\27IndentBlanklineIndent1\27IndentBlanklineIndent2\27IndentBlanklineIndent3\27IndentBlanklineIndent4\27IndentBlanklineIndent5\27IndentBlanklineIndent6\1\0\6\tchar\b‚îä\28show_first_indent_level\2#show_trailing_blankline_indent\1\25show_current_context\2\31show_current_context_start\2\25space_char_blankline\6 \nsetup\21indent_blankline\frequire\0" },
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["iswap.nvim"] = {
    config = { "\27LJ\2\nˆ\1\0\0\5\0\f\0\0256\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\4\0009\0\5\0'\2\4\0'\3\6\0'\4\a\0B\0\4\0016\0\4\0009\0\5\0'\2\4\0'\3\b\0'\4\t\0B\0\4\0016\0\4\0009\0\5\0'\2\4\0'\3\n\0'\4\v\0B\0\4\1K\0\1\0 <cmd>ISwapNodeWithRight<CR>\ag>\31<cmd>ISwapNodeWithLeft<CR>\ag<\27<cmd>ISwapNodeWith<CR>\ags\bmap\6n\1\0\2\rautoswap\2\16move_cursor\2\nsetup\niswap\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/iswap.nvim",
    url = "https://github.com/mizlan/iswap.nvim"
  },
  ["leap.nvim"] = {
    config = { "\27LJ\2\n@\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\24set_default_keymaps\tleap\frequire\0" },
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/leap.nvim",
    url = "https://github.com/ggandor/leap.nvim"
  },
  ["lsp_lines.nvim"] = {
    config = { "\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14lsp_lines\frequire\0" },
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/lsp_lines.nvim",
    url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/lspkind-nvim",
    url = "https://github.com/onsails/lspkind-nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\n*\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\15statusline\frequire\0" },
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  middleclass = {
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/middleclass",
    url = "https://github.com/anuvyklack/middleclass"
  },
  neogit = {
    commands = { "Neogit" },
    config = { "\27LJ\2\n4\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\25plugin-config/neogit\frequire\0" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/neogit",
    url = "https://github.com/TimUntersberger/neogit"
  },
  neotest = {
    config = { "\27LJ\2\n5\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\26plugin-config/neotest\frequire\0" },
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/neotest",
    url = "https://github.com/nvim-neotest/neotest"
  },
  ["neotest-go"] = {
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/neotest-go",
    url = "https://github.com/nvim-neotest/neotest-go"
  },
  ["noice.nvim"] = {
    config = { "\27LJ\2\n3\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\24plugin-config/noice\frequire\0" },
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/noice.nvim",
    url = "https://github.com/folke/noice.nvim"
  },
  ["nui.nvim"] = {
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/nui.nvim",
    url = "https://github.com/MunifTanjim/nui.nvim"
  },
  ["null-ls.nvim"] = {
    load_after = {
      ["nvim-lsp-ts-utils"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\nU\0\0\4\0\5\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0004\3\0\0=\3\4\2B\0\2\1K\0\1\0\14fast_wrap\1\0\0\nsetup\19nvim-autopairs\frequire\0" },
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-bqf"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/nvim-bqf",
    url = "https://github.com/kevinhwang91/nvim-bqf"
  },
  ["nvim-cmp"] = {
    after = { "cmp-treesitter", "cmp-cmdline", "cmp-cmdline-history", "cmp-path", "cmp-nvim-lua", "cmp-nvim-lsp-document-symbol", "cmp-tmux", "cmp-dictionary", "cmp-buffer", "cmp-dap", "cmp_luasnip", "cmp-nvim-lsp" },
    config = { "\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22plugin-config/cmp\frequire\0" },
    loaded = true,
    only_config = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-dap"] = {
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/nvim-dap",
    url = "https://github.com/mfussenegger/nvim-dap"
  },
  ["nvim-dap-go"] = {
    config = { "\27LJ\2\n4\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\vdap-go\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/nvim-dap-go",
    url = "https://github.com/leoluz/nvim-dap-go"
  },
  ["nvim-dap-python"] = {
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/nvim-dap-python",
    url = "https://github.com/mfussenegger/nvim-dap-python"
  },
  ["nvim-dap-ui"] = {
    config = { "\27LJ\2\n\30\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\1¿\topen\31\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\1¿\nclose\31\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\1¿\nclose∑\5\1\0\t\0\"\0=6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\2\3\1B\2\1\0016\2\4\0009\2\5\0029\2\6\2\18\3\2\0'\5\a\0005\6\b\0B\3\3\1\18\3\2\0'\5\t\0005\6\n\0B\3\3\1\18\3\2\0'\5\v\0005\6\f\0B\3\3\0016\3\r\0009\3\14\3'\5\r\0'\6\15\0009\a\16\1'\b\17\0B\3\5\0016\3\r\0009\3\14\3'\5\r\0'\6\18\0009\a\19\1'\b\20\0B\3\5\0016\3\r\0009\3\14\3'\5\r\0'\6\21\0009\a\22\1'\b\23\0B\3\5\0019\3\24\0009\3\25\0039\3\26\0033\4\28\0=\4\27\0039\3\24\0009\3\29\0039\3\30\0033\4\31\0=\4\27\0039\3\24\0009\3\29\0039\3 \0033\4!\0=\4\27\0032\0\0ÄK\0\1\0\0\17event_exited\0\21event_terminated\vbefore\0\17dapui_config\22event_initialized\nafter\14listeners\18dapui: toggle\vtoggle\21<localleader>dut\17dapui: close\nclose\21<localleader>duc\16dapui: open\topen\21<localleader>duo\bmap\6n\1\0\4\ttext\b‚óÜ\nnumhl\5\vlinehl\5\vtexthl\16DapLogPoint\16DapLogPoint\1\0\4\ttext\b‚óè\nnumhl\5\vlinehl\5\vtexthl\27DapBreakpointCondition\27DapBreakpointCondition\1\0\4\ttext\b‚óè\nnumhl\5\vlinehl\5\vtexthl\18DapBreakpoint\18DapBreakpoint\16sign_define\afn\bvim\nsetup\ndapui\bdap\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/nvim-dap-ui",
    url = "https://github.com/rcarriga/nvim-dap-ui"
  },
  ["nvim-dap-virtual-text"] = {
    config = { "\27LJ\2\nC\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\26nvim-dap-virtual-text\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/nvim-dap-virtual-text",
    url = "https://github.com/theHamsta/nvim-dap-virtual-text"
  },
  ["nvim-lsp-ts-utils"] = {
    after = { "null-ls.nvim" },
    loaded = false,
    needs_bufread = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/nvim-lsp-ts-utils",
    url = "https://github.com/jose-elias-alvarez/nvim-lsp-ts-utils"
  },
  ["nvim-lspconfig"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-pqf"] = {
    config = { "\27LJ\2\n5\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\bpqf\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/nvim-pqf",
    url = "https://gitlab.com/yorickpeterse/nvim-pqf"
  },
  ["nvim-surround"] = {
    config = { "\27LJ\2\n?\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\18nvim-surround\frequire\0" },
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/nvim-surround",
    url = "https://github.com/kylechui/nvim-surround"
  },
  ["nvim-toggleterm.lua"] = {
    config = { "\27LJ\2\n«\1\0\0\4\0\5\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0004\3\0\0=\3\4\2B\0\2\1K\0\1\0\20shade_filetypes\1\0\a\20shade_terminals\1\14direction\15horizontal\17open_mapping\n<c-\\>\19shading_factor\3\1\tsize\3\20\20start_in_insert\2\17persist_size\2\nsetup\15toggleterm\frequire\0" },
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/nvim-toggleterm.lua",
    url = "https://github.com/akinsho/nvim-toggleterm.lua"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\2\n-\0\0\3\1\2\0\6-\0\0\0009\0\0\0009\0\1\0+\2\2\0B\0\2\1K\0\1\0\0¿\vtoggle\ttreeµ\1\1\0\a\0\n\0\0186\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\0\0'\2\4\0B\0\2\0026\1\5\0009\1\6\1'\3\5\0'\4\a\0003\5\b\0'\6\t\0B\1\5\0012\0\0ÄK\0\1\0\21Toggle file tree\0\n<M-e>\bmap\6n\18nvim-tree.api\1\0\2\19select_prompts\2\18hijack_cursor\2\nsetup\14nvim-tree\frequire\0" },
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/nvim-tree.lua",
    url = "https://github.com/kyazdani42/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    after = { "nvim-ts-rainbow", "nvim-ts-context-commentstring", "nvim-ts-autotag", "vim-matchup", "nvim-dap-virtual-text", "nvim-treesitter-refactor", "nvim-treesitter-textobjects", "iswap.nvim", "playground" },
    config = { "\27LJ\2\n*\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\15treesitter\frequire\0" },
    loaded = true,
    only_config = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-endwise"] = {
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/nvim-treesitter-endwise",
    url = "https://github.com/RRethy/nvim-treesitter-endwise"
  },
  ["nvim-treesitter-refactor"] = {
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/nvim-treesitter-refactor",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-refactor"
  },
  ["nvim-treesitter-textobjects"] = {
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/nvim-treesitter-textobjects",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"
  },
  ["nvim-ts-autotag"] = {
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/nvim-ts-autotag",
    url = "https://github.com/windwp/nvim-ts-autotag"
  },
  ["nvim-ts-context-commentstring"] = {
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/nvim-ts-context-commentstring",
    url = "https://github.com/JoosepAlviste/nvim-ts-context-commentstring"
  },
  ["nvim-ts-rainbow"] = {
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/nvim-ts-rainbow",
    url = "https://github.com/p00f/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["octo.nvim"] = {
    config = { "\27LJ\2\n2\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\tocto\frequire\0" },
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/octo.nvim",
    url = "https://github.com/pwntester/octo.nvim"
  },
  ["overseer.nvim"] = {
    config = { "\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\roverseer\frequire\0" },
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/overseer.nvim",
    url = "https://github.com/stevearc/overseer.nvim"
  },
  ["package-info.nvim"] = {
    config = { "\27LJ\2\nU\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\20package_manager\bnpm\nsetup\17package-info\frequire\0" },
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/package-info.nvim",
    url = "https://github.com/vuki656/package-info.nvim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  playground = {
    commands = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor" },
    load_after = {},
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/playground",
    url = "https://github.com/nvim-treesitter/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["refactoring.nvim"] = {
    config = { "\27LJ\2\nÛ\4\0\0\6\0\25\0+6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\2B\0\2\0016\0\b\0009\0\t\0009\0\n\0'\2\v\0'\3\f\0'\4\r\0005\5\14\0B\0\5\0016\0\b\0009\0\t\0009\0\n\0'\2\15\0'\3\16\0'\4\17\0005\5\18\0B\0\5\0016\0\b\0009\0\t\0009\0\n\0'\2\v\0'\3\19\0'\4\20\0005\5\21\0B\0\5\0016\0\b\0009\0\t\0009\0\n\0'\2\15\0'\3\22\0'\4\23\0005\5\24\0B\0\5\1K\0\1\0\1\0\1\fnoremap\0026:lua require('refactoring').debug.cleanup({})<CR>\15<leader>rc\1\0\1\fnoremap\0028:lua require('refactoring').debug.print_var({})<CR>\15<leader>rv\1\0\1\fnoremap\2B:lua require('refactoring').debug.printf({below = false})<CR>\15<leader>rp\6n\1\0\1\fnoremap\2N<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>\15<leader>rr\6v\20nvim_set_keymap\bapi\bvim\27prompt_func_param_type\1\0\1\ago\2\28prompt_func_return_type\1\0\0\1\0\1\ago\2\nsetup\16refactoring\frequire\0" },
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/refactoring.nvim",
    url = "https://github.com/ThePrimeagen/refactoring.nvim"
  },
  ["replacer.nvim"] = {
    config = { "\27LJ\2\né\1\0\0\6\0\a\0\t6\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0'\4\5\0005\5\6\0B\0\5\1K\0\1\0\1\0\3\fnoremap\2\vnowait\2\vsilent\2':lua require(\"replacer\").run()<cr>\14<leader>h\6n\20nvim_set_keymap\bapi\bvim\0" },
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/replacer.nvim",
    url = "https://github.com/gabrielpoca/replacer.nvim"
  },
  ["rust-tools.nvim"] = {
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/rust-tools.nvim",
    url = "https://github.com/simrat39/rust-tools.nvim"
  },
  ["schemastore.nvim"] = {
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/schemastore.nvim",
    url = "https://github.com/b0o/schemastore.nvim"
  },
  ["splitjoin.vim"] = {
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/splitjoin.vim",
    url = "https://github.com/AndrewRadev/splitjoin.vim"
  },
  ["ssr.nvim"] = {
    config = { "\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22plugin-config.ssr\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/ssr.nvim",
    url = "https://github.com/cshuaimin/ssr.nvim"
  },
  ["substitute.nvim"] = {
    config = { "\27LJ\2\n∏\3\0\0\t\0\20\0C6\0\0\0'\2\1\0B\0\2\0029\1\2\0004\3\0\0B\1\2\0015\1\3\0006\2\4\0009\2\5\2'\4\4\0'\5\6\0009\6\a\0\18\a\1\0B\2\5\0016\2\4\0009\2\5\2'\4\4\0'\5\b\0009\6\t\0\18\a\1\0B\2\5\0016\2\4\0009\2\5\2'\4\4\0'\5\n\0009\6\v\0\18\a\1\0B\2\5\0016\2\4\0009\2\5\2'\4\f\0'\5\6\0009\6\r\0\18\a\1\0B\2\5\0016\2\0\0'\4\14\0B\2\2\0026\3\4\0009\3\5\3'\5\4\0'\6\15\0009\a\a\2\18\b\1\0B\3\5\0016\3\4\0009\3\5\3'\5\4\0'\6\16\0009\a\t\2\18\b\1\0B\3\5\0016\3\4\0009\3\5\3'\5\f\0'\6\17\0009\a\r\2\18\b\1\0B\3\5\0016\3\4\0009\3\5\3'\5\4\0'\6\18\0009\a\19\2\18\b\1\0B\3\5\1K\0\1\0\vcancel\16<leader>sxc\6X\16<leader>sxx\15<leader>sx\24substitute.exchange\vvisual\6x\beol\14<leader>S\tline\15<leader>ss\roperator\14<leader>s\bmap\6n\1\0\1\fnoremap\2\nsetup\15substitute\frequire\0" },
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/substitute.nvim",
    url = "https://github.com/gbprod/substitute.nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope-lsp-handlers.nvim"] = {
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/telescope-lsp-handlers.nvim",
    url = "https://github.com/gbrlsnchs/telescope-lsp-handlers.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\n7\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\28plugin-config/telescope\frequire\0" },
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["todo-comments.nvim"] = {
    config = { "\27LJ\2\n?\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\18todo-comments\frequire\0" },
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/todo-comments.nvim",
    url = "https://github.com/folke/todo-comments.nvim"
  },
  treesj = {
    config = { "\27LJ\2\n4\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\25plugin-config/treesj\frequire\0" },
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/treesj",
    url = "https://github.com/Wansmer/treesj"
  },
  ["trouble.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/trouble.nvim",
    url = "https://github.com/folke/trouble.nvim"
  },
  undotree = {
    commands = { "UndotreeToggle" },
    config = { "vim.g.undotree_SetFocusWhenToggle = 1" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/undotree",
    url = "https://github.com/mbbill/undotree"
  },
  ["vim-abolish"] = {
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/vim-abolish",
    url = "https://github.com/tpope/vim-abolish"
  },
  ["vim-apathy"] = {
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/vim-apathy",
    url = "https://github.com/tpope/vim-apathy"
  },
  ["vim-gui-zoom"] = {
    config = { "\27LJ\2\n∞\1\0\0\6\0\t\0\0256\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0'\4\5\0004\5\0\0B\0\5\0016\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\6\0'\4\5\0004\5\0\0B\0\5\0016\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\a\0'\4\b\0004\5\0\0B\0\5\1K\0\1\0\17:ZoomOut<CR>\n<C-->\n<C-=>\16:ZoomIn<CR>\n<C-+>\6n\20nvim_set_keymap\bapi\bvim\0" },
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/vim-gui-zoom",
    url = "https://github.com/drzel/vim-gui-zoom"
  },
  ["vim-matchup"] = {
    after_files = { "/home/nghialm/.local/share/nvim/site/pack/packer/opt/vim-matchup/after/plugin/matchit.vim" },
    load_after = {},
    loaded = true,
    needs_bufread = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/vim-matchup",
    url = "https://github.com/andymass/vim-matchup"
  },
  ["vim-qf"] = {
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/vim-qf",
    url = "https://github.com/romainl/vim-qf"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/vim-repeat",
    url = "https://github.com/tpope/vim-repeat"
  },
  ["vim-sleuth"] = {
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/vim-sleuth",
    url = "https://github.com/tpope/vim-sleuth"
  },
  ["vim-stay"] = {
    loaded = true,
    needs_bufread = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/vim-stay",
    url = "https://github.com/zhimsel/vim-stay"
  },
  ["vim-tmux-navigator"] = {
    config = { "\27LJ\2\nÁ\3\0\0\6\0\17\0$6\0\0\0009\0\1\0'\2\0\0'\3\2\0'\4\3\0'\5\4\0B\0\5\0016\0\0\0009\0\1\0'\2\0\0'\3\5\0'\4\6\0'\5\a\0B\0\5\0016\0\0\0009\0\1\0'\2\0\0'\3\b\0'\4\t\0'\5\n\0B\0\5\0016\0\0\0009\0\1\0'\2\0\0'\3\v\0'\4\f\0'\5\r\0B\0\5\0016\0\0\0009\0\1\0'\2\0\0'\3\14\0'\4\15\0'\5\16\0B\0\5\1K\0\1\0(Move to previous window / tmux pane\"<cmd>TmuxNavigatePrevious<CR>\n<M-\\>%Move to right window / tmux pane\31<cmd>TmuxNavigateRight<CR>\n<M-l>%Move to above window / tmux pane\28<cmd>TmuxNavigateUp<CR>\n<M-k>%Move to below window / tmux pane\30<cmd>TmuxNavigateDown<CR>\n<M-j>$Move to left window / tmux pane\30<cmd>TmuxNavigateLeft<CR>\n<M-h>\bmap\6n\0" },
    loaded = true,
    needs_bufread = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/vim-tmux-navigator",
    url = "https://github.com/christoomey/vim-tmux-navigator"
  },
  ["vim-unimpaired"] = {
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/vim-unimpaired",
    url = "https://github.com/tpope/vim-unimpaired"
  },
  ["virt-column.nvim"] = {
    config = { "\27LJ\2\nÉ\1\0\0\3\0\6\0\n6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\3\0009\0\4\0'\2\5\0B\0\2\1K\0\1\0006autocmd ColorScheme * highlight clear ColorColumn\bcmd\bvim\nsetup\16virt-column\frequire\0" },
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/virt-column.nvim",
    url = "https://github.com/lukas-reineke/virt-column.nvim"
  },
  ["which-key.nvim"] = {
    config = { "\27LJ\2\n∏\2\0\0\6\0\22\0\0296\0\0\0'\2\1\0B\0\2\0029\1\2\0004\3\0\0B\1\2\0019\1\3\0005\3\r\0005\4\5\0005\5\4\0=\5\6\0045\5\a\0=\5\b\0045\5\t\0=\5\n\0045\5\v\0=\5\f\4=\4\14\0035\4\16\0005\5\15\0=\5\f\0045\5\17\0=\5\18\0045\5\19\0=\5\6\4=\4\20\0035\4\21\0B\1\3\1K\0\1\0\1\0\1\tmode\6n\18<localleader>\1\0\1\tname\t+dap\6t\1\0\1\tname\n+test\1\0\0\1\0\1\tname\t+lsp\r<leader>\1\0\0\6l\1\0\1\tname\n+leap\6f\1\0\1\tname\f+finder\6g\1\0\1\tname\t+git\6d\1\0\0\1\0\1\tname\17+diagnostics\rregister\nsetup\14which-key\frequire\0" },
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/which-key.nvim",
    url = "https://github.com/folke/which-key.nvim"
  },
  ["windows.nvim"] = {
    config = { "\27LJ\2\nÉ\2\0\0\5\0\16\0\0236\0\0\0009\0\1\0)\1\n\0=\1\2\0006\0\0\0009\0\1\0)\1\n\0=\1\3\0006\0\4\0'\2\5\0B\0\2\0029\0\6\0005\2\f\0005\3\b\0005\4\a\0=\4\t\0035\4\n\0=\4\v\3=\3\r\0025\3\14\0=\3\15\2B\0\2\1K\0\1\0\14animation\1\0\1\rduration\3d\vignore\1\0\0\rfiletype\1\6\0\0\rNvimTree\rneo-tree\rundotree\ngundo\vaerial\fbuftype\1\0\0\1\2\0\0\rquickfix\nsetup\fwindows\frequire\16winminwidth\rwinwidth\6o\bvim\0" },
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/windows.nvim",
    url = "https://github.com/anuvyklack/windows.nvim"
  }
}

time([[Defining packer_plugins]], false)
local module_lazy_loads = {
  ["^diffview"] = "diffview.nvim",
  ["^ssr"] = "ssr.nvim"
}
local lazy_load_called = {['packer.load'] = true}
local function lazy_load_module(module_name)
  local to_load = {}
  if lazy_load_called[module_name] then return nil end
  lazy_load_called[module_name] = true
  for module_pat, plugin_name in pairs(module_lazy_loads) do
    if not _G.packer_plugins[plugin_name].loaded and string.match(module_name, module_pat) then
      to_load[#to_load + 1] = plugin_name
    end
  end

  if #to_load > 0 then
    require('packer.load')(to_load, {module = module_name}, _G.packer_plugins)
    local loaded_mod = package.loaded[module_name]
    if loaded_mod then
      return function(modname) return loaded_mod end
    end
  end
end

if not vim.g.packer_custom_loader_enabled then
  table.insert(package.loaders, 1, lazy_load_module)
  vim.g.packer_custom_loader_enabled = true
end

-- Setup for: gitlinker.nvim
time([[Setup for gitlinker.nvim]], true)
try_loadstring("\27LJ\2\nå\1\0\0\5\0\5\0\b6\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\3\0005\4\4\0B\1\3\1K\0\1\0\1\0\2\vprefix\14<leader>g\tmode\6n\1\0\2\6y\24gitlinker: copy url\6o\24gitlinker: open url\rregister\14which-key\frequire\0", "setup", "gitlinker.nvim")
time([[Setup for gitlinker.nvim]], false)
-- Setup for: vim-tmux-navigator
time([[Setup for vim-tmux-navigator]], true)
try_loadstring("\27LJ\2\n<\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1\1\0=\1\2\0K\0\1\0\31tmux_navigator_no_mappings\6g\bvim\0", "setup", "vim-tmux-navigator")
time([[Setup for vim-tmux-navigator]], false)
time([[packadd for vim-tmux-navigator]], true)
vim.cmd [[packadd vim-tmux-navigator]]
time([[packadd for vim-tmux-navigator]], false)
-- Setup for: diffview.nvim
time([[Setup for diffview.nvim]], true)
try_loadstring("\27LJ\2\nb\0\0\6\0\5\0\b6\0\0\0009\0\1\0'\2\0\0'\3\2\0'\4\3\0'\5\4\0B\0\5\1K\0\1\0\24diffview: diff HEAD\26<Cmd>DiffviewOpen<CR>\15<leader>gd\bmap\6n\0", "setup", "diffview.nvim")
time([[Setup for diffview.nvim]], false)
-- Setup for: vim-stay
time([[Setup for vim-stay]], true)
try_loadstring("\27LJ\2\nK\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0,set viewoptions=cursor,folds,slash,unix\bcmd\bvim\0", "setup", "vim-stay")
time([[Setup for vim-stay]], false)
time([[packadd for vim-stay]], true)
vim.cmd [[packadd vim-stay]]
time([[packadd for vim-stay]], false)
-- Setup for: vim-matchup
time([[Setup for vim-matchup]], true)
try_loadstring("\27LJ\2\n>\0\0\2\0\3\0\0056\0\0\0009\0\1\0004\1\0\0=\1\2\0K\0\1\0!matchup_matchparen_offscreen\6g\bvim\0", "setup", "vim-matchup")
time([[Setup for vim-matchup]], false)
-- Config for: replacer.nvim
time([[Config for replacer.nvim]], true)
try_loadstring("\27LJ\2\né\1\0\0\6\0\a\0\t6\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0'\4\5\0005\5\6\0B\0\5\1K\0\1\0\1\0\3\fnoremap\2\vnowait\2\vsilent\2':lua require(\"replacer\").run()<cr>\14<leader>h\6n\20nvim_set_keymap\bapi\bvim\0", "config", "replacer.nvim")
time([[Config for replacer.nvim]], false)
-- Config for: refactoring.nvim
time([[Config for refactoring.nvim]], true)
try_loadstring("\27LJ\2\nÛ\4\0\0\6\0\25\0+6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\2B\0\2\0016\0\b\0009\0\t\0009\0\n\0'\2\v\0'\3\f\0'\4\r\0005\5\14\0B\0\5\0016\0\b\0009\0\t\0009\0\n\0'\2\15\0'\3\16\0'\4\17\0005\5\18\0B\0\5\0016\0\b\0009\0\t\0009\0\n\0'\2\v\0'\3\19\0'\4\20\0005\5\21\0B\0\5\0016\0\b\0009\0\t\0009\0\n\0'\2\15\0'\3\22\0'\4\23\0005\5\24\0B\0\5\1K\0\1\0\1\0\1\fnoremap\0026:lua require('refactoring').debug.cleanup({})<CR>\15<leader>rc\1\0\1\fnoremap\0028:lua require('refactoring').debug.print_var({})<CR>\15<leader>rv\1\0\1\fnoremap\2B:lua require('refactoring').debug.printf({below = false})<CR>\15<leader>rp\6n\1\0\1\fnoremap\2N<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>\15<leader>rr\6v\20nvim_set_keymap\bapi\bvim\27prompt_func_param_type\1\0\1\ago\2\28prompt_func_return_type\1\0\0\1\0\1\ago\2\nsetup\16refactoring\frequire\0", "config", "refactoring.nvim")
time([[Config for refactoring.nvim]], false)
-- Config for: nvim-autopairs
time([[Config for nvim-autopairs]], true)
try_loadstring("\27LJ\2\nU\0\0\4\0\5\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0004\3\0\0=\3\4\2B\0\2\1K\0\1\0\14fast_wrap\1\0\0\nsetup\19nvim-autopairs\frequire\0", "config", "nvim-autopairs")
time([[Config for nvim-autopairs]], false)
-- Config for: package-info.nvim
time([[Config for package-info.nvim]], true)
try_loadstring("\27LJ\2\nU\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\20package_manager\bnpm\nsetup\17package-info\frequire\0", "config", "package-info.nvim")
time([[Config for package-info.nvim]], false)
-- Config for: noice.nvim
time([[Config for noice.nvim]], true)
try_loadstring("\27LJ\2\n3\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\24plugin-config/noice\frequire\0", "config", "noice.nvim")
time([[Config for noice.nvim]], false)
-- Config for: windows.nvim
time([[Config for windows.nvim]], true)
try_loadstring("\27LJ\2\nÉ\2\0\0\5\0\16\0\0236\0\0\0009\0\1\0)\1\n\0=\1\2\0006\0\0\0009\0\1\0)\1\n\0=\1\3\0006\0\4\0'\2\5\0B\0\2\0029\0\6\0005\2\f\0005\3\b\0005\4\a\0=\4\t\0035\4\n\0=\4\v\3=\3\r\0025\3\14\0=\3\15\2B\0\2\1K\0\1\0\14animation\1\0\1\rduration\3d\vignore\1\0\0\rfiletype\1\6\0\0\rNvimTree\rneo-tree\rundotree\ngundo\vaerial\fbuftype\1\0\0\1\2\0\0\rquickfix\nsetup\fwindows\frequire\16winminwidth\rwinwidth\6o\bvim\0", "config", "windows.nvim")
time([[Config for windows.nvim]], false)
-- Config for: which-key.nvim
time([[Config for which-key.nvim]], true)
try_loadstring("\27LJ\2\n∏\2\0\0\6\0\22\0\0296\0\0\0'\2\1\0B\0\2\0029\1\2\0004\3\0\0B\1\2\0019\1\3\0005\3\r\0005\4\5\0005\5\4\0=\5\6\0045\5\a\0=\5\b\0045\5\t\0=\5\n\0045\5\v\0=\5\f\4=\4\14\0035\4\16\0005\5\15\0=\5\f\0045\5\17\0=\5\18\0045\5\19\0=\5\6\4=\4\20\0035\4\21\0B\1\3\1K\0\1\0\1\0\1\tmode\6n\18<localleader>\1\0\1\tname\t+dap\6t\1\0\1\tname\n+test\1\0\0\1\0\1\tname\t+lsp\r<leader>\1\0\0\6l\1\0\1\tname\n+leap\6f\1\0\1\tname\f+finder\6g\1\0\1\tname\t+git\6d\1\0\0\1\0\1\tname\17+diagnostics\rregister\nsetup\14which-key\frequire\0", "config", "which-key.nvim")
time([[Config for which-key.nvim]], false)
-- Config for: virt-column.nvim
time([[Config for virt-column.nvim]], true)
try_loadstring("\27LJ\2\nÉ\1\0\0\3\0\6\0\n6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\3\0009\0\4\0'\2\5\0B\0\2\1K\0\1\0006autocmd ColorScheme * highlight clear ColorColumn\bcmd\bvim\nsetup\16virt-column\frequire\0", "config", "virt-column.nvim")
time([[Config for virt-column.nvim]], false)
-- Config for: catppuccin
time([[Config for catppuccin]], true)
try_loadstring("\27LJ\2\n8\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\29plugin-config/catppuccin\frequire\0", "config", "catppuccin")
time([[Config for catppuccin]], false)
-- Config for: vim-tmux-navigator
time([[Config for vim-tmux-navigator]], true)
try_loadstring("\27LJ\2\nÁ\3\0\0\6\0\17\0$6\0\0\0009\0\1\0'\2\0\0'\3\2\0'\4\3\0'\5\4\0B\0\5\0016\0\0\0009\0\1\0'\2\0\0'\3\5\0'\4\6\0'\5\a\0B\0\5\0016\0\0\0009\0\1\0'\2\0\0'\3\b\0'\4\t\0'\5\n\0B\0\5\0016\0\0\0009\0\1\0'\2\0\0'\3\v\0'\4\f\0'\5\r\0B\0\5\0016\0\0\0009\0\1\0'\2\0\0'\3\14\0'\4\15\0'\5\16\0B\0\5\1K\0\1\0(Move to previous window / tmux pane\"<cmd>TmuxNavigatePrevious<CR>\n<M-\\>%Move to right window / tmux pane\31<cmd>TmuxNavigateRight<CR>\n<M-l>%Move to above window / tmux pane\28<cmd>TmuxNavigateUp<CR>\n<M-k>%Move to below window / tmux pane\30<cmd>TmuxNavigateDown<CR>\n<M-j>$Move to left window / tmux pane\30<cmd>TmuxNavigateLeft<CR>\n<M-h>\bmap\6n\0", "config", "vim-tmux-navigator")
time([[Config for vim-tmux-navigator]], false)
-- Config for: lsp_lines.nvim
time([[Config for lsp_lines.nvim]], true)
try_loadstring("\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14lsp_lines\frequire\0", "config", "lsp_lines.nvim")
time([[Config for lsp_lines.nvim]], false)
-- Config for: leap.nvim
time([[Config for leap.nvim]], true)
try_loadstring("\27LJ\2\n@\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\24set_default_keymaps\tleap\frequire\0", "config", "leap.nvim")
time([[Config for leap.nvim]], false)
-- Config for: aerial.nvim
time([[Config for aerial.nvim]], true)
try_loadstring("\27LJ\2\n4\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\vaerial\frequire\0", "config", "aerial.nvim")
time([[Config for aerial.nvim]], false)
-- Config for: LuaSnip
time([[Config for LuaSnip]], true)
try_loadstring("\27LJ\2\n(\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\rsnippets\frequire\0", "config", "LuaSnip")
time([[Config for LuaSnip]], false)
-- Config for: Comment.nvim
time([[Config for Comment.nvim]], true)
try_loadstring("\27LJ\2\n5\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\26plugin-config/comment\frequire\0", "config", "Comment.nvim")
time([[Config for Comment.nvim]], false)
-- Config for: hlargs.nvim
time([[Config for hlargs.nvim]], true)
try_loadstring("\27LJ\2\n4\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\vhlargs\frequire\0", "config", "hlargs.nvim")
time([[Config for hlargs.nvim]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\n*\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\15treesitter\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: nvim-toggleterm.lua
time([[Config for nvim-toggleterm.lua]], true)
try_loadstring("\27LJ\2\n«\1\0\0\4\0\5\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0004\3\0\0=\3\4\2B\0\2\1K\0\1\0\20shade_filetypes\1\0\a\20shade_terminals\1\14direction\15horizontal\17open_mapping\n<c-\\>\19shading_factor\3\1\tsize\3\20\20start_in_insert\2\17persist_size\2\nsetup\15toggleterm\frequire\0", "config", "nvim-toggleterm.lua")
time([[Config for nvim-toggleterm.lua]], false)
-- Config for: vim-gui-zoom
time([[Config for vim-gui-zoom]], true)
try_loadstring("\27LJ\2\n∞\1\0\0\6\0\t\0\0256\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0'\4\5\0004\5\0\0B\0\5\0016\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\6\0'\4\5\0004\5\0\0B\0\5\0016\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\a\0'\4\b\0004\5\0\0B\0\5\1K\0\1\0\17:ZoomOut<CR>\n<C-->\n<C-=>\16:ZoomIn<CR>\n<C-+>\6n\20nvim_set_keymap\bapi\bvim\0", "config", "vim-gui-zoom")
time([[Config for vim-gui-zoom]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rgitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Config for: treesj
time([[Config for treesj]], true)
try_loadstring("\27LJ\2\n4\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\25plugin-config/treesj\frequire\0", "config", "treesj")
time([[Config for treesj]], false)
-- Config for: neotest
time([[Config for neotest]], true)
try_loadstring("\27LJ\2\n5\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\26plugin-config/neotest\frequire\0", "config", "neotest")
time([[Config for neotest]], false)
-- Config for: git-conflict.nvim
time([[Config for git-conflict.nvim]], true)
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0>\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0\28All conflicts resolved!\vnotify\bvimÄ\2\1\0\5\0\r\0\0236\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\4\0009\0\5\0009\0\6\0'\2\a\0005\3\b\0003\4\t\0=\4\n\3B\0\3\0016\0\4\0009\0\5\0009\0\6\0'\2\a\0005\3\v\0003\4\f\0=\4\n\3B\0\3\1K\0\1\0\0\1\0\1\fpattern\24GitConflictResolved\rcallback\0\1\0\1\fpattern\24GitConflictDetected\tUser\24nvim_create_autocmd\bapi\bvim\1\0\1\24disable_diagnostics\2\nsetup\17git-conflict\frequire\0", "config", "git-conflict.nvim")
time([[Config for git-conflict.nvim]], false)
-- Config for: todo-comments.nvim
time([[Config for todo-comments.nvim]], true)
try_loadstring("\27LJ\2\n?\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\18todo-comments\frequire\0", "config", "todo-comments.nvim")
time([[Config for todo-comments.nvim]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
try_loadstring("\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22plugin-config/cmp\frequire\0", "config", "nvim-cmp")
time([[Config for nvim-cmp]], false)
-- Config for: substitute.nvim
time([[Config for substitute.nvim]], true)
try_loadstring("\27LJ\2\n∏\3\0\0\t\0\20\0C6\0\0\0'\2\1\0B\0\2\0029\1\2\0004\3\0\0B\1\2\0015\1\3\0006\2\4\0009\2\5\2'\4\4\0'\5\6\0009\6\a\0\18\a\1\0B\2\5\0016\2\4\0009\2\5\2'\4\4\0'\5\b\0009\6\t\0\18\a\1\0B\2\5\0016\2\4\0009\2\5\2'\4\4\0'\5\n\0009\6\v\0\18\a\1\0B\2\5\0016\2\4\0009\2\5\2'\4\f\0'\5\6\0009\6\r\0\18\a\1\0B\2\5\0016\2\0\0'\4\14\0B\2\2\0026\3\4\0009\3\5\3'\5\4\0'\6\15\0009\a\a\2\18\b\1\0B\3\5\0016\3\4\0009\3\5\3'\5\4\0'\6\16\0009\a\t\2\18\b\1\0B\3\5\0016\3\4\0009\3\5\3'\5\f\0'\6\17\0009\a\r\2\18\b\1\0B\3\5\0016\3\4\0009\3\5\3'\5\4\0'\6\18\0009\a\19\2\18\b\1\0B\3\5\1K\0\1\0\vcancel\16<leader>sxc\6X\16<leader>sxx\15<leader>sx\24substitute.exchange\vvisual\6x\beol\14<leader>S\tline\15<leader>ss\roperator\14<leader>s\bmap\6n\1\0\1\fnoremap\2\nsetup\15substitute\frequire\0", "config", "substitute.nvim")
time([[Config for substitute.nvim]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
try_loadstring("\27LJ\2\n*\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\15statusline\frequire\0", "config", "lualine.nvim")
time([[Config for lualine.nvim]], false)
-- Config for: nvim-surround
time([[Config for nvim-surround]], true)
try_loadstring("\27LJ\2\n?\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\18nvim-surround\frequire\0", "config", "nvim-surround")
time([[Config for nvim-surround]], false)
-- Config for: dressing.nvim
time([[Config for dressing.nvim]], true)
try_loadstring("\27LJ\2\nπ\1\0\1\5\0\t\0\0159\1\0\0\a\1\1\0X\1\vÄ5\1\2\0006\2\3\0'\4\4\0B\2\2\0029\2\5\0024\4\0\0B\2\2\2=\2\6\0015\2\a\0=\2\b\1L\1\2\0K\0\1\0\bnui\1\0\2\rrelative\vcursor\14max_width\3(\14telescope\15get_cursor\21telescope.themes\frequire\1\0\1\fbackend\14telescope\15codeaction\tkindc\1\0\5\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0003\4\3\0=\4\5\3=\3\a\2B\0\2\1K\0\1\0\vselect\1\0\0\15get_config\1\0\0\0\nsetup\rdressing\frequire\0", "config", "dressing.nvim")
time([[Config for dressing.nvim]], false)
-- Config for: indent-blankline.nvim
time([[Config for indent-blankline.nvim]], true)
try_loadstring("\27LJ\2\nÒ\4\0\0\4\0\n\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0=\3\t\2B\0\2\1K\0\1\0\20buftype_exclude\1\3\0\0\rterminal\vnofile\21filetype_exclude\1\22\0\0\rstartify\14dashboard\16dotooagenda\blog\rfugitive\14gitcommit\vpacker\fvimwiki\rmarkdown\tjson\btxt\nvista\thelp\ftodoist\rNvimTree\rpeekaboo\bgit\20TelescopePrompt\rundotree\24flutterToolsOutline\5\24char_highlight_list\1\a\0\0\27IndentBlanklineIndent1\27IndentBlanklineIndent2\27IndentBlanklineIndent3\27IndentBlanklineIndent4\27IndentBlanklineIndent5\27IndentBlanklineIndent6\1\0\6\tchar\b‚îä\28show_first_indent_level\2#show_trailing_blankline_indent\1\25show_current_context\2\31show_current_context_start\2\25space_char_blankline\6 \nsetup\21indent_blankline\frequire\0", "config", "indent-blankline.nvim")
time([[Config for indent-blankline.nvim]], false)
-- Config for: dial.nvim
time([[Config for dial.nvim]], true)
try_loadstring("\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23plugin-config/dial\frequire\0", "config", "dial.nvim")
time([[Config for dial.nvim]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\2\n7\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\28plugin-config/telescope\frequire\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: overseer.nvim
time([[Config for overseer.nvim]], true)
try_loadstring("\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\roverseer\frequire\0", "config", "overseer.nvim")
time([[Config for overseer.nvim]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
try_loadstring("\27LJ\2\n-\0\0\3\1\2\0\6-\0\0\0009\0\0\0009\0\1\0+\2\2\0B\0\2\1K\0\1\0\0¿\vtoggle\ttreeµ\1\1\0\a\0\n\0\0186\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\0\0'\2\4\0B\0\2\0026\1\5\0009\1\6\1'\3\5\0'\4\a\0003\5\b\0'\6\t\0B\1\5\0012\0\0ÄK\0\1\0\21Toggle file tree\0\n<M-e>\bmap\6n\18nvim-tree.api\1\0\2\19select_prompts\2\18hijack_cursor\2\nsetup\14nvim-tree\frequire\0", "config", "nvim-tree.lua")
time([[Config for nvim-tree.lua]], false)
-- Config for: octo.nvim
time([[Config for octo.nvim]], true)
try_loadstring("\27LJ\2\n2\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\tocto\frequire\0", "config", "octo.nvim")
time([[Config for octo.nvim]], false)
-- Load plugins in order defined by `after`
time([[Sequenced loading]], true)
vim.cmd [[ packadd vim-matchup ]]
vim.cmd [[ packadd iswap.nvim ]]

-- Config for: iswap.nvim
try_loadstring("\27LJ\2\nˆ\1\0\0\5\0\f\0\0256\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\4\0009\0\5\0'\2\4\0'\3\6\0'\4\a\0B\0\4\0016\0\4\0009\0\5\0'\2\4\0'\3\b\0'\4\t\0B\0\4\0016\0\4\0009\0\5\0'\2\4\0'\3\n\0'\4\v\0B\0\4\1K\0\1\0 <cmd>ISwapNodeWithRight<CR>\ag>\31<cmd>ISwapNodeWithLeft<CR>\ag<\27<cmd>ISwapNodeWith<CR>\ags\bmap\6n\1\0\2\rautoswap\2\16move_cursor\2\nsetup\niswap\frequire\0", "config", "iswap.nvim")

vim.cmd [[ packadd nvim-ts-context-commentstring ]]
vim.cmd [[ packadd nvim-ts-rainbow ]]
vim.cmd [[ packadd nvim-treesitter-refactor ]]
vim.cmd [[ packadd nvim-ts-autotag ]]
vim.cmd [[ packadd nvim-treesitter-textobjects ]]
vim.cmd [[ packadd cmp-tmux ]]
vim.cmd [[ packadd cmp-treesitter ]]
vim.cmd [[ packadd cmp-nvim-lsp-document-symbol ]]
vim.cmd [[ packadd cmp-nvim-lua ]]
vim.cmd [[ packadd cmp-path ]]
vim.cmd [[ packadd cmp-cmdline-history ]]
vim.cmd [[ packadd cmp-cmdline ]]
vim.cmd [[ packadd cmp-buffer ]]
vim.cmd [[ packadd cmp_luasnip ]]
vim.cmd [[ packadd cmp-nvim-lsp ]]
vim.cmd [[ packadd cmp-dap ]]
vim.cmd [[ packadd cmp-dictionary ]]

-- Config for: cmp-dictionary
try_loadstring("\27LJ\2\nv\0\0\5\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0005\4\3\0=\4\5\3=\3\a\2B\0\2\1K\0\1\0\bdic\1\0\0\6*\1\0\0\1\2\0\0\26/usr/share/dict/words\nsetup\19cmp_dictionary\frequire\0", "config", "cmp-dictionary")

vim.cmd [[ packadd nvim-dap ]]
vim.cmd [[ packadd nvim-dap-python ]]
vim.cmd [[ packadd nvim-dap-go ]]

-- Config for: nvim-dap-go
try_loadstring("\27LJ\2\n4\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\vdap-go\frequire\0", "config", "nvim-dap-go")

vim.cmd [[ packadd nvim-dap-ui ]]

-- Config for: nvim-dap-ui
try_loadstring("\27LJ\2\n\30\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\1¿\topen\31\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\1¿\nclose\31\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\1¿\nclose∑\5\1\0\t\0\"\0=6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\2\3\1B\2\1\0016\2\4\0009\2\5\0029\2\6\2\18\3\2\0'\5\a\0005\6\b\0B\3\3\1\18\3\2\0'\5\t\0005\6\n\0B\3\3\1\18\3\2\0'\5\v\0005\6\f\0B\3\3\0016\3\r\0009\3\14\3'\5\r\0'\6\15\0009\a\16\1'\b\17\0B\3\5\0016\3\r\0009\3\14\3'\5\r\0'\6\18\0009\a\19\1'\b\20\0B\3\5\0016\3\r\0009\3\14\3'\5\r\0'\6\21\0009\a\22\1'\b\23\0B\3\5\0019\3\24\0009\3\25\0039\3\26\0033\4\28\0=\4\27\0039\3\24\0009\3\29\0039\3\30\0033\4\31\0=\4\27\0039\3\24\0009\3\29\0039\3 \0033\4!\0=\4\27\0032\0\0ÄK\0\1\0\0\17event_exited\0\21event_terminated\vbefore\0\17dapui_config\22event_initialized\nafter\14listeners\18dapui: toggle\vtoggle\21<localleader>dut\17dapui: close\nclose\21<localleader>duc\16dapui: open\topen\21<localleader>duo\bmap\6n\1\0\4\ttext\b‚óÜ\nnumhl\5\vlinehl\5\vtexthl\16DapLogPoint\16DapLogPoint\1\0\4\ttext\b‚óè\nnumhl\5\vlinehl\5\vtexthl\27DapBreakpointCondition\27DapBreakpointCondition\1\0\4\ttext\b‚óè\nnumhl\5\vlinehl\5\vtexthl\18DapBreakpoint\18DapBreakpoint\16sign_define\afn\bvim\nsetup\ndapui\bdap\frequire\0", "config", "nvim-dap-ui")

vim.cmd [[ packadd nvim-dap-virtual-text ]]

-- Config for: nvim-dap-virtual-text
try_loadstring("\27LJ\2\nC\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\26nvim-dap-virtual-text\frequire\0", "config", "nvim-dap-virtual-text")

time([[Sequenced loading]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.api.nvim_create_user_command, 'TSHighlightCapturesUnderCursor', function(cmdargs)
          require('packer.load')({'playground'}, { cmd = 'TSHighlightCapturesUnderCursor', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'playground'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('TSHighlightCapturesUnderCursor ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'DiffviewOpen', function(cmdargs)
          require('packer.load')({'diffview.nvim'}, { cmd = 'DiffviewOpen', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'diffview.nvim'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('DiffviewOpen ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'DiffviewFileHistory', function(cmdargs)
          require('packer.load')({'diffview.nvim'}, { cmd = 'DiffviewFileHistory', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'diffview.nvim'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('DiffviewFileHistory ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'TSPlaygroundToggle', function(cmdargs)
          require('packer.load')({'playground'}, { cmd = 'TSPlaygroundToggle', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'playground'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('TSPlaygroundToggle ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'UndotreeToggle', function(cmdargs)
          require('packer.load')({'undotree'}, { cmd = 'UndotreeToggle', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'undotree'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('UndotreeToggle ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'Neogit', function(cmdargs)
          require('packer.load')({'neogit'}, { cmd = 'Neogit', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'neogit'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('Neogit ', 'cmdline')
      end})
time([[Defining lazy-load commands]], false)

-- Keymap lazy-loads
time([[Defining lazy-load keymaps]], true)
vim.cmd [[noremap <silent> <leader>go <cmd>lua require("packer.load")({'gitlinker.nvim'}, { keys = "<lt>leader>go", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <leader>gy <cmd>lua require("packer.load")({'gitlinker.nvim'}, { keys = "<lt>leader>gy", prefix = "" }, _G.packer_plugins)<cr>]]
time([[Defining lazy-load keymaps]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType csv ++once lua require("packer.load")({'csv.vim'}, { ft = "csv" }, _G.packer_plugins)]]
vim.cmd [[au FileType qf ++once lua require("packer.load")({'nvim-bqf'}, { ft = "qf" }, _G.packer_plugins)]]
vim.cmd [[au FileType dart ++once lua require("packer.load")({'dart-vim-plugin'}, { ft = "dart" }, _G.packer_plugins)]]
vim.cmd [[au FileType go ++once lua require("packer.load")({'go.nvim'}, { ft = "go" }, _G.packer_plugins)]]
vim.cmd [[au FileType gomod ++once lua require("packer.load")({'go.nvim'}, { ft = "gomod" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au BufReadPre * ++once lua require("packer.load")({'nvim-pqf'}, { event = "BufReadPre *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /home/nghialm/.local/share/nvim/site/pack/packer/opt/csv.vim/ftdetect/csv.vim]], true)
vim.cmd [[source /home/nghialm/.local/share/nvim/site/pack/packer/opt/csv.vim/ftdetect/csv.vim]]
time([[Sourcing ftdetect script at: /home/nghialm/.local/share/nvim/site/pack/packer/opt/csv.vim/ftdetect/csv.vim]], false)
time([[Sourcing ftdetect script at: /home/nghialm/.local/share/nvim/site/pack/packer/opt/go.nvim/ftdetect/filetype.vim]], true)
vim.cmd [[source /home/nghialm/.local/share/nvim/site/pack/packer/opt/go.nvim/ftdetect/filetype.vim]]
time([[Sourcing ftdetect script at: /home/nghialm/.local/share/nvim/site/pack/packer/opt/go.nvim/ftdetect/filetype.vim]], false)
time([[Sourcing ftdetect script at: /home/nghialm/.local/share/nvim/site/pack/packer/opt/dart-vim-plugin/ftdetect/dart.vim]], true)
vim.cmd [[source /home/nghialm/.local/share/nvim/site/pack/packer/opt/dart-vim-plugin/ftdetect/dart.vim]]
time([[Sourcing ftdetect script at: /home/nghialm/.local/share/nvim/site/pack/packer/opt/dart-vim-plugin/ftdetect/dart.vim]], false)
vim.cmd("augroup END")

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
