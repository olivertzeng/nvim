local map = require("core.utils").map

vim.g.mapleader = " "
local M = {}

-- Git Conflicts
map("n", "<leader>C0", "<Plug>(git-conflict-none)")
map("n", "<leader>Cb", "<Plug>(git-conflict-both)")
map("n", "<leader>Cn", "<Plug>(git-conflict-prev-conflict)")
map("n", "<leader>Co", "<Plug>(git-conflict-ours)")
map("n", "<leader>Cp", "<Plug>(git-conflict-next-conflict)")
map("n", "<leader>Ct", "<Plug>(git-conflict-theirs)")

-- Trouble
map("n", "<leader>xL", "<CMD>Trouble loclist toggle<CR>", { desc = "Location List (Trouble)" })
map("n", "<leader>xQ", "<CMD>Trouble qflist toggle<CR>", { desc = "Quickfix List (Trouble)" })
map("n", "<leader>xX", "<CMD>Trouble diagnostics toggle filter.buf=0<CR>", { desc = "Buffer Diagnostics (Trouble)" })
map("n", "<leader>xd", "<CMD>Trouble lsp_definitions toggle<CR>")
map("n", "<leader>xr", "<CMD>Trouble lsp_references toggle<CR>")
map("n", "<leader>xx", "<CMD>Trouble diagnostics toggle<CR>", { desc = "Diagnostics (Trouble)" })

-- UFO
map("n", "zM", "<CMD>lua require('ufo').closeAllFolds()<CR>")
map("n", "zR", "<CMD>lua require('ufo').openAllFolds()<CR>")

-- Searching and Highlighting
map("n", "m", "<CMD>noh<CR>")

-- Movement
-- in insert mode, type <c-d> and your cursor will move past the next separator
-- such as quotes, parens, brackets, etc.
map("i", "<C-a>", "<C-o>A")
map("i", "<C-b>", "<C-o>0")
map("i", "<C-d>", "<left><c-o>/[\"';)>}\\]]<cr><c-o><CMD>nohlsearch<cr><right>")

-- Window switching from terminal
map("t", "<C-w>h", "<C-\\><C-n><C-w>h")
map("t", "<C-w>j", "<C-\\><C-n><C-w>j")
map("t", "<C-w>k", "<C-\\><C-n><C-w>k")
map("t", "<C-w>l", "<C-\\><C-n><C-w>l")

-- Command mode
map("c", "<C-n>", "<Down>")
map("c", "<C-p>", "<Up>")

-- Telescope
map("n", "<leader>fb", "<CMD>Telescope buffers<CR>")
map("n", "<leader>fc", "<CMD>Telescope commands<CR>")
map("n", "<leader>ff", "<CMD>Telescope git_files hidden=true<CR>", { desc = "Telescope Find Files" })
map("n", "<leader>fg", "<CMD>Telescope live_grep<CR>")
map("n", "<leader>fh", "<CMD>Telescope help_tags<CR>")
map("n", "<leader>fo", "<CMD>Telescope conflicts<CR>")
map("n", "<leader>fp", "<CMD>Telescope lazy_plugins<CR>", { desc = "Search For Plugins" })
map("n", "<leader>fs", "<CMD>Telescope symbols<CR>")
map("n", "<leader>fu", "<cmd>Telescope undo<cr>")

-- Move lines and blocks
map("x", "<A-j>", ":m '>+1<CR>gv=gv")
map("x", "<A-k>", ":m '<-2<CR>gv=gv")

-- Notify
map({ "i", "n" }, "<ESC>", "<CMD>lua require('notify').dismiss()<CR><ESC>")

-- More LSP stuff
_G.buf = vim.lsp.buf
-- lsp agnostic global rename
map("n", "gd", "<CMD>lua buf.definition()<CR>")
map("n", "gi", "<CMD>lua buf.implementation()<CR>")
map("n", "gr", "<CMD>Telescope lsp_references<CR>")
map("n", "rg", ":%s/<C-r><C-w>//g<Left><Left>", { desc = "global substitution" })
map("n", "sh", "<CMD>lua buf.signature_help()<CR>")

