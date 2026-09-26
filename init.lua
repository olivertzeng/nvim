-- ============================================================================
-- File: init.lua
-- Description: Main entry point for Neovim configuration.
-- ============================================================================

-- 1. Load core settings before plugins
require("core.options")
require("core.keymaps")
require("core.autocmds")

-- 2. Bootstrap lazy.nvim (using vim.uv for Neovim 0.11+)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- 3. Load plugins from lua/plugins.lua
require("lazy").setup("plugins", {
	concurrency = 5,
	git = { timeout = 120 },
	change_detection = { notify = false },
	ui = { border = "rounded" },
})
