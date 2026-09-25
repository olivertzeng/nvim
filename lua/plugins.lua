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
	{ "akinsho/bufferline.nvim", opts = { options = { separator_style = "slant", diagnostics = "nvim_lsp" } } },
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

	-- ── Telescope & Navigation (Kept exactly as requested) ──────────────────
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-lua/popup.nvim",
			"nvim-telescope/telescope-fzf-native.nvim",
			"nvim-telescope/telescope-frecency.nvim",
			"debugloop/telescope-undo.nvim",
			"Snikimonkd/telescope-git-conflicts.nvim",
			"nvim-telescope/telescope-symbols.nvim",
			"AckslD/nvim-neoclip.lua",
			"nvim-telescope/telescope-hop.nvim",
		},
		config = function()
			require("configs.telescope")
		end,
	},
	{ "smoka7/hop.nvim", event = "VimEnter", opts = {} },
	{ "kevinhwang91/nvim-ufo", event = "VimEnter", dependencies = "kevinhwang91/promise-async", opts = {} },
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
	{ "numToStr/Comment.nvim", opts = {} }, -- Assuming you use this or similar for comments
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
	{ "https://codeberg.org/trevorhauter/gitportal.nvim", event = "VimEnter" },
	{ "ruifm/gitlinker.nvim", event = "VimEnter", opts = {} },
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

	-- ── Autocompletion (CMP) ────────────────────────────────────────────────
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"ray-x/cmp-treesitter",
			"saadparwaiz1/cmp_luasnip",
			"onsails/lspkind.nvim",
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",
			"zjp-CN/nvim-cmp-lsp-rs",
		},
		config = function()
			require("configs.cmp")
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "benfowler/telescope-luasnip.nvim" },
		config = function()
			require("configs.luasnip")
		end,
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
			notifier = { enabled = false }, -- Keeping your nvim-notify active
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
