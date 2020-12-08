" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif

packadd packer.nvim

try

lua << END
local package_path_str = "/home/nghialm/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/nghialm/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/nghialm/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/nghialm/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/nghialm/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

local function try_loadstring(s, component, name)
  local success, err = pcall(loadstring(s))
  if not success then
    print('Error running ' .. component .. ' for ' .. name)
    error(err)
  end
end

_G.packer_plugins = {
  ["completion-buffers"] = {
    load_after = {
      ["completion-nvim"] = true
    },
    loaded = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/completion-buffers"
  },
  ["completion-nvim"] = {
    after = { "completion-buffers", "vim-vsnip", "vim-vsnip-integ" },
    loaded = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/completion-nvim"
  },
  ["conflict-marker.vim"] = {
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/conflict-marker.vim"
  },
  ["dart-vim-plugin"] = {
    loaded = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/dart-vim-plugin"
  },
  ["dial.nvim"] = {
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/dial.nvim"
  },
  diffconflicts = {
    commands = { "DiffConflicts", "DiffConflictsWithHistory", "DiffConflictsShowHistory" },
    loaded = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/diffconflicts"
  },
  ["flutter-tools.nvim"] = {
    config = { "\27LJ\2\n?\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\18flutter-tools\frequire\0" },
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/flutter-tools.nvim"
  },
  gruvbox = {
    config = { "\27LJ\2\nÐ\1\0\0\3\0\t\0\0216\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0'\1\4\0=\1\3\0006\0\0\0009\0\1\0)\1\0\0=\1\5\0006\0\0\0009\0\6\0'\2\a\0B\0\2\0016\0\0\0009\0\6\0'\2\b\0B\0\2\1K\0\1\0\24colorscheme gruvbox\24set background=dark\bcmd\29gruvbox_invert_selection\thard\26gruvbox_contrast_dark\19gruvbox_italic\6g\bvim\0" },
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/gruvbox"
  },
  ["lexima.vim"] = {
    loaded = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/lexima.vim"
  },
  ["lsp-status.nvim"] = {
    loaded = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/lsp-status.nvim"
  },
  ["lspsaga.nvim"] = {
    loaded = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/lspsaga.nvim"
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14colorizer\frequire\0" },
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua"
  },
  ["nvim-lightbulb"] = {
    loaded = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/nvim-lightbulb"
  },
  ["nvim-lspconfig"] = {
    loaded = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/nvim-lspconfig"
  },
  ["nvim-treesitter"] = {
    loaded = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/nvim-treesitter"
  },
  ["nvim-treesitter-context"] = {
    loaded = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/nvim-treesitter-context"
  },
  ["nvim-treesitter-refactor"] = {
    loaded = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/nvim-treesitter-refactor"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/nvim-treesitter-textobjects"
  },
  ["packer.nvim"] = {
    loaded = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/packer.nvim"
  },
  playground = {
    loaded = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/playground"
  },
  ["plenary.nvim"] = {
    load_after = {
      ["telescope.nvim"] = true
    },
    loaded = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/plenary.nvim"
  },
  ["popup.nvim"] = {
    load_after = {
      ["telescope.nvim"] = true
    },
    loaded = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/popup.nvim"
  },
  tcomment_vim = {
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/tcomment_vim"
  },
  ["telescope-floaterm.nvim"] = {
    loaded = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/telescope-floaterm.nvim"
  },
  ["telescope.nvim"] = {
    after = { "plenary.nvim", "popup.nvim" },
    loaded = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/telescope.nvim"
  },
  ["vim-abolish"] = {
    commands = { "S" },
    loaded = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/vim-abolish"
  },
  ["vim-dirvish"] = {
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/vim-dirvish"
  },
  ["vim-dirvish-git"] = {
    loaded = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/vim-dirvish-git"
  },
  ["vim-floaterm"] = {
    loaded = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/vim-floaterm"
  },
  ["vim-go"] = {
    config = { "\27LJ\2\n›\4\0\0\2\0\19\0=6\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0)\1\1\0=\1\3\0006\0\0\0009\0\1\0'\1\5\0=\1\4\0006\0\0\0009\0\1\0)\1\1\0=\1\6\0006\0\0\0009\0\1\0)\1\1\0=\1\a\0006\0\0\0009\0\1\0'\1\5\0=\1\b\0006\0\0\0009\0\1\0'\1\5\0=\1\t\0006\0\0\0009\0\1\0'\1\v\0=\1\n\0006\0\0\0009\0\1\0)\1\1\0=\1\f\0006\0\0\0009\0\1\0)\1\1\0=\1\r\0006\0\0\0009\0\1\0)\1\0\0=\1\14\0006\0\0\0009\0\1\0)\1\0\0=\1\15\0006\0\0\0009\0\1\0)\1\0\0=\1\16\0006\0\0\0009\0\1\0)\1\0\0=\1\17\0006\0\0\0009\0\1\0004\1\0\0=\1\18\0K\0\1\0\19go_fold_enable\20go_echo_go_info\27go_def_mapping_enabled\30go_doc_keywordprg_enabled\31go_code_completion_enabled\18go_term_reuse\20go_term_enabled\nsplit\17go_term_mode\23go_fillstruct_mode\20go_imports_mode\24go_imports_autosave\21go_gopls_gofumpt\ngopls\19go_fmt_command\20go_fmt_autosave\21go_gopls_enabled\6g\bvim\0" },
    loaded = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/vim-go"
  },
  ["vim-obsession"] = {
    after = { "vim-prosession" },
    commands = { "Prosession" },
    loaded = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/vim-obsession"
  },
  ["vim-prosession"] = {
    load_after = {
      ["vim-obsession"] = true
    },
    loaded = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/vim-prosession"
  },
  ["vim-qf"] = {
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/vim-qf"
  },
  ["vim-signify"] = {
    loaded = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/vim-signify"
  },
  ["vim-sleuth"] = {
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/vim-sleuth"
  },
  ["vim-stay"] = {
    loaded = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/vim-stay"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["vim-unimpaired"] = {
    loaded = true,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/start/vim-unimpaired"
  },
  ["vim-vsnip"] = {
    load_after = {
      ["completion-nvim"] = true
    },
    loaded = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/vim-vsnip"
  },
  ["vim-vsnip-integ"] = {
    load_after = {
      ["completion-nvim"] = true
    },
    loaded = false,
    path = "/home/nghialm/.local/share/nvim/site/pack/packer/opt/vim-vsnip-integ"
  }
}

