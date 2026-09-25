-- ============================================================================
-- File: lua/core/autocmds.lua
-- Description: Autocommands and dynamically attached LSP keymaps.
-- ============================================================================

local augroup = vim.api.nvim_create_augroup
local cmd = vim.api.nvim_create_autocmd

-- Disable folding for alpha buffer
cmd({ "FileType" }, {
	desc = "Disable folding for alpha buffer",
	group = augroup("alpha_nofold", { clear = true }),
	pattern = "alpha",
	command = "setlocal nofoldenable",
})

-- Remove trailing whitespace on save
cmd({ "BufWritePre" }, {
	desc = "Remove trailing whitespace on save",
	group = augroup("trim_whitespace", { clear = true }),
	pattern = { "*" },
	command = [[%s/\s\+$//e]],
})

-- Session notification
cmd({ "User" }, {
	desc = "Notify session saved",
	group = augroup("session_save", { clear = true }),
	pattern = "SessionSavePost",
	command = "lua vim.notify('Session Saved', 'info')",
})

-- LSP Keybindings (Attached only when LSP is active)
cmd("LspAttach", {
	desc = "Register LSP keybindings on attach",
	group = augroup("UserLspKeys", { clear = true }),
	callback = function(ev)
	local map = function(lhs, rhs, desc)
	vim.keymap.set("n", lhs, rhs, { buffer = ev.buf, silent = true, desc = desc })
	end
	local buf = vim.lsp.buf

	map("gd", buf.definition, "Go to definition")
	map("gi", buf.implementation, "Go to implementation")
	map("sh", buf.signature_help, "Signature help")
	map("K", buf.hover, "Hover docs")
	map("<leader>rn", buf.rename, "LSP rename")
	map("<leader>ca", buf.code_action, "Code action")
	map("<leader>F", function() require("conform").format({ async = true }) end, "Format file (Conform)")
	end,
})
