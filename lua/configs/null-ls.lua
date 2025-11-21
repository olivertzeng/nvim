local null_ls = require("null-ls")
-- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
	sources = {
		null_ls.builtins.code_actions.gitrebase,
		null_ls.builtins.code_actions.gitsigns,
		null_ls.builtins.completion.luasnip,
		null_ls.builtins.diagnostics.gitlint,
		null_ls.builtins.diagnostics.revive,
		null_ls.builtins.diagnostics.staticcheck,
		null_ls.builtins.diagnostics.stylelint,
		null_ls.builtins.formatting.biome,
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.cbfmt,
		null_ls.builtins.formatting.clang_format,
		null_ls.builtins.formatting.goimports_reviser,
		null_ls.builtins.formatting.isort,
		null_ls.builtins.formatting.shfmt,
		null_ls.builtins.formatting.stylelint,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.hover.dictionary,
	},
	-- on_attach = function(client, bufnr)
	-- 	if client.supports_method("textDocument/formatting") then
	-- 		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
	-- 		vim.api.nvim_create_autocmd("BufWritePre", {
	-- 			group = augroup,
	-- 			buffer = bufnr,
	-- 			callback = function()
	-- 				vim.lsp.buf.format()
	-- 			end,
	-- 		})
	-- 	end
	-- end,
})
