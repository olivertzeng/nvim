-- ============================================================================
-- File: lua/core/options.lua
-- Description: Core Neovim options optimized for 0.11+
-- ============================================================================

local opt = vim.opt

-- Appearance & UI
opt.termguicolors = true
opt.signcolumn = "yes"
opt.number = true
opt.relativenumber = true
opt.numberwidth = 4
opt.cursorline = true
opt.cursorlineopt = "number"
opt.colorcolumn = "100"
opt.showmode = true
opt.laststatus = 3
opt.scrolloff = 5
opt.breakindent = true
opt.breakindentopt = "shift:2,min:40,sbr"
opt.linebreak = true

-- Behavior & Logic
opt.autochdir = true
opt.autowrite = true
opt.confirm = true
opt.hidden = true
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.mouse = "a"
opt.mousemoveevent = true
opt.updatetime = 100
opt.clipboard = "unnamedplus"

-- Indentation
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4

-- File & Session Management
opt.undofile = true
opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
vim.opt.shortmess:append("sIW")

-- Folding (Native 0.11+ Treesitter folding)
opt.foldenable = true
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldopen = "jump,block,hor,mark,percent,quickfix,search,tag,undo"

-- Custom Filetypes
vim.filetype.add({
	extension = { nsp = "json", sh = "sh", zsh = "sh" },
	filename = { [".zshenv"] = "sh", [".zshrc"] = "sh" },
})

-- Diagnostics Icons (Neovim 0.10+ Native API)
vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.INFO] = " ",
			[vim.diagnostic.severity.HINT] = "󰠠 ",
		},
	},
	virtual_text = true,
	update_in_insert = false,
	underline = true,
})
