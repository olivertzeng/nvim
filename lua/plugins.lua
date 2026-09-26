-- ============================================================================
-- File: lua/plugins.lua
-- Description: Complete plugin definitions based on user's exact specifications
-- ============================================================================

return {
	-- ── UI & Core ───────────────────────────────────────────────────────────
	{
		"goolord/alpha-nvim",
		config = function()
			require("configs.alpha")
		end,
	},
	{
		"akinsho/bufferline.nvim",
		opts = { options = { separator_style = "slant", diagnostics = "nvim_lsp" } },
	},
	{
		"stevearc/dressing.nvim",
		lazy = true,
		event = "VeryLazy",
		opts = { input = { title_pos = "center", insert_only = false }, mappings = false },
	},
	{ "Bekaboo/dropbar.nvim", event = "VimEnter" },
	{
		"folke/noice.nvim",
		event = "VimEnter",
		dependencies = { "MunifTanjim/nui.nvim" },
		config = function()
			require("configs.noice")
		end,
	},
	{ "rcarriga/nvim-notify", opts = { timeout = 2500 } },
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "mikesmithgh/git-prompt-string-lualine.nvim" },
		config = function()
			require("configs.lualine")
		end,
	},
	{
		"f4z3r/gruvbox-material.nvim",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("gruvbox-material")
		end,
	},
	{ "dstein64/nvim-scrollview", event = "VimEnter" },
	{ "yamatsum/nvim-cursorline", event = "VimEnter" },
	{ "NvChad/nvim-colorizer.lua", event = "VimEnter", opts = {} },
	{ "sphamba/smear-cursor.nvim", event = "VimEnter", opts = {} },
	{ "OXY2DEV/helpview.nvim", event = "VimEnter" },
	{ "folke/which-key.nvim", event = "VeryLazy" },

	-- ── Navigation ──────────────────
	{
		"2kabhishek/nerdy.nvim",
		dependencies = {
			"folke/snacks.nvim",
		},
		cmd = "Nerdy",
		opts = {
			max_recents = 30, -- Configure recent icons limit
			copy_to_clipboard = false, -- Copy glyph to clipboard instead of inserting
			copy_register = "+", -- Register to use for copying (if `copy_to_clipboard` is true)
		},
		keys = {
			{ "<leader>fs", "<cmd>Nerdy list<CR>", desc = "Browse nerd icons" },
		},
	},
	{ "smoka7/hop.nvim", event = "VimEnter", opts = {} },
	{
		"kevinhwang91/nvim-ufo",
		event = "VimEnter",
		dependencies = "kevinhwang91/promise-async",
		opts = {},
	},
	{ "stevearc/oil.nvim", lazy = false, opts = {}, dependencies = { "echasnovski/mini.icons" } },
	{
		"A7Lavinraj/fyler.nvim",
		dependencies = { "echasnovski/mini.icons" },
		opts = { views = { explorer = { default_explorer = true } } },
	},

	-- ── Editor Enhancements ─────────────────────────────────────────────────
	{ "echasnovski/mini.ai", version = false, opts = {} },
	{ "echasnovski/mini.indentscope", version = false, opts = {} },
	{ "kylechui/nvim-surround", event = "VeryLazy", opts = {} },
	{ "windwp/nvim-autopairs", event = "InsertEnter", opts = { map_c_w = true } },
	{ "folke/todo-comments.nvim", event = "VimEnter", opts = {} },
	{ "nacro90/numb.nvim", event = "VimEnter", opts = {} },
	{ "jghauser/mkdir.nvim", event = "VimEnter" },
	{ "kevinhwang91/nvim-fundo", event = "VimEnter", opts = {} },
	{ "tzachar/highlight-undo.nvim", event = "VimEnter", opts = {} },
	{ "sQVe/sort.nvim", event = "VimEnter", opts = {} },
	{ "lambdalisue/suda.vim", event = "VimEnter" },
	{ "smjonas/inc-rename.nvim", event = "VimEnter", opts = {} },

	-- ── Git Integration ─────────────────────────────────────────────────────
	{
		"lewis6991/gitsigns.nvim",
		event = "VimEnter",
		config = function()
			require("configs.gitsigns")
		end,
	},
	{ "f-person/git-blame.nvim", event = "VimEnter" },
	{ "akinsho/git-conflict.nvim", version = "*", config = true },
	{ "yutkat/git-rebase-auto-diff.nvim", ft = "gitrebase" },

	-- ── LSP, Formatting & Treesitter ────────────────────────────────────────
	{
		"neovim/nvim-lspconfig",
		dependencies = { "williamboman/mason.nvim", "Wansmer/symbol-usage.nvim" },
		config = function()
			require("configs.lspconfig")
		end,
	},
	{ "williamboman/mason.nvim", cmd = "Mason", opts = {} },
	{ "j-hui/fidget.nvim", event = "VimEnter", opts = {} },
	{ "folke/trouble.nvim", cmd = "Trouble", opts = {} },
	{ "danymat/neogen", config = true },
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter-context",
			"HiPhish/rainbow-delimiters.nvim",
		},
	},

	-- ── Autocompletion ────────────────────────────────────────────────
	{
		"saghen/blink.cmp",
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				dependencies = { "olivertzeng/friendly-snippets" },
				config = function()
					require("configs.luasnip")
					-- Explicitly load friendly-snippets from lazy's plugin directory
					require("luasnip.loaders.from_vscode").lazy_load({
						paths = { vim.fn.stdpath("data") .. "/lazy/friendly-snippets" },
					})
				end,
			},
			"Saghen/blink.lib",
			"moyiz/blink-emoji.nvim",
			"olivertzeng/friendly-snippets",
		},
		version = "1.*", -- Locks to the pre-compiled stable release
		opts = {
			snippets = { preset = "luasnip" },
			keymap = {
				["<CR>"] = { "accept", "fallback" },
				["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
				["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
				["<C-j>"] = { "scroll_documentation_down", "fallback" },
				["<C-k>"] = { "scroll_documentation_up", "fallback" },
				["<Up>"] = { "fallback" },
				["<Down>"] = { "fallback" },
			},
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},
			completion = {
				list = {
					selection = {
						preselect = false,
						auto_insert = false,
					},
				},
				ghost_text = { enabled = true },
				menu = { border = "rounded" },
				documentation = { auto_show = true, auto_show_delay_ms = 250, window = { border = "rounded" } },
			},
			signature = { enabled = true },
			sources = {
				default = { "lazydev", "lsp", "path", "snippets", "buffer", "emoji" },
				providers = {
					emoji = {
						name = "Emoji",
						module = "blink-emoji",
						score_offset = 15,
						opts = { insert = true },
						enabled = function()
							-- 1. Always active in markdown and git commits
							if vim.tbl_contains({ "markdown", "gitcommit" }, vim.bo.filetype) then
								return true
							end

							-- 2. Inspect Treesitter node at the cursor position
							local win = vim.api.nvim_get_current_win()
							local cursor = vim.api.nvim_win_get_cursor(win)
							local row = cursor[1] - 1
							local col = math.max(0, cursor[2] - 1)

							local ok, node = pcall(vim.treesitter.get_node, { pos = { row, col } })
							if ok and node then
								local cur = node
								while cur do
									if cur:type():match("comment") then
										return true
									end
									cur = cur:parent()
								end
							end

							-- 3. Fallback to standard Vim syntax group (works even if Treesitter parser is absent)
							local syn_id = vim.fn.synID(cursor[1], cursor[2], 1)
							local syn_name = vim.fn.synIDattr(syn_id, "name"):lower()
							return syn_name:match("comment") ~= nil
						end,
					},
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100,
					},
				},
			},
		},
	},

	-- ── Languages & Special Tools ───────────────────────────────────────────
	{ "ray-x/go.nvim", dependencies = { "ray-x/guihua.lua" }, event = "CmdlineEnter", config = true },
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = { library = { { path = "luvit-meta/library", words = { "vim%.uv" } } } },
	},
	{ "briangwaltney/paren-hint.nvim", event = "VimEnter", opts = {} },
	{ "chentoast/marks.nvim", event = "VimEnter", opts = {} },

	-- ── Fun, Stats & Misc ───────────────────────────────────────────────────
	{ "vyfor/cord.nvim", event = "VeryLazy", opts = {} },
	{ "alex-popov-tech/store.nvim", cmd = "Store", dependencies = { "OXY2DEV/markview.nvim" } },
	{ "jaimecgomezz/here.term", event = "VimEnter" },
	{ "nvzone/showkeys", cmd = "ShowkeysToggle" },
	{ "tiagovla/scope.nvim", event = "VimEnter", opts = {} },
	{ "tpope/vim-sleuth", event = "VimEnter" },

	-- ── Modern Alternatives ────────
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			picker = { enabled = true },
			notifier = { enabled = false }, -- Keeping nvim-notify active
		},
	},
	{
		"max397574/better-escape.nvim",
		event = "InsertEnter",
		opts = {
			timeout = vim.o.timeoutlen,
			default_mappings = true,
			mappings = {
				i = { j = { k = "<Esc>", j = "<Esc>" } },
				c = { j = { k = "<Esc>", j = "<Esc>" } },
				v = { j = { k = "<Esc>" } },
				s = { j = { k = "<Esc>" } },
			},
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		cmd = { "MasonToolsInstall", "MasonToolsUpdate" },
		opts = {
			ensure_installed = { "stylua", "prettier", "biome", "ts_ls" },
			run_on_start = true,
		},
	},
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettier", "biome", stop_after_first = true },
				typescript = { "prettier", "biome", stop_after_first = true },
			},
			format_on_save = { timeout_ms = 500, lsp_fallback = true },
		},
	},
}