-- Config for: flutter-tools.nvim
try_loadstring("\27LJ\2\n?\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\18flutter-tools\frequire\0", "config", "flutter-tools.nvim")
-- Config for: gruvbox
try_loadstring("\27LJ\2\nÐ\1\0\0\3\0\t\0\0216\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0'\1\4\0=\1\3\0006\0\0\0009\0\1\0)\1\0\0=\1\5\0006\0\0\0009\0\6\0'\2\a\0B\0\2\0016\0\0\0009\0\6\0'\2\b\0B\0\2\1K\0\1\0\24colorscheme gruvbox\24set background=dark\bcmd\29gruvbox_invert_selection\thard\26gruvbox_contrast_dark\19gruvbox_italic\6g\bvim\0", "config", "gruvbox")
-- Config for: nvim-colorizer.lua
try_loadstring("\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14colorizer\frequire\0", "config", "nvim-colorizer.lua")

-- Command lazy-loads
vim.cmd [[command! -nargs=* -range -bang -complete=file DiffConflictsWithHistory lua require("packer.load")({'diffconflicts'}, { cmd = "DiffConflictsWithHistory", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file DiffConflictsShowHistory lua require("packer.load")({'diffconflicts'}, { cmd = "DiffConflictsShowHistory", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Prosession lua require("packer.load")({'vim-obsession'}, { cmd = "Prosession", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file S lua require("packer.load")({'vim-abolish'}, { cmd = "S", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file DiffConflicts lua require("packer.load")({'diffconflicts'}, { cmd = "DiffConflicts", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
vim.cmd [[au FileType go ++once lua require("packer.load")({'vim-go'}, { ft = "go" }, _G.packer_plugins)]]
vim.cmd [[au FileType gomod ++once lua require("packer.load")({'vim-go'}, { ft = "gomod" }, _G.packer_plugins)]]
vim.cmd [[au FileType dart ++once lua require("packer.load")({'dart-vim-plugin'}, { ft = "dart" }, _G.packer_plugins)]]
vim.cmd("augroup END")
END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
