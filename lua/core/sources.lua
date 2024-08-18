-- use a user-config.lua file to provide your own configuration

local M = {}

-- add any null-ls sources you want here
M.setup_sauces = function(b)
	return {
		b.code_actions.gitrebase,
		b.code_actions.gitsigns,
		b.completion.luasnip,
		b.diagnostics.gitlint,
		b.diagnostics.stylelint,
		b.formatting.biome,
		b.formatting.black,
		b.formatting.cbfmt,
		b.formatting.clang_format,
		b.formatting.isort,
		b.formatting.shfmt,
		b.formatting.stylelint,
		b.formatting.stylua,
		b.hover.dictionary,
	}
end

-- add null_ls sources to auto-install
M.ensure_installed = {
	null_ls = {
		"bash-language-server",
		"beautysh",
		"biome",
		"black",
		"cbfmt",
		"clang_format",
		"clangd",
		"gitlint",
		"gitrebase",
		"gitsigns",
		"isort",
		"lua-language-server",
		"luasnip",
		"markdown-oxide",
		"markdown-toc",
		"markdownlint-cli2",
		"marksman",
		"shfmt",
		"stylelint",
		"stylua",
		"texlab",
	},
}

M.formatting_servers = {
	["null-ls"] = {
		"bash",
		"cpp",
		"lua",
		"markdown",
		"python",
		"sh",
		"txt",
		"zsh",
	},
}

return M
