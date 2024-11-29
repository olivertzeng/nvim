require("lazy").setup({
	{
		"goolord/alpha-nvim",
		config = function()
			require("configs.alpha")
		end,
	},
	{
		"akinsho/bufferline.nvim",
		opts = {
			options = {
				diagnostics = "nvim_lsp",
				separator_style = "slant",
				diagnostics_indicator = function(count, level)
					local icon = level:match("error") and " " or " "
					return " " .. icon .. count
				end,
			},
		},
	},

	{
		"stevearc/dressing.nvim",
		lazy = true,
		event = "VeryLazy",
		opts = {
			input = {
				title_pos = "center",
				insert_only = false,
			},
			mappings = false,
		},
	},

	{
		"VonHeikemen/lsp-zero.nvim",
		event = "VimEnter",
		branch = "v3.x",
		dependencies = {
			"neovim/nvim-lspconfig",
			"williamboman/mason-lspconfig.nvim",
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
		"j-hui/fidget.nvim",
		opts = {
			progress = {
				display = {
					done_icon = "",
				},
			},
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("configs.lspconfig")
		end,
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{ "Bilal2453/luvit-meta", lazy = true },
	{
		"stevearc/oil.nvim",
		opts = {
			lsp_file_methods = {
				autosave_changes = true,
			},
			watch_for_changes = true,
		},
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
		build = ':lua require("go.install").update_all_sync()',
	},
	{
		"iguanacucumber/magazine.nvim",
		event = "InsertEnter",
		opts = function(_, opts)
			opts.sources = opts.sources or {}
			table.insert(opts.sources, {
				name = "lazydev",
				group_index = 0,
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
					unwanted_prefix = { "color", "ratatui::style::Styled" },
					kind = function(k)
						return { k.Module, k.Function }
					end,
					combo = {
						alphabetic_label_but_underscore_last = function()
							local comparators = require("cmp_lsp_rs").comparators
							return { comparators.sort_by_label_but_underscore_last }
						end,
						recentlyUsed_sortText = function()
							local compare = require("cmp").config.compare
							local comparators = require("cmp_lsp_rs").comparators
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
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"https://codeberg.org/FelipeLema/cmp-async-path",
			"kdheepak/cmp-latex-symbols",
			"olivertzeng/friendly-snippets",
			"onsails/lspkind.nvim",
			"ray-x/cmp-treesitter",
			"saadparwaiz1/cmp_luasnip",
			{ "iguanacucumber/mag-buffer",   name = "cmp-buffer" },
			{ "iguanacucumber/mag-cmdline",  name = "cmp-cmdline" },
			{ "iguanacucumber/mag-nvim-lsp", name = "cmp-nvim-lsp", opts = {} },
			{ "iguanacucumber/mag-nvim-lua", name = "cmp-nvim-lua" },
		},
	},
	{
		"m4xshen/hardtime.nvim",
		dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
		opts = { disable_mouse = false },
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
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"bash",
					"bibtex",
					"c",
					"cpp",
					"css",
					"csv",
					"diff",
					"git_config",
					"git_rebase",
					"gitattributes",
					"gitcommit",
					"gitignore",
					"go",
					"html",
					"javascript",
					"jsdoc",
					"json",
					"jsonc",
					"latex",
					"lua",
					"luadoc",
					"luap",
					"make",
					"markdown",
					"markdown_inline",
					"mermaid",
					"po",
					"printf",
					"python",
					"qmljs",
					"query",
					"regex",
					"rst",
					"scss",
					"toml",
					"tsx",
					"typescript",
					"vim",
					"vimdoc",
					"vue",
					"xml",
					"yaml",
				},
				highlight = { enable = true },
				incremental_selection = { enable = true },
				autotag = { enable = true },
				rainbow = { enable = true, disable = { "html" }, extended_mode = false },
				dependencies = {
					"nvim-treesitter/nvim-treesitter-textobjects",
					"HiPhish/rainbow-delimiters.nvim",
					{
						"nvim-treesitter/nvim-treesitter-context",
						opts = {
							max_lines = 1,
							multiline_threshold = 2,
						},
					},
				},
			})
			require("nvim-treesitter.install").prefer_git = true
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"HiPhish/rainbow-delimiters.nvim",
			"nvim-treesitter/nvim-treesitter-context",
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
		opts = { restore_state = true },
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
		opts = {
			startup_command = "alpha",
			mappings = {
				toggle = "<C-t>",
			},
		},
	},

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			icons = {
				breadcrumb = " ",
				separator = "󰛂 ",
				group = " ",
			},
		},
	},
	{
		"lambdalisue/suda.vim",
		config = function()
			vim.g["suda#prompt"] = " 密碼勒？？？ "
		end,
	},
	{
		"mawkler/modicator.nvim",
		dependencies = "f4z3r/gruvbox-material.nvim", -- Add your colorscheme plugin here
		opts = {
			{
				show_warnings = false,
				highlights = {
					defaults = {
						bold = true,
						italic = true,
					},
				},
			},
		},
	},
	-- HACK: this looks cool
	{
		"folke/todo-comments.nvim",
		opts = {
			highlight = {
				comments_only = false,
			},
			colors = {
				error = { "DiagnosticError", "ErrorMsg", "#fb4934" },
				warning = { "DiagnosticWarn", "WarningMsg", "#fabd2f" },
				info = { "DiagnosticInfo", "#458588" },
				hint = { "DiagnosticHint", "#83a598" },
				default = { "Identifier", "#d8a064" },
				test = { "Identifier", "#b16286" },
			},
		},
	},
	{
		"smoka7/hop.nvim",
		version = "*",
		opts = { multi_windows = true },
	},

	{
		"echasnovski/mini.indentscope",
		opts = { symbol = "╎" },
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
		"Bekaboo/dropbar.nvim",
		"OXY2DEV/helpview.nvim",
		"OXY2DEV/markview.nvim",
		"dstein64/nvim-scrollview",
		"f-person/git-blame.nvim",
		"hinell/lsp-timeout.nvim",
		"jghauser/mkdir.nvim",
		"jsongerber/thanks.nvim",
		"lambdalisue/suda.vim",
		"letieu/hacker.nvim",
		"neovim/nvim-lspconfig",
		"rcarriga/nvim-notify",
		"tamton-aquib/duck.nvim",
		"tpope/vim-sleuth",
		"trevorhauter/gitportal.nvim",
		{ "NvChad/nvim-colorizer.lua",     opts = {} },
		{ "briangwaltney/paren-hint.nvim", opts = {} },
		{ "chentoast/marks.nvim",          opts = {} },
		{ "danymat/neogen",                config = true },
		{ "echasnovski/mini.ai",           version = false,       opts = {} },
		{ "folke/trouble.nvim",            opts = {} },
		{ "kylechui/nvim-surround",        opts = {} },
		{ "linrongbin16/gitlinker.nvim",   cmd = "GitLink",       opts = {} },
		{ "nacro90/numb.nvim",             opts = {} },
		{ "numToStr/Comment.nvim",         event = "VeryLazy",    opts = {} },
		{ "nvchad/menu",                   lazy = true },
		{ "nvchad/minty",                  lazy = true },
		{ "nvchad/showkeys",               cmd = "ShowkeysToggle" },
		{ "nvchad/volt",                   lazy = true },
		{ "sQVe/sort.nvim",                opts = {} },
		{ "smjonas/inc-rename.nvim",       opts = {} },
		{ "spywhere/detect-language.nvim", opts = {} },
		{ "tzachar/highlight-undo.nvim",   opts = {} },
		{ "williamboman/mason.nvim",       opts = {} },
		{ "yamatsum/nvim-cursorline",      opts = {} },
	},
}, {
	performance = {
		rtp = {
			disabled_plugins = { "tohtml", "gzip", "zipPlugin", "netrwPlugin", "tarPlugin" },
		},
	},
})
