local augroup = vim.api.nvim_create_augroup
local cmd = vim.api.nvim_create_autocmd

-- disables code folding for the start screen
cmd({ "FileType" }, {
	desc = "Disable folding for alpha buffer",
	group = augroup("alpha", { clear = true }),
	pattern = "alpha",
	command = "setlocal nofoldenable",
})

-- Removes any trailing whitespace when saving a file
cmd({ "BufWritePre" }, {
	desc = "remove trailing whitespace on save",
	group = augroup("remove trailing whitespace", { clear = true }),
	pattern = { "*" },
	command = [[%s/\s\+$//e]],
})

-- remembers file state, such as cursor position and any folds
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
