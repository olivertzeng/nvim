local augroup = vim.api.nvim_create_augroup
local cmd = vim.api.nvim_create_autocmd

local group = {}
local enabled = require("core.utils").enabled

-- disables code folding for the start screen
if enabled(group, "alpha_folding") then
	cmd({ "FileType" }, {
		desc = "Disable folding for alpha buffer",
		group = augroup("alpha", { clear = true }),
		pattern = "alpha",
		command = "setlocal nofoldenable",
	})
end

-- Removes any trailing whitespace when saving a file
if enabled(group, "trailing_whitespace") then
	cmd({ "BufWritePre" }, {
		desc = "remove trailing whitespace on save",
		group = augroup("remove trailing whitespace", { clear = true }),
		pattern = { "*" },
		command = [[%s/\s\+$//e]],
	})
end

-- remembers file state, such as cursor position and any folds
if enabled(group, "remember_file_state") then
	augroup("remember file state", { clear = true })
	cmd({ "BufWinLeave" }, {
		desc = "remember file state",
		group = "remember file state",
		pattern = { "*.*" },
		command = "mkview",
	})
	cmd({ "BufWinEnter" }, {
		desc = "remember file state",
		group = "remember file state",
		pattern = { "*.*" },
		command = "silent! loadview",
	})
end
