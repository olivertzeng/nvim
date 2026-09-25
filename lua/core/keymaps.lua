-- ============================================================================
-- File: lua/core/keymaps.lua
-- Note: LSP-specific mappings (gd, gi, gr, K, <leader>rn, <leader>ca, <leader>F)
--       are defined dynamically in lua/core/autocmds.lua on LspAttach.
-- ============================================================================

vim.g.mapleader = " "

local function map(mode, lhs, rhs, opts)
	opts = vim.tbl_extend("force", { noremap = true, silent = true }, opts or {})
	vim.keymap.set(mode, lhs, rhs, opts)
end

-- ── General & System ────────────────────────────────────────────────────────
map("n", "m", "<CMD>noh<CR>", { desc = "Clear search highlight" })
map("n", "<leader>su", "<CMD>SudaWrite<CR>", { desc = "Gain Write Permission" })
map("n", "rg", ":%s/<C-r><C-w>//g<Left><Left>", { desc = "Global substitution" })
map({ "i", "n" }, "<ESC>", "<CMD>lua require('notify').dismiss()<CR><ESC>", { desc = "Dismiss notifications" })
map("n", "<Leader>kl", "<CMD>ShowkeysToggle<CR>", { desc = "Toggle Keylogger" })
map("n", "<Leader>st", "<CMD>Store<CR>", { desc = "Store plugin" })

-- ── Insert Mode Movement ────────────────────────────────────────────────────
map("i", "<C-a>", "<C-o>A", { desc = "Jump to end of line" })
map("i", "<C-b>", "<C-o>0", { desc = "Jump to start of line" })
map("i", "<C-d>", "<left><c-o>/[\"';)>}\\]]<cr><c-o><CMD>nohlsearch<cr><right>", { desc = "Jump past next separator" })

