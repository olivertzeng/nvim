local lsp_zero = require("lsp-zero")
lsp_zero.extend_lspconfig()
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.offsetEncoding = { "utf-16" }
capabilities.textDocument.completion.completionItem.snippetSupport = true

require("lspconfig").basedpyright.setup({
	capabilities = capabilities,
	settings = {
		basedpyright = {
			analysis = {
				typeCheckingMode = "basic",
			},
		},
	},
})

require("lspconfig").biome.setup({
	capabilities = capabilities,
	settings = {
		formatter = {
			indentWidth = 4,
		},
	},
})

lsp_zero.setup_servers({
	"basedpyright",
	"bashls",
	"biome",
	"clangd",
	"css_variables",
	"cssls",
	"gopls",
	"lua_ls",
	"markdown_oxide",
	"marksman",
})
