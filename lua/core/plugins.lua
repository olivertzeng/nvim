require("lazy").setup({
	{
		"goolord/alpha-nvim",
		config = function()
			require("configs.alpha")
		end,
	},
	{
		"akinsho/bufferline.nvim",
		config = function()
			require("configs.bufferline")
		end,
	},

	{
		"stevearc/dressing.nvim",
		lazy = true,
		event = "VeryLazy",
		config = function()
			require("configs.dressing")
		end,
	},

	{
		"VonHeikemen/lsp-zero.nvim",
		event = "VimEnter",
		branch = "v3.x",
		dependencies = {
			"neovim/nvim-lspconfig",
			"williamboman/mason-lspconfig.nvim",
			"williamboman/mason.nvim",
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		lazy = true,
		event = "VimEnter",
		config = function()
			require("configs.gitsigns")
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"j-hui/fidget.nvim",
			"williamboman/mason-lspconfig.nvim",
			"williamboman/mason.nvim",
		},
	},
	{
		"j-hui/fidget.nvim",
		config = function()
			require("configs.fidget")
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("configs.lspconfig")
		end,
	},
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{ "Bilal2453/luvit-meta", lazy = true },
	{
		"stevearc/oil.nvim",
		config = function()
			require("configs.oil")
		end,
	},
	{
		"folke/noice.nvim",
		event = "VimEnter",
		config = function()
			require("configs.noice")
		end,
		dependencies = { "MunifTanjim/nui.nvim" },
	},
	{
		"nvimtools/none-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("configs.null-ls")
		end,
		dependencies = {
			{
				"jay-babu/mason-null-ls.nvim",
				cmd = { "NullLsInstall", "NullLsUninstall" },
				config = function()
					require("configs.mason-null-ls")
				end,
			},
		},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = { map_c_w = true },
	},
	{
		"ray-x/go.nvim",
		dependencies = { -- optional packages
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("go").setup()
		end,
		event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
	},
	{
		"iguanacucumber/magazine.nvim",
		event = "InsertEnter",
		opts = function(_, opts)
			opts.sources = opts.sources or {}
			table.insert(opts.sources, {
				name = "lazydev",
				group_index = 0, -- set group index to 0 to skip loading LuaLS completions
			})
		end,
		config = function()
			require("configs.cmp")
		end,
		dependencies = {
			{
				"zjp-CN/nvim-cmp-lsp-rs",
				---@type cmp_lsp_rs.Opts
				opts = {
					-- Filter out import items starting with one of these prefixes.
					-- A prefix can be crate name, module name or anything an import
					-- path starts with, no matter it's complete or incomplete.
					-- Only literals are recognized: no regex matching.
					unwanted_prefix = { "color", "ratatui::style::Styled" },
					-- make these kinds prior to others
					-- e.g. make Module kind first, and then Function second,
					--      the rest ordering is merged from a default kind list
					kind = function(k)
						-- The argument in callback is type-aware with opts annotated,
						-- so you can type the CompletionKind easily.
						return { k.Module, k.Function }
					end,
					-- Override the default comparator list provided by this plugin.
					-- Mainly used with key binding to switch between these Comparators.
					combo = {
						-- The key is the name for combination of comparators and used
						-- in notification in swiching.
						-- The value is a list of comparators functions or a function
						-- to generate the list.
						alphabetic_label_but_underscore_last = function()
							local comparators = require("cmp_lsp_rs").comparators
							return { comparators.sort_by_label_but_underscore_last }
						end,
						recentlyUsed_sortText = function()
							local compare = require("cmp").config.compare
							local comparators = require("cmp_lsp_rs").comparators
							-- Mix cmp sorting function with cmp_lsp_rs.
							return {
								compare.recently_used,
								compare.sort_text,
								comparators.sort_by_label_but_underscore_last,
							}
						end,
					},
				},
			},
			"L3MON4D3/LuaSnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-nvim-lua",
			"kdheepak/cmp-latex-symbols",
			"onsails/lspkind.nvim",
			"olivertzeng/friendly-snippets",
			"ray-x/cmp-treesitter",
			"saadparwaiz1/cmp_luasnip",
		},
	},
	{
		"m4xshen/hardtime.nvim",
		dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
		config = function()
			require("configs.hardtime")
		end,
	},
	{
		"yutkat/git-rebase-auto-diff.nvim",
		ft = { "gitrebase" },
		opts = {},
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "benfowler/telescope-luasnip.nvim" },
		init = function()
			require("configs.luasnip")
		end,
	},

	{
		"hinell/lsp-timeout.nvim",
		dependencies = { "neovim/nvim-lspconfig" },
	},
	{
		"akinsho/git-conflict.nvim",
		version = "*",
		config = true,
		default_mappings = true,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("configs.treesitter")
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"HiPhish/rainbow-delimiters.nvim",
			{
				"nvim-treesitter/nvim-treesitter-context",
				config = function()
					require("configs.treesitter-context")
				end,
			},
		},
	},
	{
		"kevinhwang91/nvim-ufo",
		event = "VimEnter",
		dependencies = "kevinhwang91/promise-async",
		opts = {},
	},
	{
		"f4z3r/gruvbox-material.nvim",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("gruvbox-material")
		end,
	},
	{
		"tiagovla/scope.nvim",
		event = "VimEnter",
		config = function()
			require("configs.scope")
		end,
	},
	{
		"gerazov/toggle-bool.nvim",
		opts = {
			additional_toggles = {
				All = "None",
				Allow = "Deny",
				Before = "After",
				Enable = "Disable",
				Enabled = "Disabled",
				First = "Last",
				Ingress = "Egress",
				Internal = "External",
				On = "Off",
				Persistent = "Ephemeral",
				Yes = "No",
				["0"] = "1",
			},
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		dependencies = {
			"AckslD/nvim-neoclip.lua",
			"Snikimonkd/telescope-git-conflicts.nvim",
			"debugloop/telescope-undo.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-lua/popup.nvim",
			"nvim-telescope/telescope-frecency.nvim",
			"nvim-telescope/telescope-hop.nvim",
			"nvim-telescope/telescope-symbols.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
		},
		config = function()
			require("configs.telescope")
		end,
	},
	{
		"jaimecgomezz/here.term",
		config = function()
			require("configs.term")
		end,
	},

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			require("configs.which-key")
		end,
	},
	{
		"lambdalisue/suda.vim",
		config = function()
			require("configs.suda")
		end,
	},
	{
		"mawkler/modicator.nvim",
		dependencies = "f4z3r/gruvbox-material.nvim", -- Add your colorscheme plugin here
		init = function()
			require("configs.modicator")
		end,
		opts = {},
	},
	-- HACK: this looks cool
	{
		"folke/todo-comments.nvim",
		config = function()
			require("configs.todo")
		end,
	},
	{
		"linrongbin16/gitlinker.nvim",
		cmd = "GitLink",
		opts = {},
	},

	{
		"echasnovski/mini.indentscope",
		config = function()
			require("configs.indentscope")
		end,
	},
	{
		"kevinhwang91/nvim-fundo",
		require = "kevinhwang91/promise-async",
		run = function()
			require("fundo").install()
			require("fundo").setup()
		end,
	},
	{
		"max397574/better-escape.nvim",
		config = function()
			require("better_escape").setup()
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = {
			"mikesmithgh/git-prompt-string-lualine.nvim",
		},
		config = function()
			require("configs.lualine")
		end,
	},
	{
		"m4xshen/smartcolumn.nvim",
		config = function()
			require("configs.smartcolumn")
		end,
	},
	{
		"Wansmer/symbol-usage.nvim",
		event = "LspAttach",
		config = function()
			require("configs.symbols")
		end,
	},
	{
		"vyfor/cord.nvim",
		build = "./build",
		event = "VeryLazy",
		opts = {},
	},
	{
		"echasnovski/mini.icons",
		opts = {},
		lazy = true,
		init = function()
			package.preload["nvim-web-devicons"] = function()
				require("mini.icons").mock_nvim_web_devicons()
				return package.loaded["nvim-web-devicons"]
			end
		end,
	},
	{
		"OXY2DEV/helpview.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
	},
	{
		"danymat/neogen",
		config = true,
	},
	{
		"Bekaboo/dropbar.nvim",
		"OXY2DEV/markview.nvim",
		"dstein64/nvim-scrollview",
		"f-person/git-blame.nvim",
		"jghauser/mkdir.nvim",
		"jsongerber/thanks.nvim",
		"lambdalisue/suda.vim",
		"letieu/hacker.nvim",
		"rcarriga/nvim-notify",
		"tamton-aquib/duck.nvim",
		"tpope/vim-fugitive",
		"tpope/vim-rhubarb",
		"tpope/vim-sleuth",
		{ "NvChad/nvim-colorizer.lua", opts = {} },
		{ "briangwaltney/paren-hint.nvim", opts = {} },
		{ "chentoast/marks.nvim", opts = {} },
		{ "echasnovski/mini.ai", version = false, opts = {} },
		{ "folke/flash.nvim", event = "VeryLazy", opts = {} },
		{ "folke/trouble.nvim", opts = {} },
		{ "kylechui/nvim-surround", opts = {} },
		{ "nacro90/numb.nvim", opts = {} },
		{ "numToStr/Comment.nvim", event = "VeryLazy", opts = {} },
		{ "sQVe/sort.nvim", opts = {} },
		{ "smjonas/inc-rename.nvim", opts = {} },
		{ "spywhere/detect-language.nvim", opts = {} },
		{ "tzachar/highlight-undo.nvim", opts = {} },
		{ "yamatsum/nvim-cursorline", opts = {} },
	},
}, {
	performance = {
		rtp = {
			disabled_plugins = { "tohtml", "gzip", "zipPlugin", "netrwPlugin", "tarPlugin" },
		},
	},
})
