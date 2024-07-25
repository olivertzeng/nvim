local map = require("core.utils.utils").map

vim.g.mapleader = " " -- the leader key is the spacebar
local M = {}

-- Image Pasting
map("n", "<leader>p", "<CMD>PasteImage<CR>", { desc = "Paste clipboard image" })

-- DAP
_G.dap = require("dap")
map("n", "<leader>dc", "<CMD>lua dap.continue()<CR>")
map("n", "<leader>dn", "<CMD>lua dap.step_over()<CR>")
map("n", "<leader>di", "<CMD>lua dap.step_into()<CR>")
map("n", "<leader>do", "<CMD>lua dap.step_out()<CR>")
map("n", "<leader>db", "<CMD>lua dap.toggle_breakpoint()<CR>")
map("n", "<leader>dq", "<CMD>lua dap.disconnect({ terminateDebuggee = true })<CR>")

-- Trouble
map("n", "<leader>tr", "<CMD>TroubleToggle lsp_references<CR>")
map("n", "<leader>td", "<CMD>TroubleToggle lsp_definitions<CR>")
map("n", "<leader>cd", "<CMD>TroubleToggle<CR>")

-- UFO
map("n", "zR", "<CMD>lua require('ufo').openAllFolds()<CR>")
map("n", "zM", "<CMD>lua require('ufo').closeAllFolds()<CR>")

-- ZenMode
map("n", "<leader>zm", "<CMD>ZenMode<CR>")

-- NeoTree
map("n", "<leader>nt", "<CMD>Neotree reveal left<CR>")
map("n", "<leader>nf", "<CMD>Neotree reveal float<CR>")

-- Aerial
map("n", "<leader>at", "<CMD>AerialToggle<CR>")

-- Searching and Highlighting
map("n", "m", "<CMD>noh<CR>")

-- Movement
-- in insert mode, type <c-d> and your cursor will move past the next separator
-- such as quotes, parens, brackets, etc.
map("i", "<C-d>", "<left><c-o>/[\"';)>}\\]]<cr><c-o><CMD>noh<cr><right>")
map("i", "<C-b>", "<C-o>0")
map("i", "<C-a>", "<C-o>A")

-- Window switching from terminal
map("t", "<C-w>h", "<C-\\><C-n><C-w>h")
map("t", "<C-w>j", "<C-\\><C-n><C-w>j")
map("t", "<C-w>k", "<C-\\><C-n><C-w>k")
map("t", "<C-w>l", "<C-\\><C-n><C-w>l")

-- Command mode
map("c", "<C-p>", "<Up>")
map("c", "<C-n>", "<Down>")

-- Telescope
map("n", "<leader>ff", "<CMD>Telescope git_files hidden=true<CR>", { desc = "Telescope Find Files" })
map("n", "<leader>fg", "<CMD>Telescope live_grep<CR>")
map("n", "<leader>fb", "<CMD>Telescope buffers<CR>")
map("n", "<leader>fh", "<CMD>Telescope help_tags<CR>")
map("n", "<leader>fa", "<CMD>Telescope aerial<CR>")
map("n", "<leader>fp", "<CMD>Telescope projects<CR>")

-- Move lines and blocks
map("x", "<A-j>", ":m '>+1<CR>gv=gv")
map("x", "<A-k>", ":m '<-2<CR>gv=gv")

-- Notify
map("n", "<ESC>", "<CMD>lua require('notify').dismiss()<CR>")
map("i", "<ESC>", "<CMD>lua require('notify').dismiss()<CR><ESC>")

-- More LSP stuff
_G.buf = vim.lsp.buf
-- lsp agnostic global rename
map("n", "rg", ":%s/<C-r><C-w>//g<Left><Left>", { desc = "global substitution" })
map("n", "gD", "<CMD>lua buf.declaration()<CR>")
map("n", "gd", "<CMD>lua buf.definition()<CR>")
map("n", "gi", "<CMD>lua buf.implementation()<CR>")
map("n", "gr", "<CMD>Telescope lsp_references<CR>")
map("n", "sh", "<CMD>lua buf.signature_help()<CR>")
map("n", "<leader>rn", "<CMD>lua buf.rename()<CR>")
map("n", "<leader>ca", "<CMD>lua buf.code_action()<CR>")

-- Session
map("n", "<leader>ss", "<CMD>SessionManager save_current_session<CR>")
map("n", "<leader>o", "<CMD>SessionManager load_session<CR>")

-- ToggleTerm
local git_root = "cd $(git rev-parse --show-toplevel 2>/dev/null) && clear"
map("t", "<C-\\>", "<C-\\><C-n>")
-- opens terminal as a new tab at the git root
-- as a regular window
map("n", "<C-\\>", "<CMD>ToggleTerm go_back=0 cmd='" .. git_root .. "'<CR>", { desc = "new terminal" })
map(
	"n",
	"<leader>tk",
	"<CMD>TermExec go_back=0 direction=float cmd='" .. git_root .. "&& tokei'<CR>",
	{ desc = "tokei" }
)
map("n", "<leader>gg", "<CMD>lua term.lazygit_toggle()<CR>", { desc = "open lazygit" })
map("n", "<leader>gd", "<CMD>lua term.gdu_toggle()<CR>", { desc = "open gdu" })
map("n", "<leader>bt", "<CMD>lua term.bashtop_toggle()<CR>", { desc = "open bashtop" })

-- Hop
map("n", "<leader>j", "<CMD>HopWord<CR>")

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

	map("n", "<leader>hs", gs.stage_hunk, { desc = "stage hunk" })
	map("n", "<leader>hr", gs.reset_hunk, { desc = "reset hunk" })
	map("n", "<leader>hS", gs.stage_buffer, { desc = "stage buffer" })
	map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "undo stage hunk" })
	map("n", "<leader>hR", gs.reset_buffer, { desc = "reset buffer" })
	map("n", "<leader>hp", gs.preview_hunk, { desc = "preview hunk" })
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

return M
