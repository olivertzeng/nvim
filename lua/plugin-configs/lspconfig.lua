local lsp_zero = require("lsp-zero")
lsp_zero.extend_lspconfig()
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.offsetEncoding = { "utf-16" }

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

lsp_zero.setup_servers({ "bashls", "clangd", "texlab", "lua_ls", "markdown_oxide", "marksman" })