-- ToggleTerm
local git_root = "cd $(git rev-parse --show-toplevel 2>/dev/null) && clear"
map("t", "<C-\\>", "<C-\\><C-n>")
-- open terminal as a regular window
map("n", "<C-\\>", "<CMD>ToggleTerm go_back=0 cmd='" .. git_root .. "'<CR>", { desc = "New Terminal" })
map(
	"n",
	"<leader>tk",
	"<CMD>TermExec go_back=0 direction=float cmd='" .. git_root .. "&& tokei'<CR>",
	{ desc = "tokei" }
)
map("n", "<leader>gg", "<CMD>lua term.lazygit_toggle()<CR>", { desc = "Open Lazygit" })

-- hop.nvim
map("n", "<leader>jw", "<CMD>HopWord<CR>", { desc = "Hop to Word" })
map("n", "<leader>jl", "<CMD>HopLine<CR>", { desc = "Hop to Line" })

-- Gitsigns

-- making this a function here because all it does is create keybinds for gitsigns but
-- it needs to be attached to an on_attach function.
M.gitsigns = function()
	local gs = package.loaded.gitsigns
	-- travel between hunks, backwards and forwards
	map("n", "]c", function()
		if vim.wo.diff then
			return "]c"
		end
		vim.schedule(function()
			gs.next_hunk()
		end)
		return "<Ignore>"
	end, { expr = true, desc = "go to previous git hunk" })
	map("n", "[c", function()
		if vim.wo.diff then
			return "[c"
		end
		vim.schedule(function()
			gs.prev_hunk()
		end)
		return "<Ignore>"
	end, { expr = true, desc = "go to next git hunk" })

	map("n", "<leader>hR", gs.reset_buffer, { desc = "reset buffer" })
	map("n", "<leader>hS", gs.stage_buffer, { desc = "stage buffer" })
	map("n", "<leader>hp", gs.preview_hunk, { desc = "preview hunk" })
	map("n", "<leader>hr", gs.reset_hunk, { desc = "reset hunk" })
	map("n", "<leader>hs", gs.stage_hunk, { desc = "stage hunk" })
	map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "undo stage hunk" })
	map("n", "<leader>hb", function()
		gs.blame_line({ full = true })
	end, { desc = "complete blame line history" })
	map("n", "<leader>lb", gs.toggle_current_line_blame, { desc = "toggle blame line" })
	-- diff at current working directory
	map("n", "<leader>hd", gs.diffthis, { desc = "diff at cwd" })
	-- diff at root of git repository
	map("n", "<leader>hD", function()
		gs.diffthis("~")
	end, { desc = "diff at root of git repo" })
	map("n", "<leader>td", gs.toggle_deleted, { desc = "toggle deleted line" })
end

-- Oil
map("n", "<leader>ec", "<CMD>Oil ~/.config/nvim/lua<CR>", { desc = "Edit Nvim Config" })
map("n", "<leader>ex", "<CMD>Oil<CR>", { desc = "File Explorer" })

-- Todo
map("n", "]t", function()
	require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

map("n", "[t", function()
	require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

-- You can also specify a list of valid jump keywords
map("n", "]t", function()
	require("todo-comments").jump_next({ keywords = { "ERROR", "WARNING" } })
end, { desc = "Next error/warning todo comment" })

-- suda
map("n", "<leader>su", function()
	vim.fn.feedkeys(":SudaWrite")
end, { desc = "Gain Write Permission" })

-- Git Link
map({ "n", "v" }, "<leader>gp", function()
	require("gitportal").open_file_in_browser()
end, { desc = "Open git link" })
map("n", "<leader>gl", function()
	require("gitportal").open_file_in_neovim()
end, { desc = "Open git file" })

map("n", "<leader>gy", "<cmd>GitLink<cr>", { desc = "Yank git link" })

-- lspzero
map("n", "<leader>F", "<CMD>LspZeroFormat<CR>", { desc = "Format file" })

map("n", "<Leader>nc", "<CMD>Neogen class<CR>", { desc = "Add class annotation" })
map("n", "<Leader>nf", "<CMD>Neogen func<CR>", { desc = "Add function annotation" })
map("n", "<Leader>nt", "<CMD>Neogen type<CR>", { desc = "Add type annotation" })

-- ShowKeys
map("n", "<Leader>kl", "<CMD>ShowkeysToggle<CR>", { desc = "Keylogger" })

-- inc-rename
map("n", "<leader>rn", function()
	return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true, desc = "LSP rename" })

-- menu
map("n", "<RightMouse>", function()
	vim.cmd.exec('"normal! \\<RightMouse>"')

	local options = vim.bo.ft == "oil" or "default"
	require("menu").open(options, { mouse = true })
end, {})

return M