-- ── Visual Block Movement ───────────────────────────────────────────────────
map("x", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move block down" })
map("x", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move block up" })

-- ── Terminal & UI ───────────────────────────────────────────────────────────
map("t", "<C-\\>", "<C-\\><C-n>", { desc = "Terminal normal mode" })
map("t", "<C-w>h", "<C-\\><C-n><C-w>h", { desc = "Terminal window left" })
map("t", "<C-w>j", "<C-\\><C-n><C-w>j", { desc = "Terminal window down" })
map("t", "<C-w>k", "<C-\\><C-n><C-w>k", { desc = "Terminal window up" })
map("t", "<C-w>l", "<C-\\><C-n><C-w>l", { desc = "Terminal window right" })

-- ── Command Mode History ────────────────────────────────────────────────────
map("c", "<C-n>", "<Down>", { desc = "Next command history" })
map("c", "<C-p>", "<Up>", { desc = "Previous command history" })

-- ── File Explorer (Fyler) ───────────────────────────────────────────────────
map("n", "<leader>ec", "<CMD>Fyler cwd=~/.config/nvim/lua<CR>", { desc = "Edit Nvim Config" })
map("n", "<leader>ex", "<CMD>Fyler<CR>", { desc = "File Explorer" })

-- ── Git Integration (Gitsigns & Git-Conflict) ───────────────────────────────
map("n", "<leader>gg", "<CMD>lua term.lazygit_toggle()<CR>", { desc = "Open Lazygit" })
map("n", "<leader>hD", function()
	package.loaded.gitsigns.diffthis("~")
end, { desc = "Diff at root" })
map("n", "<leader>td", function()
	package.loaded.gitsigns.toggle_deleted()
end, { desc = "Toggle deleted lines" })
map("n", "<leader>C0", "<Plug>(git-conflict-none)", { desc = "Git Conflict: None" })
map("n", "<leader>Cb", "<Plug>(git-conflict-both)", { desc = "Git Conflict: Both" })
map("n", "<leader>Cn", "<Plug>(git-conflict-prev-conflict)", { desc = "Git Conflict: Prev" })
map("n", "<leader>Co", "<Plug>(git-conflict-ours)", { desc = "Git Conflict: Ours" })
map("n", "<leader>Cp", "<Plug>(git-conflict-next-conflict)", { desc = "Git Conflict: Next" })
map("n", "<leader>Ct", "<Plug>(git-conflict-theirs)", { desc = "Git Conflict: Theirs" })

-- ── Code Navigation & Generation ────────────────────────────────────────────
map("n", "zR", function()
	require("ufo").openAllFolds()
end, { desc = "Open all folds" })
map("n", "zM", function()
	require("ufo").closeAllFolds()
end, { desc = "Close all folds" })
map("n", "<leader>rn", function()
	return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true, desc = "Incremental rename" })
map("n", "<Leader>nc", function()
	require("neogen").generate({ type = "class" })
end, { desc = "Add class annotation" })
map("n", "<Leader>nf", function()
	require("neogen").generate({ type = "func" })
end, { desc = "Add function annotation" })
map("n", "<Leader>nt", function()
	require("neogen").generate({ type = "type" })
end, { desc = "Add type annotation" })

-- ── Hop (Retained per user preference) ──────────────────────────────────────
map("n", "<leader>jw", "<CMD>HopWord<CR>", { desc = "Hop to Word" })
map("n", "<leader>jl", "<CMD>HopLine<CR>", { desc = "Hop to Line" })

-- ── Trouble Diagnostics ─────────────────────────────────────────────────────
map("n", "<leader>xL", "<CMD>Trouble loclist toggle<CR>", { desc = "Location List (Trouble)" })
map("n", "<leader>xQ", "<CMD>Trouble qflist toggle<CR>", { desc = "Quickfix List (Trouble)" })
map("n", "<leader>xX", "<CMD>Trouble diagnostics toggle filter.buf=0<CR>", { desc = "Buffer Diagnostics (Trouble)" })
map("n", "<leader>xd", "<CMD>Trouble lsp_definitions toggle<CR>", { desc = "LSP Definitions (Trouble)" })
map("n", "<leader>xr", "<CMD>Trouble lsp_references toggle<CR>", { desc = "LSP References (Trouble)" })
map("n", "<leader>xx", "<CMD>Trouble diagnostics toggle<CR>", { desc = "Diagnostics (Trouble)" })

-- ============================================================================
-- Modern Replacements (Telescope -> Snacks & Quickfix)
-- ============================================================================

-- Snacks Pickers (File, Grep, Buffer, Command, Help, Undo)
map("n", "<leader>ff", function()
	Snacks.picker.git_files()
end, { desc = "Find Git files" })
map("n", "<leader>fr", function()
	Snacks.picker.recent()
end, { desc = "Recent files" })
map("n", "<leader>fg", function()
	Snacks.picker.grep()
end, { desc = "Live grep" })
map("n", "<leader>fb", function()
	Snacks.picker.buffers()
end, { desc = "Buffers" })
map("n", "<leader>fc", function()
	Snacks.picker.commands()
end, { desc = "Commands" })
map("n", "<leader>fh", function()
	Snacks.picker.help()
end, { desc = "Help tags" })
map("n", "<leader>fu", function()
	Snacks.picker.undo()
end, { desc = "Undo history" })
map("n", "<leader>fd", function()
	Snacks.picker.diagnostics()
end, { desc = "Diagnostics" })

-- Snacks Gitbrowse (Replaces GitPortal/GitLink)
map({ "n", "v" }, "<leader>gp", function()
	Snacks.gitbrowse()
end, { desc = "Open git link in browser" })
map({ "n", "v" }, "<leader>gy", function()
	Snacks.gitbrowse({ action = "copy" })
end, { desc = "Yank git link" })

-- Special Tools Replacements
map("n", "<leader>fo", "<CMD>GitConflictListQf<CR>", { desc = "List Git conflicts" })
map("n", "<leader>fp", "<CMD>Lazy<CR>", { desc = "Search/Manage plugins" })
map("n", "<leader>fs", "<CMD>IconPickerNormal<CR>", { desc = "Search symbols/emojis" })
