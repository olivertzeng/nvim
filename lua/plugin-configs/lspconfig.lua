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

lsp_zero.setup_servers({ "bashls", "clangd", "cssls", "lua_ls", "markdown_oxide", "marksman" })
