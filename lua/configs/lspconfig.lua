-- lspconfig.lua (for Neovim 0.11+)
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.offsetEncoding = { "utf-16" }
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Configure servers using vim.lsp.config
vim.lsp.config.basedpyright = {
	capabilities = capabilities,
	settings = {
		basedpyright = {
			analysis = {
				typeCheckingMode = "basic",
			},
		},
	},
}

vim.lsp.config.biome = {
	capabilities = capabilities,
	settings = {
		formatter = {
			indentWidth = 4,
		},
	},
}

-- Simple servers with default config
local simple_servers = {
	"bashls",
	"clangd",
	"css_variables",
	"cssls",
	"gopls",
	"lua_ls",
	"markdown_oxide",
	"marksman",
}

for _, server in ipairs(simple_servers) do
	vim.lsp.config[server] = {
		capabilities = capabilities,
	}
end

-- Enable the servers
vim.lsp.enable({
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
