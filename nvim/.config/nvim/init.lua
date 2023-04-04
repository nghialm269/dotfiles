vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.opt.title = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.scrolloff = 9
vim.opt.sidescrolloff = 10
vim.opt.sidescroll = 1

vim.opt.wildoptions = "pum"
-- vim.opt.pumblend = 12
-- vim.opt.winblend = 12

vim.opt.list = true -- invisible chars
vim.opt.listchars = {
	eol = "¬",
	tab = "  ", --"  ▸", -- Alternatives: '▷▷',
	extends = "›", -- Alternatives: … »
	precedes = "‹", -- Alternatives: … «
	trail = "•", -- BULLET (U+2022, UTF-8: E2 80 A2), Alternatives: ·
	lead = "⋅",
	multispace = "⋅",
}

vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.eadirection = "hor"

vim.opt.mouse = "a"
vim.opt.mousefocus = true

vim.opt.signcolumn = "yes:3"

vim.opt.showmode = false

vim.opt.virtualedit = "block" -- allow cursor to move where there is no text in visual block mode

vim.opt.termguicolors = true
vim.opt.undofile = true

vim.opt.updatetime = 300
vim.opt.timeoutlen = 500
vim.opt.ttimeoutlen = 20

vim.opt.textwidth = 80
vim.opt.colorcolumn = "+1"

vim.opt.diffopt = {
	"internal",
	"filler",
	"closeoff",
	"vertical",
	"indent-heuristic",
	"algorithm:patience",
	-- "linematch:60",
}

vim.opt.completeopt = { "menu", "menuone", "noselect" }

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	pattern = { "*" },
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150, on_visual = false })
	end,
})

vim.keymap.set("n", "<space>", "<Nop>")
vim.g.mapleader = ","
vim.g.maplocalleader = " "

require("n.globals")
require("impatient")
require("plugins")

--[[ 
if File_watchers == nil then
    File_watchers = {}
end
local watch_file_augroup = 'watch_file_augroup'
vim.api.nvim_create_augroup(watch_file_augroup, {clear=true})
vim.api.nvim_create_autocmd('VimLeave', {
    group = watch_file_augroup,
    callback = function()
        for _, watcher in pairs(File_watchers) do
            watcher:stop()
        end
    end
})
local function watch_file(fname, cb, time)
    if File_watchers[fname] then
        File_watchers[fname]:stop()
        File_watchers[fname] = nil
    end

    File_watchers[fname] = vim.loop.new_fs_poll()
    File_watchers[fname]:start(fname, time, vim.schedule_wrap(cb))
end

local init_lua = vim.fn.stdpath('config')..'/init.lua'
watch_file(init_lua, function()
    dofile(init_lua)
    vim.notify('Reloaded init.lua', vim.diagnostic.severity.INFO)
end, 500)
]]

-- vim: ts=2 sts=2 sw=2 et
