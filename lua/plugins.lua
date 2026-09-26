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
			"moyiz/blink-emoji.nvim",
			"olivertzeng/friendly-snippets",
			"saghen/blink.lib",
		},
		build = function()
			require("blink.cmp").build():pwait()
		end,
		-- We will use the wildcard version. If it builds V2, our shim will protect it.
		version = "*",
		opts = {
			enabled = function()
				if vim.api.nvim_get_mode().mode == "c" then
					return true
				end
				local ft = vim.bo.filetype
				if vim.tbl_contains({ "markdown", "gitcommit" }, ft) then
					return true
				end
				local ok, node = pcall(vim.treesitter.get_node)
				if ok and node then
					local type = node:type()
					if type:find("comment") or type:find("doc") or type:find("string") then
						return true
					end
				end
				return false
			end,
			keymap = { preset = "default" },
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer", "emoji" },
				providers = {
					emoji = {
						module = "blink-emoji",
						name = "Emoji",
						score_offset = 15,
						opts = { insert = true },
					},
				},
			},
			signature = { enabled = true },
			completion = {
				menu = { border = "rounded" },
				documentation = { auto_show = true, auto_show_delay_ms = 250, window = { border = "rounded" } },
			},
		},
		config = function(_, opts)
			-- ================================================================
			-- V1 to V2 Async API Compatibility Shim for Community Sources
			-- ================================================================
			local has_v2_task, task = pcall(require, "blink.lib.task")
			if has_v2_task then
				-- Inject the shim into Lua's loaded packages so old sources find it
				package.loaded["blink.cmp.lib.async"] = (function()
					task.empty = task.resolve
					task.on_completion = task.on_resolve
					task.on_failure = task.on_reject
					task.task = task
					return task
				end)()
			end

			-- Initialize blink.cmp with our options
			require("blink.cmp").setup(opts)
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
