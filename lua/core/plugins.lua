require("lazy").setup({
	-- {
	-- 	"OXY2DEV/markview.nvim",
	-- 	config = function(plugin, opts)
	-- 		-- Force markview.nvim to be sourced before everything else
	-- 		vim.opt.rtp:prepend(plugin.dir)
	--
	-- 		-- Set up the plugin
	-- 		require("markview").setup(opts)
	-- 	end,
	-- 	event = "InsertEnter",
	-- 	ft = { "markdown", "html", "tex", "plaintex", "typst", "yaml" },
	-- 	lazy = false,
	-- },
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
	{
		"A7Lavinraj/fyler.nvim",
		dependencies = { "echasnovski/mini.icons" },
		opts = { views = { explorer = { default_explorer = true } } },
	},
	{
		"alex-popov-tech/store.nvim",
		dependencies = {
			"OXY2DEV/markview.nvim",
		},
		cmd = "Store",
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
		"shahshlok/vim-coach.nvim",
		dependencies = {
			"folke/snacks.nvim",
		},
		config = function()
			require("vim-coach").setup()
		end,
		keys = {
			{ "<leader>?", "<cmd>VimCoach<cr>", desc = "Vim Coach" },
		},
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
		opts = {
			highlights = {
				incoming = "DiffAdd",
				current = "DiffChange",
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"HiPhish/rainbow-delimiters.nvim",
			"nvim-treesitter/nvim-treesitter-context",
		},
		config = function()
			---@diagnostic disable-next-line: missing-fields
			require("nvim-treesitter").setup({
				ensure_installed = {
					"bash",
					"bibtex",
					"c",
					"caddy",
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
					"requirements",
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
			})
		end,
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
		"nvzone/typr",
		dependencies = "nvzone/volt",
		opts = {},
		cmd = { "Typr", "TyprStats" },
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
		"NvChad/nvim-colorizer.lua",
		opts = {
			user_default_options = {
				RRGGBBAA = true,                   -- #RRGGBBAA hex codes
				AARRGGBB = true,                   -- 0xAARRGGBB hex codes
				rgb_fn = true,                     -- CSS rgb() and rgba() functions
				hsl_fn = true,                     -- CSS hsl() and hsla() functions
				css = true,                        -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
				css_fn = true,                     -- Enable all CSS *functions*: rgb_fn, hsl_fn
				mode = "background",               -- Set the display mode.
				tailwind = true,                   -- Enable tailwind colors
				sass = { enable = true, parsers = { "css" } }, -- Disable sass colors
			},
		},
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
		"stevearc/oil.nvim",
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {},
		-- Optional dependencies
		dependencies = { { "nvim-mini/mini.icons", opts = {} } },
		-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
		-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
		lazy = false,
	},
	-- {
	-- 	"NickvanDyke/opencode.nvim",
	-- 	dependencies = {
	-- 		-- Recommended for `ask()` and `select()`.
	-- 		-- Required for `snacks` provider.
	-- 		---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
	-- 		{ "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
	-- 	},
	-- 	config = function()
	-- 		---@type opencode.Opts
	-- 		vim.g.opencode_opts = {
	-- 			-- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition" on the type or field.
	-- 		}
	--
	-- 		-- Required for `opts.events.reload`.
	-- 		vim.o.autoread = true
	--
	-- 		-- Recommended/example keymaps.
	-- 		vim.keymap.set({ "n", "x" }, "<C-a>", function() require("opencode").ask("@this: ", { submit = true }) end,
	-- 			{ desc = "Ask opencode…" })
	-- 		vim.keymap.set({ "n", "x" }, "<C-x>", function() require("opencode").select() end,
	-- 			{ desc = "Execute opencode action…" })
	-- 		vim.keymap.set({ "n", "t" }, "<C-.>", function() require("opencode").toggle() end,
	-- 			{ desc = "Toggle opencode" })
	--
	-- 		vim.keymap.set({ "n", "x" }, "go", function() return require("opencode").operator("@this ") end,
	-- 			{ desc = "Add range to opencode", expr = true })
	-- 		vim.keymap.set("n", "goo", function() return require("opencode").operator("@this ") .. "_" end,
	-- 			{ desc = "Add line to opencode", expr = true })
	--
	-- 		vim.keymap.set("n", "<S-C-u>", function() require("opencode").command("session.half.page.up") end,
	-- 			{ desc = "Scroll opencode up" })
	-- 		vim.keymap.set("n", "<S-C-d>", function() require("opencode").command("session.half.page.down") end,
	-- 			{ desc = "Scroll opencode down" })
	--
	-- 		-- You may want these if you stick with the opinionated "<C-a>" and "<C-x>" above — otherwise consider "<leader>o…".
	-- 		vim.keymap.set("n", "+", "<C-a>", { desc = "Increment under cursor", noremap = true })
	-- 		vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement under cursor", noremap = true })
	-- 	end,
	-- },
	{
		"Bekaboo/dropbar.nvim",
		"OXY2DEV/helpview.nvim",
		"dstein64/nvim-scrollview",
		"f-person/git-blame.nvim",
		"folke/snacks.nvim",
		"hinell/lsp-timeout.nvim",
		"jghauser/mkdir.nvim",
		"jsongerber/thanks.nvim",
		"letieu/hacker.nvim",
		"rcarriga/nvim-notify",
		"tpope/vim-sleuth",
		"trevorhauter/gitportal.nvim",
		"vuciv/golf",
		{ "briangwaltney/paren-hint.nvim", opts = {} },
		{ "chentoast/marks.nvim",          opts = {} },
		{ "danymat/neogen",                config = true },
		{ "echasnovski/mini.ai",           version = false,                          opts = {} },
		{ "esmuellert/vscode-diff.nvim",   dependencies = { "MunifTanjim/nui.nvim" } },
		{ "folke/trouble.nvim",            opts = {} },
		{ "kylechui/nvim-surround",        opts = {} },
		{ "linrongbin16/gitlinker.nvim",   cmd = "GitLink",                          opts = {} },
		{ "lnus/fencey.nvim",              opts = {} },
		{ "nacro90/numb.nvim",             opts = {} },
		{ "numToStr/Comment.nvim",         event = "VeryLazy",                       opts = {} },
		{ "nvchad/menu",                   lazy = true },
		{ "nvchad/minty",                  lazy = true },
		{ "nvchad/showkeys",               cmd = "ShowkeysToggle" },
		{ "nvchad/volt",                   lazy = true },
		{ "sQVe/sort.nvim",                opts = {} },
		{ "smjonas/inc-rename.nvim",       opts = {} },
		{ "sphamba/smear-cursor.nvim",     opts = {} },
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
