local enabled = require("core.utils").enabled

local group = {}

require("lazy").setup({
	{
		"stevearc/aerial.nvim",
		cond = enabled(group, "aerial"),
		cmd = "AerialToggle",
		config = function()
			require("plugin-configs.aerial")
		end,
	},
	{
		"goolord/alpha-nvim",
		cond = enabled(group, "alpha"),
		config = function()
			require("plugin-configs.alpha")
		end,
	},
	{
		"akinsho/bufferline.nvim",
		cond = enabled(group, "bufferline"),
		config = function()
			require("plugin-configs.bufferline")
		end,
	},
	{
		"numToStr/Comment.nvim",
		cond = enabled(group, "comment"),
		event = "VeryLazy",
		opts = {},
	},
	{
		"stevearc/dressing.nvim",
		lazy = true,
		cond = enabled(group, "dressing"),
		event = "VeryLazy",
		config = function()
			require("plugin-configs.dressing")
		end,
	},
	{
		"smoka7/hop.nvim",
		version = "*",
		cond = enabled(group, "hop"),
		event = "VimEnter",
		config = function()
			require("plugin-configs.hop")
		end,
	},
	{
		"VonHeikemen/lsp-zero.nvim",
		cond = enabled(group, "lsp_zero"),
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
		cond = enabled(group, "gitsigns"),
		event = "VimEnter",
		config = function()
			require("plugin-configs.gitsigns")
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
			require("plugin-configs.fidget")
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("plugin-configs.lspconfig")
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
		-- Optional dependencies
		dependencies = { "echasnovski/mini.icons" },
		config = function()
			require("plugin-configs.oil")
		end,
	},
	{
		"folke/noice.nvim",
		cond = enabled(group, "noice"),
		event = "VimEnter",
		config = function()
			require("plugin-configs.noice")
		end,
		dependencies = { "MunifTanjim/nui.nvim" },
	},
	{
		"nvimtools/none-ls.nvim",
		cond = enabled(group, "null_ls"),
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("plugin-configs.null-ls")
		end,
		dependencies = {
			{
				"jay-babu/mason-null-ls.nvim",
				cmd = { "NullLsInstall", "NullLsUninstall" },
				config = function()
					require("plugin-configs.mason-null-ls")
				end,
			},
		},
	},
	{
		"windwp/nvim-autopairs",
		cond = enabled(group, "autopairs"),
		event = "InsertEnter",
		config = function()
			require("plugin-configs.autopairs")
		end,
	},
	{
		"moyiz/command-and-cursor.nvim",
		event = "VeryLazy",
		opts = {},
	},
	{
		"hrsh7th/nvim-cmp",
		cond = enabled(group, "cmp"),
		event = "InsertEnter",
		opts = function(_, opts)
			opts.sources = opts.sources or {}
			table.insert(opts.sources, {
				name = "lazydev",
				group_index = 0, -- set group index to 0 to skip loading LuaLS completions
			})
		end,
		config = function()
			require("plugin-configs.cmp")
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
			"mireq/luasnip-snippets",
			"kdheepak/cmp-latex-symbols",
			"onsails/lspkind.nvim",
			"rafamadriz/friendly-snippets",
			"ray-x/cmp-treesitter",
			"saadparwaiz1/cmp_luasnip",
		},
	},
	{
		"m4xshen/hardtime.nvim",
		dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
		config = function()
			require("plugin-configs.hardtime")
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
			require("plugin-configs.luasnip")
		end,
	},
	{
		"tamton-aquib/duck.nvim",
		cond = enabled(group, "duck"),
		opts = {},
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
		"rcarriga/nvim-notify",
		cond = enabled(group, "notify"),
	},
	{
		"kylechui/nvim-surround",
		cond = enabled(group, "surround"),
		opts = {},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		cond = enabled(group, "treesitter"),
		event = { "BufReadPost", "BufNewFile" },
		run = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
		config = function()
			require("plugin-configs.treesitter")
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"nvim-treesitter/nvim-treesitter-context",
			"windwp/nvim-ts-autotag",
			"HiPhish/rainbow-delimiters.nvim",
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
	},
	{
		"kevinhwang91/nvim-ufo",
		cond = enabled(group, "ufo"),
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
		cond = enabled(group, "scope"),
		event = "VimEnter",
		config = function()
			require("plugin-configs.scope")
		end,
	},
	{
		"gerazov/toggle-bool.nvim",
		config = function()
			require("plugin-configs.bool")
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		cond = enabled(group, "telescope"),
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
			require("plugin-configs.telescope")
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		cond = enabled(group, "toggleterm"),
		event = "VeryLazy",
		config = function()
			_G.term = require("plugin-configs.toggleterm")
		end,
	},
	{
		"wildfunctions/myeyeshurt",
		cond = enabled(group, "myeyeshurt"),
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("plugin-configs.myeyeshurt")
		end,
	},
	{
		"folke/trouble.nvim",
		dependencies = "echasnovski/mini.icons",
		cond = enabled(group, "trouble"),
		opts = {},
	},
	{
		"folke/which-key.nvim",
		cond = enabled(group, "whichkey"),
		event = "VeryLazy",
		config = function()
			require("plugin-configs.which-key")
		end,
	},
	{
		"lambdalisue/suda.vim",
		cond = enabled(group, "suda"),
		config = function()
			require("plugin-configs.suda")
		end,
	},
	{
		"mawkler/modicator.nvim",
		dependencies = "f4z3r/gruvbox-material.nvim", -- Add your colorscheme plugin here
		init = function()
			require("plugin-configs.modicator")
		end,
		opts = {},
	},
	-- HACK: this looks cool
	{
		"folke/todo-comments.nvim",
		config = function()
			require("plugin-configs.todo")
		end,
	},
	{
		"linrongbin16/gitlinker.nvim",
		cond = enabled(group, "aerial"),
		lazy = false,
		cmd = "GitLink",
		opts = {},
	},

	{
		"echasnovski/mini.indentscope",
		config = function()
			require("plugin-configs.indentscope")
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
			"echasnovski/mini.icons",
			"mikesmithgh/git-prompt-string-lualine.nvim",
		},
		config = function()
			require("plugin-configs.lualine")
		end,
	},
	{
		"m4xshen/smartcolumn.nvim",
		config = function()
			require("plugin-configs.smartcolumn")
		end,
	},
	{
		"Wansmer/symbol-usage.nvim",
		event = "LspAttach",
		config = function()
			require("plugin-configs.symbols")
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
		"MeanderingProgrammer/markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
		config = function()
			require("render-markdown").setup()
		end,
	},
	{
		"Bekaboo/dropbar.nvim",
		"dstein64/nvim-scrollview",
		"f-person/git-blame.nvim",
		"jghauser/mkdir.nvim",
		"jsongerber/thanks.nvim",
		"lambdalisue/suda.vim",
		"tpope/vim-fugitive",
		"tpope/vim-rhubarb",
		"tpope/vim-sleuth",
		{ "NvChad/nvim-colorizer.lua", opts = {} },
		{ "briangwaltney/paren-hint.nvim", opts = {} },
		{ "chentoast/marks.nvim", opts = {} },
		{ "nacro90/numb.nvim", opts = {} },
		{ "sQVe/sort.nvim", opts = {} },
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
